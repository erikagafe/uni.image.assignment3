
function [out]=HWQ1()
    clc; home;
    close all hidden

    Img = imread('input_ex3.jpg');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);

    radius = 1;
    [out, ix, iy] = guassfilter(radius, K);
    imshow(out)
 
    bw = im2bw(out,0.05);
    
    figure;
    imshow(bw);
end



