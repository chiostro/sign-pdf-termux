#!/bin/bash
# Shell created by Andrea Noto
# 05 Sep 2025
# Sign on a white paper and take a picture of your signature
# Try to save only a rectangle containing your signature
# Copy document to sign under same folder of shell
# transform yourpicsgnature.jpg in .png using this commmand:
# magick file.jpg file.png

test  $# != 6  && echo "Syntax:
$0 pdf_origin signed_png backgound_color[w|g] page_to_sign resize_sign% where_to_sign_in_pixel  
e.g.: 
$0  document.pdf signed.png w 2 30 +130+950  
"
if [ $# -gt 0 ] && [ $# -lt 6 ];then
    exit 0
fi
#Parameters setting
pdfname=${1:-non-belligerence_pact.pdf}
signpng=${2:-napoleone.png}
whitegrey=${3:-"w"}
pagetosign=${4:-2}
resize=${5:-30}
coord=${6:-"+130+950"}
#Check files
test ! -f $pdfname && echo "PDF notte fonda" && exit 1
test ! -f $signpng && echo "PNG notte fonda" && exit 1
numpage=`pdfinfo $pdfname | grep Pages | awk '{print $2}'`

if [ $pagetosign -gt $numpage  ] || [ $pagetosign -lt 1 ];then
    echo "Page to sign is out of range. Num of PDF pg is $numpage " && exit 1
fi


#Split the document in n pages
i=1
while [ $i -le $numpage ]
do
    pdftk $pdfname  cat $i  output pag$i.pdf
    i=`expr $i + 1`
done

#Transforn pdf in png
pdftoppm -png pag${pagetosign}.pdf page${pagetosign}

#Check signaure position inside pdf
dim=`identify page${pagetosign}-1.png |awk '{ gsub(/x/, " ", $3);print $3}'`
l=`echo $dim|awk '{ print $1}' `
h=`echo $dim|awk '{ print $2}' `
xy=`echo $coord|awk '{gsub(/+/, " ", $1);print $1}'`
x=`echo $xy|awk '{ print $1}' `
y=`echo $xy|awk '{ print $2}' `
test $x -gt $l && echo "Coordinates error!" && exit 1
test $y -gt $h && echo "Coordinates error!" && exit 1

# Exclude background
test "$whitegrey" = "w" && backgrou="white" || backgrou="grey" 
magick  $signpng  -fuzz 13% -transparent $backgrou immagine_trasparente.png
#Resize your signature
magick immagine_trasparente.png -resize $resize% new.png
#Overwrite page to sign
composite -compose over -geometry $coord new.png page${pagetosign}-1.png pag${pagetosign}_modi.png
#Transform png in pdf
magick pag${pagetosign}_modi.png pag${pagetosign}_modi.pdf
#Build str to Join pages
command=""
i=1
while [ $i -le $numpage ]
do
    if [ $i -eq $pagetosign ]
    then 
       command="$command pag${pagetosign}_modi.pdf " 
    else
       command="$command pag$i.pdf " 
    fi
    i=`expr $i + 1`
done
#Print pdf with new name
PDF_signed=`basename $pdfname`
echo
echo "Original file to sign: $PDF_signed"
echo "Creating signed file: "
pdftk $command cat output signed_${PDF_signed}
test ! -f  signed_${PDF_signed}&& echo "Error creating signed file! "&& exit 1
ls signed_${PDF_signed}
echo
test -d $DownloadPath && echo " Copy and paste the following command: 
cp signed_${PDF_signed} $DownloadPath"
exit 0
