% Hüseyin Orkun Elmas 21501364

function eroded_image = erosion(img, structuring_element)
% This function takes 2 2d arrays as images and erodes img 
% With structuring element
% Only supporting odd x odd structuring elements
% This erosion operation uses the first definition of the dilation in
% according to the lecture slides. And it uses padding to prevent boundary
% cases.

if isa(structuring_element,'strel')
    structuring_element = structuring_element.Neighborhood;
end
  
[m,n] = size(img);
[k,l] = size(structuring_element);
 
center_se_x = floor(k/2) + 1;
center_se_y = floor(l/2) + 1;

% Padding the input image with 1's in order to make boundary decisions
% easier

% decide on padding amount
pad_amount_x = center_se_x - 1;
pad_amount_y = center_se_y - 1;

% Since we need to padd from 4 sides
padded_img = ones(m + 2 *(pad_amount_x),n + 2*(pad_amount_y));

% Contents of the original image are pasted to appropriate locations
padded_img((pad_amount_x + 1):end-(pad_amount_x),(pad_amount_y + 1):end-(pad_amount_y)) = img;
eroded_image = zeros(size(img));
for row = 1:m
    for col = 1:n
        center_x_padded = row + center_se_x - 1 - pad_amount_x;
        center_y_padded = col + center_se_y - 1 - pad_amount_y;
        all_1 = true;
        for i = row: row + k - 1
            for j = col: col + l -1
                if  structuring_element(i - row + 1, j - col + 1) == 1 && padded_img(i,j) == 0
                    all_1 = false;
                    break
                end
            end
        end
        if all_1
            eroded_image(center_x_padded, center_y_padded) = 1;
        end
    end
end
        

