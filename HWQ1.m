
function [out]=HWQ1()
    clc; home;
    close all hidden

    %A
    Img = imread('input_ex3.jpg');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);
    
    %B
    radius = 1;
    [out, ix, iy] = guassfilter(radius, K);

    %C out = gradient magnitude image
    
    %D
    bw = im2bw(out,0.05);%0.05 = threshold
    
    %E  
    hough_line(bw, out)
 
end



