% Get data from CAD
import Constants.*;
import ImageProcessing.CAD.*;

path = strcat(Consts.ProjectPath, 'data\SommaLombarda\');
imgName = 'SommaLombardaCAD.png';
img = imread(strcat(path,imgName));
filt = SommaLombardaConsts.FilterCADImage(img);

% find edges
threshold = [0.1, 0.3];
edges = edge(rgb2gray(filt), 'Canny', threshold);

% compute GPS to Coordinates
GPSExample = [44.481640, 11.846063];

tr = Consts.GPS2PxConversionTransform(SommaLombardaConsts.ref1Px, SommaLombardaConsts.ref1GPS, ...
     SommaLombardaConsts.ref2Px, SommaLombardaConsts.ref2GPS);
 
px = Consts.GPS2Px(GPSExample,tr);
ref1 = Consts.GPS2Px(SommaLombardaConsts.ref1GPS,tr);
ref2 = Consts.GPS2Px(SommaLombardaConsts.ref2GPS,tr);
figure(1);
imshow(filt); hold on;
plot(ref1(1), ref1(2), 'g*', 'LineWidth', 2, 'MarkerSize', 10);
plot(ref2(1), ref2(2), 'r*', 'LineWidth', 2, 'MarkerSize', 10);
plot(px(1), px(2), 'b*', 'LineWidth', 2, 'MarkerSize', 10)

% get and display filares
% filares = GetFilares(filt, SommaLombardaConsts.panelCADPixelHeight*2, SommaLombardaConsts.MinFilareWidth*0.99);
% figure(2)
% imshow(edges); hold on;
% for k = 1:size(filares,1)
%     rectangle('position',filares(k,:),'Edgecolor','b');
% end