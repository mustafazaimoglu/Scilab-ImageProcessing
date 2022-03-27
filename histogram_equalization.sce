clc
clear
close(winsid())//kills all figures (images)

img = imread("src/chest-xray_LC.bmp");
img_gray = rgb2gray(img);
[row col] = size(img_gray); 
img_gray = double(img_gray); //the precision change - forces the use of uint8

histogram = zeros(1,256);
cumulative = zeros(1,256);

for r=1:row
    for c=1:col
        histogram(img_gray(r,c)+1) = histogram(img_gray(r,c)+1) + 1;
    end;
end;

cumulative(1) = histogram(1);
for i=2:256
    cumulative(i) = cumulative(i-1) + histogram(i);
end

result_img = img_gray;
for r=1:row
    for c=1:col
       result_img(r,c) = (255 * cumulative(img_gray(r,c) + 1)) / cumulative(256)
    end;
end;

// disp(hist);
imshow(uint8(img_gray)); 
sleep(750);
imshow(uint8(result_img)); 
