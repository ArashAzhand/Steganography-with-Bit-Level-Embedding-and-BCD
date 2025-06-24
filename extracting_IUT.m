clc;clear;close all;

load(".\key.mat");
rng(key);
stego = imread("stego_image.png");
stego_vector = stego(:);


%-----extracting the number of digits of size------------------------------
tmp = zeros(1, 4);
for i=1:4
    tmp(i) = bitget(stego_vector(i),1);
end
number_of_digits = bin2dec(num2str(tmp));
%-----rest of the digits---------------------------------------------------
size_digits = zeros(1, number_of_digits);
for i = 1:number_of_digits
    digit_bits = zeros(1, 4);
    for j = 1:4
        digit_bits(j) = bitget(stego_vector(4*i+j), 1);
    end
    size_digits(i) = bin2dec(num2str(digit_bits));
end
%-----calculating the size of the hiden image------------------------------
size_of_image = 0;
for i = 1:number_of_digits
    size_of_image = size_of_image + size_digits(i)*10^(number_of_digits-i);
end
%--------------------------------------------------------------------------


%-----extracting the image-------------------------------------------------
extracted = zeros(size_of_image,1);
bits = zeros(1,8);
k = number_of_digits*4+5;
for i=1:size_of_image
    for j=8:-1:1
        bits(j) = bitget(stego_vector(k),1);
        k = k+1;
    end
    extracted(i) = bin2dec(num2str(bits));
end
%------create the random patern and xor it with extracted image to get the 
% main image
random_patern = round(rand(size(extracted)));
final_image = bitxor(extracted,random_patern);
%--------------------------------------------------------------------------

fileID = fopen('extracted_image.jpg', 'w');
fwrite(fileID, final_image);
fclose(fileID);

iut = imread("IUT.jpg");
final_image = imread("extracted_image.jpg");
subplot(1, 2, 1);
imshow(iut);
title('main image');
subplot(1, 2, 2);
imshow(final_image);
title('extracted image');
PSNR_cal(iut, final_image)
