clc
clear
close(winsid());

img = imread("src/lena.bmp");
img = double(img);
img_gray = rgb2gray(img);
[i_row i_col i_deep] = size(img);

binomial_kernel = [1 4 6 4 1;
                   4 16 24 16 4;
                   6 24 36 24 6;
                   4 16 24 16 4;
                   1 4 6 4 1;];

k_size = size(binomial_kernel)(1);
k_center = round(k_size / 2);
k_sum = sum(binomial_kernel);

binomial_output = img_gray;

for i=k_center:i_row - k_center + 1
    for j=k_center:i_col - k_center + 1
        total = 0;
        
        for k_i = 1-k_center:k_center - 1
            for k_j = 1-k_center:k_center - 1
                total = total + img_gray(i + k_i, j + k_j) * binomial_kernel(k_i + k_center,k_j + k_center);
            end;
        end;
        
        binomial_output(i,j) = total / k_sum;
    end;
end;

figure(1);
title("Original")
imshow(uint8(img_gray));

figure(2);
title("Binomial Filtered")
imshow(uint8(binomial_output));
