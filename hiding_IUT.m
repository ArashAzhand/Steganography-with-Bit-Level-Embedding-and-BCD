clc;clear;close all;


cover_image = imread("Cover_Image.png");
secret_image = fopen("IUT.jpg");
secret_image_content = fread(secret_image);
fclose(secret_image);

%convert the cover image to a vector in order to avoid nested loops
cover_image_vector = cover_image(:); 
stego_image_vector = cover_image_vector;


%-----creating seed and random patern--------------------------------------
key = rng;
random_patern = (round(rand(size(secret_image_content)))==1);
randomized_secret_image = bitxor(random_patern, secret_image_content);
%--------------------------------------------------------------------------


%-----filling first bits with size of the image----------------------------
size_digit_str = num2str(numel(randomized_secret_image));
size_digit_number = length(size_digit_str);
bin_size = dec2bin(size_digit_number, 4);
for i = 1:4
    stego_image_vector(i) = bitset(stego_image_vector(i), 1, str2double(bin_size(i)));
end
for i = 1:size_digit_number
    bin_number = dec2bin(str2double(size_digit_str(i)), 4);
    for j = 1:4
        stego_image_vector(i*4+j) = bitset(stego_image_vector(i*4+j), 1, str2double(bin_number(j)));
    end
end
%--------------------------------------------------------------------------


%-----filling rest of the first plane with image data----------------------
k = size_digit_number*4+5;
for i=1:numel(randomized_secret_image)
    for j=1:8
        bit = bitget(randomized_secret_image(i), j);
        stego_image_vector(k) = bitset(stego_image_vector(k), 1, bit);
        k = k + 1;
    end
end
%--------------------------------------------------------------------------

stego_image = reshape(stego_image_vector, size(cover_image));
imwrite(stego_image,"stego_image.png");
save(".\key","key");
PSNR_cal(cover_image, stego_image)
