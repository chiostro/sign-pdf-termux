# Using the command "identify" CaterinaII.png, you get info like how many pixels in the pic
# Using command "magick" your_pic.png, you cut frame starting from position of pixels +450+280, getting a  rectangle of lenght hight 420x195  

magick CaterinaII.png -crop 420x195+450+280 +repage left_half.png

# Using command "termux-open"  left_half.png , Andorid will ask you to use your defult app 