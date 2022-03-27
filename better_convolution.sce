clc
clear
close(winsid());

img = imread("src/lena.bmp");
img = double(img);
img_gray = rgb2gray(img);
[i_row i_col i_deep] = size(img);

my_kernel = [1 2 1; 2 4 2; 1 2 1;];
k_size = size(my_kernel)(1);
k_center = round(k_size / 2);
k_sum = sum(my_kernel);

output = img_gray;

for i=k_center:i_row - k_center + 1
    for j=k_center:i_col - k_center + 1
        
        output(i,j) =  sum(img_gray(i-k_center+1:i+k_center-1, j-k_center+1:j+k_center-1).*my_kernel) / k_sum;
        
    end;
end;

figure(1);
title("Original")
imshow(uint8(img_gray));

figure(2);
title("Spatial Gaussian Filtered")
imshow(uint8(output));
