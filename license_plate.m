function connected_comp = license_plate(plate_img,i)
img_path = 'C:\Users\hsyne\Desktop\courses\Image\CS484-hw1\result_plate_images\';
% Extract color channels
blue_channel = plate_img(:,:,3);
red_channel = plate_img(:,:,1);
green_channel = plate_img(:,:,2);

% Threshold blue channel
thresholded_img = blue_channel < 65 & red_channel < 70 & green_channel < 70;
imwrite(thresholded_img,strcat(img_path,'thr_',num2str(i),'.png'))

% Use Erosion to get rid of small things
se = strel("square",7);
eroded_img = erosion(thresholded_img,se);
se = strel("square",3);
eroded_img = erosion(eroded_img,se);

%figure;imagesc(eroded_img), colormap( gray); axis image;
%title("Erosion with 9x9 square B")
%pause;

% Using conditional dialation
se = strel("diamond",5);
dilated_img = dilate(eroded_img,se);
for j = 1:25
    temp = dilated_img & thresholded_img;
    dilated_img = dilate(temp,se);
   % figure;imagesc(dilated_img), colormap(gray); axis image;
   % pause;
end
dilated_img = dilated_img & thresholded_img;
%dilated_img = erosion(dilated_img,se);
%figure;imagesc(dilated_img), colormap(gray); axis image;
%pause;
%title("Cond Dilation with 9x9 square B") ;

imwrite(dilated_img,strcat(img_path,'morp_',num2str(i),'.png'))
connected_comp = bwconncomp(dilated_img);
close all
