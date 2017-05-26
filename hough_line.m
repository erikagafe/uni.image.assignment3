function hough_line()
clc; home;
close all hidden

    Img = imread('input_ex3.jpg');
    I = (uint8(mean(Img, 3)));
    K = mat2gray(I);

    radius = 1;
    [out, ix, iy] = guassfilter(radius, K);
    imshow(out)
 
    IM = im2bw(out,0.1);
    imshow(IM)

    %IM = im2bw(out,0.10);
   
    [width, height] = size(IM);
    Pmax = ceil(sqrt(width .* width + height .* height));
    thetas = -90:89;
    Pind = -Pmax:Pmax;
    H =  zeros(Pmax * 2 +1, 180);

    for i=1:width
        for j=1:height
            if(IM(i,j) == 1)
                for t=-90:89;
                    p = round((i .*cos(t.*pi/180)+ j.*sin(t.*pi/180)));
                    p = find(Pind == p);
                    thetai= find(thetas==t);
                    H(p,thetai) =  H(p,thetai) +1;
                end
            end
        end
    end

subplot(1,2,1);
imagesc(thetas,Pind,H)
colormap('gray')
end

