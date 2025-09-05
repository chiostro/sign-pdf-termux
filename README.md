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
    ls  /storage/emulated/0/Download/

    ```

4 **Install necessary dependencies** (if any, such as `git`, `pdftk`, etc.):

    ```bash
pkg install git
pkg install imagemagick
pkg install pdftk
pkg instsll poppler
    ```

4. **Clone the project repository**:

    ```bash
    git clone https://github.com/chiostro/sign-pdf-termux.git
    cd signpdf
    ```

5. **Run the project** :


    ```bash
     sh signpdf.sh file.pdf filesignature.png pagestotal pagetisign resizesignature wheretoputsignatureinpixel
    ```

## Usage

     bash script you can run without parameters
     for default as test it will overwrite the original pdf in the folder with the signature of Napoleone, printing a new file with the suffix "signed_"

## License

This project is licensed under the MIT License - see the [LICENSE file](LICENSE) for details.


