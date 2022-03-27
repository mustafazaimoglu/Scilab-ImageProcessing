clc
clear
close(winsid());

img = imread('src/Lena.bmp');
[row col deep]=size(img); 
img=double(img); 

// MASK CREATION
img_size = row;
mask = zeros(img_size,img_size);
radius =img_size/2
for i=1:img_size
  for j=1:img_size
    if sqrt((i-radius-0.5)^2+(j-radius-0.5)^2)<radius
      mask(i,j)=1;
    end;
  end;
end;
//imshow(mask);

/*
// ALPHA
alpha = 45*%pi/180;

// ROTATION
rotated_image = zeros(img_size,img_size,deep);
rotation_matrix = [cos(-alpha) -sin(-alpha); sin(-alpha) cos(-alpha)];

for r1=1:img_size
    for c1=1:img_size
        for d=1:deep
            if mask(r1,c1) == 1
                rowcol=rotation_matrix*[r1-radius-0.5;c1-radius-0.5];
                r2=round(rowcol(1)+radius+0.5);
                c2=round(rowcol(2)+radius+0.5);
                rotated_image(r1,c1,d) = img(r2,c2,d);
            end;
        end;
    end;
end;
*/

// LOOP ROTATION
for value=0:20:360
    sleep(10);

    // ALPHA
    alpha = value*%pi/180;

    // ROTATION
    rotated_image = zeros(img_size,img_size,deep);
    rotation_matrix = [cos(-alpha) -sin(-alpha); sin(-alpha) cos(-alpha)];

    for r1=1:img_size
        for c1=1:img_size
            for d=1:deep
                if mask(r1,c1) == 1
                    rowcol=rotation_matrix*[r1-radius-0.5;c1-radius-0.5];
                    r2=round(rowcol(1)+radius+0.5);
                    c2=round(rowcol(2)+radius+0.5);
                    rotated_image(r1,c1,d) = img(r2,c2,d);
                end;
            end;
        end;
    end;
    
    imshow(uint8(rotated_image));
end;

