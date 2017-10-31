result_img_path = 'C:\Users\hsyne\Desktop\courses\Image\CS484-hw1\result_plate_images\';
in_img_path = 'C:\Users\hsyne\Desktop\courses\Image\CS484-hw1\cs484_hw1_data\license_plates\';
% Getting File names in a structure array

imagefiles = dir(strcat(in_img_path,'*.jpg'));
[r,c] = size(imagefiles); 
for i= 1:r
 x = imread(strcat(in_img_path,imagefiles(i).name) );
 connected_comp = license_plate(x,i);
 imwrite(label2rgb(labelmatrix(connected_comp)),strcat(result_img_path,'connected_',num2str(i),'.png'))
end   
close all;