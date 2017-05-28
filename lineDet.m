function lineDet()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%A
    Img = imread('input_ex3.jpg');
    I = (uint8(mean(Img, 3)));
    out = mat2gray(I);
    figure;
    imshow(out);
%B
    radius = 1;
    [out, ix, iy] = guassfilter(radius, out);

%C out = gradient magnitude image

%D
    bw = im2bw(out,0.05); %0.05 = threshold
    
    figure;
    imshow(bw);

%E
    [rows, cols] = size(bw);
    
    %houghline
    Pmax = ceil (sqrt(power(rows,2)+power(cols,2)));
    Pind=-Pmax:Pmax;
    thetaInd = -90:89;
    %thetaInd = 1:180;
    H = zeros(Pmax * 2 + 1,180);
    for i =1:rows % for all rows
        for j =1:cols % for all columns            
           if(bw(i,j) == 1) % if the pixel is ONE (part of the edge) then process it
                for theta=-90:89;
                    p = round((i * cos(theta*pi/180)) + (j * sin(theta*pi/180))); 
                    p = find(Pind == p);
                    thetai = find(thetaInd == theta);
                    H(p,thetai) = H(p,thetai) + 1;
                end
            end
        end
    end
    
%F
subplot(1,2,1)
imagesc(thetaInd,Pind,H);    
colormap('gray');

%G
%https://de.mathworks.com/help/images/ref/houghlines.html
P  = houghpeaks(H,16);

%H
axis on, axis normal, hold on;
plot(thetaInd(P(:,2)),Pind(P(:,1)),'s','color','white');

%I
%houghlines
lines = houghlines(bw,thetaInd,Pind,P,'FillGap',20,'MinLength',20);

%J
figure, imshow(out), hold on
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
       
       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    end
end
