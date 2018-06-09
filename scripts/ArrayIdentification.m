% identify array from cad

% CONSTANTS
% Locations Constants
FOLDER_PATH = './data/images/';
CAD_FILE = 'SommaLombardaCAD.png';
% Processing Constants
resizingFactor = 0.4;               % Resizing factor by which to resize the original image to work with it
edgeDetectionMethod = 'Canny';      % Method used for edge detection ('Sobel' (default) | 'Prewitt' | 'Roberts' | 'log' | 'zerocross' | 'Canny' | 'approxcanny')


% Read, turn BW and resize image
cad = imread([FOLDER_PATH CAD_FILE]);
cad = rgb2gray(cad);
cad = imresize(cad, resizingFactor);

% IMAGE PROCESSING
% compute edges
ed = edge(cad, edgeDetectionMethod);

% DISPLAYING
warning('off', 'all');
% BW image
figure;
imshow(cad);
title('orig');

% Edges image
figure;
imshow(ed);
title('edge');
warning ('on', 'all');