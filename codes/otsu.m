%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title OTSU FUNCTION

%% otsu: is used to automatically perform clustering-based image thresholding or the reduction of a graylevel image to a binary image
function [RGB, I] = otsu(imgSrc)
	%% 1- READ Image
    I = imread(imgSrc);
    % I = im2double(I);
    I2gray = rgb2gray(I);
    
    %% 2- Use Morphological Opening to Estimate the Background
    background = imopen(I2gray, strel('disk', 10));
    
    %% 3- Add the Background Image from the Original Image
    I2 = I2gray + 2 * background;
    
    %% 4- Increase the Image Contrast
    I3 = imadjust(I2);
    
    %% 5- Threshold the Image
    level = graythresh(I3);
    bw = im2bw(I3, level);
    
    %% 6- Back to RGB
    W = 2 ^ 16;
    R = I(:, :, 1);
    R(~bw) = W;
   
    G = I(:, :, 2);
    G(~bw) = W;
    
    B = I(:, :, 3);
    B(~bw) = W;
    
    RGB = cat(3, R, G, B);

end
