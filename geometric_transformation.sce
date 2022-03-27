clc
clear
close(winsid())//kills all figures (images)

Iin = imread('src/Lena.bmp');
[row col deep]=size(Iin); //input image sizes
Iin=double(Iin); //the precision change - forces the use of uint8

// show_window(1);
imshow(uint8(Iin));

//Lena - basic geometric transformation (1 of 8 possible)
Iout=Iin;
for r=1:row
    for c=1:col
        for d=1:deep
            Iout_original(r,c,d) = Iin(r,c,d);
            Iout_1(r,c,d) = Iin(r,col-c+1,d);
            Iout_2(r,c,d) = Iin(row-r+1,c,d);
            Iout_3(r,c,d) = Iin(row-r+1,col-c+1,d);
            Iout_4(r,c,d) = Iin(c,r,d);
            Iout_5(r,c,d) = Iin(c,row-r+1,d);
            Iout_6(r,c,d) = Iin(col-c+1,r,d);
            Iout_7(r,c,d) = Iin(col-c+1,row-r+1,d);
        end;
    end;
end;

sleep(700); //pause in milliseconds
imshow(uint8(Iout_original));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_1));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_2)); 
sleep(700); //pause in milliseconds
imshow(uint8(Iout_3));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_4));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_5));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_6));
sleep(700); //pause in milliseconds
imshow(uint8(Iout_7));


