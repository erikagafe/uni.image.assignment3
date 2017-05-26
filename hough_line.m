function hough_line()
clc; home;
close all hidden

Img = imread('input_ex3.jpg');
I = (uint8(mean(Img, 3)));
IM = mat2gray(I);

thetas = deg2rad(-90:89);
[width, height] = size(IM);
diag_len = ceil(sqrt(width .* width + height .* height));
rhos = linspace(-diag_len, diag_len, diag_len .* 2.0);

cos_t = cos(thetas);
sin_t = sin(thetas);
num_thetas = length(thetas);

accumulator = zeros((2 * diag_len), num_thetas);


end

