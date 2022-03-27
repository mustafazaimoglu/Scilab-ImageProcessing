clc
clear
close(winsid());

img = imread("src/lena.bmp");
img = double(img);
img_gray = rgb2gray(img);
[i_row i_col i_deep] = size(img);

/*
sigma = 1
N = 3;
gaussian_kernel = zeros(N,N)
for x = 1 - round(N/2):round(N/2) - 1
    for y = 1 - round(N/2):round(N/2) - 1
        gaussian_kernel(x + round(N/2),y + round(N/2)) = exp(-(x*x+y*y) / (2*sigma*sigma));
    end;
end;
*/

gaussian_kernel = [1 2 1; 2 4 2; 1 2 1;];
k_size = size(gaussian_kernel)(1);
k_center = round(k_size / 2);
k_sum = sum(gaussian_kernel);

gaussian_output = img_gray;

for i=k_center:i_row - k_center + 1
    for j=k_center:i_col - k_center + 1
        total = 0;
        
        for k_i = 1 - k_center:k_center - 1
            for k_j = 1 - k_center:k_center - 1
                total = total + img_gray(i + k_i, j + k_j) * gaussian_kernel(k_i + k_center,k_j + k_center);
            end;
        end;
        
        gaussian_output(i,j) = total / k_sum;
    end;
end;

figure(1);
title("Original")
imshow(uint8(img_gray));

figure(2);
title("Spatial Gaussian Filtered")
imshow(uint8(gaussian_output));
