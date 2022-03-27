clc
clear
close(winsid());

img = imread("src/noise2.bmp");
img = double(img);
img_gray = img; // img already gray
[i_row i_col i_deep] = size(img);

threshold = 4;

k_size = 5;
k_center = round(k_size / 2);

outlier_output = img_gray;

for i=k_center:i_row - k_center + 1
    for j=k_center:i_col - k_center + 1
        total = 0;
        
        for k_i = 1-k_center:k_center - 1
            for k_j = 1-k_center:k_center - 1
                total = total + img_gray(i + k_i, j + k_j);
            end;
        end;
 
        if abs(img_gray(i,j) - (total / (k_size * k_size))) > threshold then
            outlier_output(i,j) = (total - img_gray(i,j)) / ((k_size * k_size) - 1);
        else
            outlier_output(i,j) = img_gray(i,j);
        end;
    end;
end;

figure(1);
title("Original")
imshow(uint8(img_gray));

figure(2);
title("Outlier Filtered")
imshow(uint8(outlier_output));
