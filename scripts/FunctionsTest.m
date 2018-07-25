% scripts to test functions 

import Constants.*;
import ImageProcessing.Rectification.*;



path = strcat(Consts.ProjectPath, 'data\SommaLombarda\FirstVisit\');
imgName = 'C12-I3.2 - 01.jpg';
img = imread(strcat(path,imgName));

% imshow(img);
rect = Rectify(img);
% imshow(rect);
