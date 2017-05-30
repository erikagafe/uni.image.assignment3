function [thetas,Pind,H]= hough_line(bw, out)
clc; home;
close all hidden

    subplot(3,2,1), imshow(out); title('Original in B/W');
    subplot(3,2,2), imshow(bw), title('Image 0.05 threshold');
    
    
    %E
    %houghline
    [height, width] = size(bw);
    %Pmax = ceil(sqrt(width * width + height * height));
    Pmax = ceil (sqrt(power(width - 1,2)+power(height -1 ,2)));
    thetas = -90:89;
    Pind = -Pmax:Pmax;
    H =  zeros(Pmax * 2 + 1, 180);

    for y=1:height % for all columns
        for x=1:width % for all rows     
            if(bw(y, x) == 1)% if the pixel is ONE (part of the edge) then process it
                for t=thetas;
                    p = round((x * cos(t * pi/180) + y * sin(t * pi/180)));
                    p = find(Pind == p);
                    thetai = find(thetas==t);
                    H(p,thetai) = H(p,thetai) + 1;
                end
            end
        end
    end
    subplot(3,2,3),
    imagesc(thetas,Pind,H), colormap('gray'); title('Hough voting array');
    
    % G
    % https://de.mathworks.com/help/images/ref/houghlines.html
    P = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));

    % H
    subplot(3,2,4),
    imagesc(thetas,Pind,H), colormap('gray'); title('Hough Peaks');
    axis on, axis normal, hold on;
    plot(thetas(P(:,2)),Pind(P(:,1)),'s','color','blue');

    %I
    %houghlines
    lines = houghlines(bw,thetas,Pind,P,'FillGap',20,'MinLength',20);

    %J
    figure, imshow(out),title('Hough Line'); hold on
    max_len = 0;
        for k = 1:length(lines)
           xy = [lines(k).point1; lines(k).point2];
           plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
           % Plot beginnings and ends of lines
           plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
           plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
           len = norm(lines(k).point1 - lines(k).point2);
           if ( len > max_len)
               max_len = len;
               xy_long = xy;
           end
        end

    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

end

