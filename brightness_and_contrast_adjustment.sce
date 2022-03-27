clc
clear
close(winsid())//kills all figures (images)

Iin = imread('src/Lena.bmp');
[row col deep]=size(Iin); //input image sizes
Iin=double(Iin); //the precision change - forces the use of uint8

imshow(uint8(Iin));

contrast = 0.55;
brightness = 110;

//Lena - basic geometric transformation (1 of 8 possible)
Iout=Iin;
for r=1:row
    for c=1:col
        for d=1:deep
            Iout(r,c,d)=Iin(r,col-c+1,d);
            newImage(r,c,d) = (contrast * Iout(r,c,d)) + brightness
            
            // I tried to do Clamping 
            if newImage(r,c,d) > 255 then
                newImage(r,c,d) = 255
            end;
            if newImage(r,c,d) < 0 then
                newImage(r,c,d) = 0
            end;
        end;
    end;
end;

// newImage = (contrast * Iout) + brightness 

sleep(400); //pause in milliseconds
// imshow(uint8(Iout));
imshow(uint8(newImage));
