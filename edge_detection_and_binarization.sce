clc
clear
close(winsid());

function result=normalization(matrix)
    min_m=min(matrix);
    max_m=max(matrix);
    matrix(:,:)=255*(matrix(:,:)-min_m)/(max_m-min_m);
    
    result = matrix;
endfunction;

function result=binary_converter(matrix,threshold)
    [row,col] = size(matrix);
    result = zeros(row,col)
    for i=1:row
        for j=1:col
            if (matrix(i,j) > threshold) then
                result(i,j) = 255
            end;
        end;
    end;
endfunction;

img = imread("src/hand.jpg");
img = double(img);
img_gray = rgb2gray(img);
[i_row i_col i_deep] = size(img);

NW = [2  1  0;
      1  0 -1;
      0 -1 -2;];
NE = [ 0  1  2;
      -1  0  1;
      -2 -1  0;];

k_size = size(NW)(1);
k_center = round(k_size / 2);

NW_out = ones(i_row,i_col);
NE_out = NW_out;

for i=k_center:i_row - k_center + 1
    for j=k_center:i_col - k_center + 1
        NW_out(i,j) =  sum(img_gray(i-k_center+1:i+k_center-1, j-k_center+1:j+k_center-1).*NW);
        NE_out(i,j) =  sum(img_gray(i-k_center+1:i+k_center-1, j-k_center+1:j+k_center-1).*NE);
    end;
end;

NW_out = -(abs(NW_out));
NE_out = -(abs(NE_out));
NW_out = normalization(NW_out);
NE_out = normalization(NE_out);

output = NW_out + NE_out;
output = normalization(output);

binary = binary_converter(output,217);

figure(1);
title("Original")
imshow(uint8(img_gray));

figure(2);
title("NW Result")
imshow(uint8(NW_out));

figure(3);
title("NE Result")
imshow(uint8(NE_out));

figure(4);
title("NW + NE Result")
imshow(uint8(output));

figure(5);
title("Binary Output")
imshow(uint8(binary));
