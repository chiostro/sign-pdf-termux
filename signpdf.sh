#!/bin/bash
# Shell created by Andrea Noto
# 05 Sep 2025
# Sign on a white paper and take a picture of your signature
# Try to save only a rectangle containing your signature
# Copy document to sign under same folder of shell
# transform yourpicsgnature.jpg in .png using this commmand:
# magick file.jpg file.png

test  $# != 6  && echo "Syntax: $0 pdforigin signedpng totpage pagetosign resizesign% wheretosigninpixel 
ex.: $0  document.pdf signed.png 2 2 30 +130+1610"
if [ $# -gt 0 ] && [ $# -lt 6 ];then
    exit 0
fi
#Parameters setting
pdfname=${1:-non-belligerence_pact.pdf}
signpng=${2:-napoleone.png}
numpage=${3:-2}
pagetosign=${4:-2}
resize=${5:-30}
coord=${6:-"+130+350"}
#Check files
test ! -f $pdfname && echo "PDF notte fonda" && exit 1
test ! -f $signpng && echo "PNG notte fonda" && exit 1
#Workin area cration
swdir=`pwd`/
wkpath=${swdir}tmp/
test ! -d $wkpath &&  mkdir $wkpath
#Split the document in n pages
i=1
while [ $i -le $numpage ]
do
    pdftk $pdfname  cat $i  output ${wkpath}pag$i.pdf
    i=`expr $i + 1`
done
cd $wkpath
#Transforn pdf in png
pdftoppm -png pag${pagetosign}.pdf page${pagetosign}

# Exclude background
magick  $signpng  -fuzz 13% -transparent white immagine_trasparente.png
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
pdftk $command cat output ${swdir}signed_${pdfname}
#Remove working area files
shred -vuz -n 3 *
cd ..
