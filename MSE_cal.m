function output = MSE_cal(orgImage, newImage)
    orgImage = double(orgImage);
    newImage = double(newImage);
    
    diff = (orgImage - newImage).^2;
    output = sum(diff(:)) / numel(orgImage);
end