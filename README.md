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
    pkg instsll poppler  
    ```

5. **Clone the project repository**:

    ```bash
    git clone https://github.com/chiostro/sign-pdf-termux.git
    cd  sign-pdf-termux
    ```

6. **Run the project** :


    ```bash
     sh signpdf.sh file.pdf filesignature.png pagestotal pagetosign resizesignature wheretoputsignatureinpixel
    ```
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



