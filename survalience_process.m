
function survalience_process(img_path,sq)

% Path for writing output images
out_path = 'C:\Users\hsyne\Desktop\courses\Image\CS484-hw1\Result_survalience\';

% Open img files
imagefiles = dir(strcat(img_path,'*.jpg'));

% Get the number of images
[r,~] = size(imagefiles);

% Read Background image
background_gray = rgb2gray(imread( strcat(img_path,imagefiles(1).name) ));


for i = 2:r
    
    % Read_img
    RGB_img = imread( strcat(img_path,imagefiles(i).name));
    
    % Convert img to gray
    gray_img = rgb2gray(RGB_img);
    
    % Subtract from background
    change_gray = imsubtract(background_gray, gray_img) + imsubtract(gray_img, background_gray); 
    
    % Display change (Result of subtruction)
    figure;
    imshow(change_gray);
    pause;

    % Write result of subtruction
    imwrite(change_gray,strcat(out_path, 'subt_', num2str(i), num2str(sq), '.png'));

    % Threshold
    change_thr_gray = change_gray > 30;

    % Display Thresholded img
    figure;imshow(change_thr_gray);pause;
    imwrite(change_thr_gray,strcat(out_path,'thr_', num2str(i), num2str(sq), '.png'));
   
    % Mathematical Morphology, Create Structuring Element
    se = strel("diamond",3);

    % A couple erosions
    erosed = erosion(change_thr_gray,se);

    % Display eroded img
    %figure;imagesc(erosed), colormap(gray); axis image; pause;

    %dilated_img = dilate(erosed,se);
    se = strel("disk",3);
    for j = 1:5
        dilated_img = imdilate(erosed,se); 
        erosed = dilated_img & change_thr_gray;
    end
    
    % Display end of conditional dilation
    figure;imagesc(dilated_img); colormap( gray); axis image;
    pause;
    
    % Write output
    imwrite(dilated_img,strcat(out_path, 'morp_', num2str(i), num2str(sq), '.png'));
    connected_comp = bwconncomp(dilated_img);
    imwrite(label2rgb(labelmatrix(connected_comp)),strcat(out_path, 'conn_', num2str(i), num2str(sq), '.png'));
end
close all;
clear;
