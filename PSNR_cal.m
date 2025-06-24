function [output] = PSNR_cal(orgImage, newImage)
output = 10*log10((255^2)/MSE_cal(orgImage, newImage));
end