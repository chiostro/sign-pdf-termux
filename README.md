# Sign PDF on Termux

A small collection of scripts that let you add a raster signature image to a PDF
directly from an Android device using Termux.

## Features
- Bash script (`signpdf.sh`) using ImageMagick & pdftk & poppler
- Works completely offline, no paid apps required


## Prerequisites (Termux)

Before installing the project, make sure you have **Termux** installed on your Android device. You can download it from the [Google Play Store](https://play.google.com/store/apps/details?id=com.termux) or from [Termux GitHub](https://github.com/termux/termux-app).

## Installation on Termux

1. **Install Termux** from the Play Store or F-Droid (if you haven't done it yet).
2. **Update Termux packages**:

    ```bash
    pkg update && pkg upgrade
    ```

3. ** Let Termux read and write on your download folder**:

    ```bash
    termux-setup-storage
    cd  /storage/emulated/0/Download/

    ```

4 **Install necessary dependencies** 

     ```bash
     
    pkg install git
    pkg install imagemagick
    pkg install pdftk
    pkg install poppler 
    
    ```

5. **Clone the project repository**:

    ```bash
    git clone https://github.com/chiostro/sign-pdf-termux.git
    cd  sign-pdf-termux
    ```

6. **Run the project** :

To test script signpdf.sh as a DEMO, parameters [file.pdf filesignature.png pagestotal pagetosign resizesignature wheretoputsignatureinpixel] are not requested
    ```bash
     sh signpdf.sh 
    ```
 The file pds and png will be used.
 Example sh signpdf.sh document.pdf signed.png 2 2 30 +130+1610
 
## Usage

     bash script you can run without parameters
     for default as test it will overwrite the original pdf in the folder with the signature of Napoleone, printing a new file with the suffix "signed_".
     For the porpose:
     Make a picture of you signature, move the picture to download folder of mobile
     Copy your dounloaded document pdf file and signature.jpg from /storage/emulated/0/Download/ to  ~/sign-pdf-termux
     ex. cd ~/sign-pdf-termux 
         cp /storage/emulated/0/Download/Document.pdf .
         cp /storage/emulated/0/Download/signature.jpg .
         transform jpg in png using magick command
         magick signature.jpg signature.png
         sh signpdf.sh Document.pdf signature.png 2 2 30 +130+1610 #  x & y  Cartesian position is expressed in pixels.  Signature will be placed near the left side of the page, up about 1/4 of page A4
         Check the result, change the coordinates, if your signature is not cleare edit signpdf.sh and replace white with grey, using vi or  nano or sed

## License

This project is licensed under the MIT License - see the [LICENSE file](LICENSE) for details.


## NOTE

The raster signature is not a qualified digital signature (PKI). It's more like a graphic markup, so it has no legal value in contexts requiring certified electronic signatures, like:

Firma Elettronica Semplice (FES)
Firma Elettronica Avanzata (FEA)
Firma Elettronica Qualificata (FEQ), identified like Firma Digitale (FD).



If you're familiar with the command prompt and need to insert a signature at the bottom of a single-page PDF, you can convert the PDF to PNG.


The first command is magick (convert is deprecate), which receives your .pdf  to create your .png, e.g.:
    
    ```bash
    
    magick pag2.pdf page2-1.png
    ```

The script signpdf.sh creates the support files, so you can use them.

This command inserts the photo at the bottom center:

    ```bash
    
    composite -compose over -gravity South -geometry +0+0 new.png page2-1.png result.png
    ```
Then you need to convert it back to PDF:

    ```bash
    
    magick result.png result.pdf
    ```

This inserts at the bottom right:


    
    composite -compose over -gravity SouthEast -geometry +0+0 new.png page2-1.png result.png 
    

I'll leave you to imagine the other parameters for inserting the photo at the top right, bottom left, etc.


