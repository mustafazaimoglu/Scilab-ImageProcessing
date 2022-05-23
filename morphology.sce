clc
clear
close(winsid());

function result=D(matrix,kernel_size)
    result = matrix;
    kernel_center = int(kernel_size / 2);
    [row,col] = size(matrix);

    for i=kernel_center+1:row-kernel_center
        for j=kernel_center+1:col-kernel_center
            result(i,j) = max(matrix(i-kernel_center:i+kernel_center,j-kernel_center:j+kernel_center));
        end;
    end;
endfunction;

function result=E(matrix,kernel_size) //~D(~image)
    matrix = max(matrix) - matrix;
    result =  matrix;
    kernel_center = int(kernel_size / 2);
    [row,col] = size(matrix);

    for i=kernel_center+1:row-kernel_center
        for j=kernel_center+1:col-kernel_center
            result(i,j) = max(matrix(i-kernel_center:i+kernel_center,j-kernel_center:j+kernel_center));
        end;
    end;

    result = max(result) - result;
endfunction;

function result=C(matrix,kernel_size) 
    dilation = D(matrix,kernel_size);
    closure = E(dilation,kernel_size);

    result = closure;
endfunction;

function result=O(matrix,kernel_size) 
    erosion = E(matrix,kernel_size);
    opening = D(erosion,kernel_size);

    result = opening;
endfunction;

function result=border_detection(matrix,kernel_size) 
    opening = O(matrix,kernel_size);
    borders = C(opening,kernel_size);
    erosion = E(borders,kernel_size);

    result = borders - erosion;
endfunction;

function result=count_actives(matrix) 
    result = 0;
    [row,col] = size(matrix);

    for i=1:row
        for j=1:col
            if matrix(i,j) == 1 then
                result = result + 1;
            end;
        end;
    end;
endfunction;

img = imread("RT.bmp");
img = double(img);
img = max(img) - img;
kernel_size = 3;

dilation = D(img,kernel_size);
erosion = E(img,kernel_size);
closure = C(img,kernel_size);
opening = O(img,kernel_size);
double_opening = O(opening,kernel_size);
borders = border_detection(img,kernel_size);

dilation_count = count_actives(dilation);
closure_count = count_actives(closure);
opening_count = count_actives(opening);
erosion_count = count_actives(erosion);

disp("Dilation : " + string(dilation_count));
disp("Closure : " + string(closure_count));
disp("Opening : " + string(opening_count));
disp("Erosion : " + string(erosion_count));
disp(string(dilation_count) + " >= " + string(closure_count) + " >= " + string(opening_count) + " >= " + string(erosion_count))

figure(1);
title("Original")
imshow(img);

figure(2);
title("Dilation")
imshow(dilation);

figure(3);
title("Erosion")
imshow(erosion);

figure(4);
title("Closure")
imshow(closure);

figure(5);
title("Opening")
imshow(opening);

figure(6);
title("Double Opening")
imshow(double_opening);

figure(7);
title("Borders")
imshow(borders);

