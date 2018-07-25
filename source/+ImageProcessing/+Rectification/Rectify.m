function rect = Rectify(img)
%RECTIFY image in perspective projection
    if(size(img, 3) == 1)
        rect = RectifyBW(img);
    else
        imgBW = rgb2gray(img);
        rect = RectifyBW(imgBW);
    end
end

%Rectify B&W image
function rect = RectifyBW(img)
    import Constants.*;
    % resize image to default size
    rsImg = Consts.ToDefaultVisualSize(img);
    
    % find edges
    threshold = [0.1, 0.3];
    edges = edge(rsImg, 'Canny', threshold);
    
    % find points
    points = detectHarrisFeatures(edges, 'FilterSize',15, 'MinQuality',0.01);
    corners = points.selectStrongest(10);
    imshow(edges)
    hold on
    plot(corners);
    
%     % find lines with Hough transform
%     [H,theta,rho] = hough(edges, 'RhoResolution',2);
%     peaks = houghpeaks(H,10, 'threshold',ceil(0.3*max(H(:))));
%     lines = houghlines(edges,theta,rho,peaks, 'FillGap',20, 'MinLength',100);
%     
%     % display lines found
%     figure, imshow(edges), hold on
%     for k = 1:length(lines)
%        xy = [lines(k).point1; lines(k).point2];
%        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%        % Plot beginnings and ends of lines
%        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%        plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%     end
    
    rect = edges;
end
