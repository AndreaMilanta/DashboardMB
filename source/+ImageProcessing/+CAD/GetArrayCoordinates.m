% Get Coordinates of Arrays taken from 'cad' images



% -- cad <- b&w schematic image of the plane
% -- refPos <- position to consider on the array (BR, MR, TR, BC, MC, TC, BL, CL, TL)
function coords = GetArrayCoordinates(cad, refPos)
    imports();                            % imports required packages
    
    coords = 0;
end

% get coordinates identifying the array
% -- contour <- list of four points representing the border of an array
% -- refPos <- position to consider on the array (BR, MR, TR, BC, MC, TC, BL, CL, TL)
function [x, y] = getRefCoord(contour, pos)

end

% list of packages to import for this function to work
function imports()
    import Constants.Enums.*;
end