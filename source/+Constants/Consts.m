classdef Consts
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        ProjectPath = GetPath();
        VisualDefaultSize = [500, 400]
    end
    
    methods (Static, Access = public)
        function scaledImg = ToDefaultVisualSize(img)
            import Constants.*
            szOriginal = size(img);
            if (szOriginal(1) < Consts.VisualDefaultSize(1))
                return;
            end
            resizeFactor = Consts.VisualDefaultSize(1) / szOriginal(1);
            scaledImg = imresize(img, double(resizeFactor));
        end
        
        function filtered = FilterOutColorRange(img, minColor, maxColor, substitute)
            % filters pixels in given color range with default gray color
            % substitute (scalar)
            mask = img(:,:,1) >= minColor(1) & img(:,:,1) <= maxColor(1) & ...   % create mask
                   img(:,:,2) >= minColor(2) & img(:,:,2) <= maxColor(2) & ...
                   img(:,:,3) >= minColor(3) & img(:,:,3) <= maxColor(3);
            filtered = img;
            filtered(repmat(mask,[1 1 3])) = substitute;    % Set background pixels where mask is true to zero.
        end
        
        function filtered = FilterInColorRange(img, minColor, maxColor, substitute)
            % filters pixels outside given color range with default gray color
            % substitute (scalar)
            mask = img(:,:,1) >= minColor(1) & img(:,:,1) <= maxColor(1) & ...   % create mask
                   img(:,:,2) >= minColor(2) & img(:,:,2) <= maxColor(2) & ...
                   img(:,:,3) >= minColor(3) & img(:,:,3) <= maxColor(3);
            filtered = img;
            filtered(repmat(~mask,[1 1 3])) = substitute;    % Set background pixels where mask is true to zero.
        end
        
        function filtered = FilterOutSingleColor(img, color, substitute)
            % filters out pixels of all tones of a given color (the other 2 channels are equals). 
            % Filtered pixels are replaced  with default gray color substitute (scalar)
            if (color == 'b')
                mask = img(:,:,1) == img(:,:,2) & img(:,:,3) >= 1 & img(:,:,3) <= 255;
            elseif (color == 'g')
                mask = img(:,:,1) == img(:,:,3) & img(:,:,2) >= 1 & img(:,:,2) <= 255;
            elseif (color == 'r')
                mask = img(:,:,2) == img(:,:,3) & img(:,:,1) >= 1 & img(:,:,1) <= 255;
            else 
                ME = MException('FilterInSingleColor:invalidColor','invalid color: ', color);
                throw(ME)
            end
            filtered = img;
            filtered(repmat(mask,[1 1 3])) = substitute; 
        end
        
        function filtered = FilterInSingleColor(img, color, substitute)
            % filters in pixels of all tones of a given color (the other 2 channels are equals). 
            % Filtered pixels are replaced  with default gray color substitute (scalar)
            if (color == 'r')
                mask = img(:,:,1) == img(:,:,2) & img(:,:,3) >= 1 & img(:,:,3) <= 255;
            elseif (color == 'g')
                mask = img(:,:,1) == img(:,:,3) & img(:,:,2) >= 1 & img(:,:,2) <= 255;
            elseif (color == 'b')
                mask = img(:,:,2) == img(:,:,3) & img(:,:,1) >= 1 & img(:,:,1) <= 255;
            else 
                ME = MException('FilterInSingleColor:invalidColor','invalid color: ', color);
                throw(ME)
            end
            filtered = img;
            filtered(repmat(mask,[1 1 3])) = substitute; 
        end
        
        function trasf = GPS2PxConversionTransform(r1Px, r1GPS, r2Px, r2GPS)
            % Compute left-matrix to trasform from GPS to pixel coordinates
            a = ((r1Px(1)*r2GPS(2)) - (r2Px(1)*r1GPS(2))) \ ...
                ((r2GPS(2)*r1GPS(1) - (r1GPS(2)*r2GPS(1))));
            b = ((r1Px(1)*r2GPS(1)) - (r2Px(1)*r1GPS(1))) \ ...
                ((r1GPS(2)*r2GPS(1) - (r2GPS(2)*r1GPS(1))));
            c = ((r1Px(2)*r2GPS(2)) - (r2Px(2)*r1GPS(2))) \ ...
                ((r2GPS(2)*r1GPS(1) - (r1GPS(2)*r2GPS(1))));
            d = ((r1Px(2)*r2GPS(1)) - (r2Px(2)*r1GPS(1))) \ ...
                ((r1GPS(2)*r2GPS(1) - (r2GPS(2)*r1GPS(1))));
            trasf = [a, b; c, d];
            trasf = [-142614, 535689; 50313.8, -188856];
        end
        
        function pxCoords = GPS2Px(GPSCoords, trasf)
            pxCoords = trasf * GPSCoords';
        end
    end
end

function path = GetPath()
    fullpath = fileparts(mfilename('fullpath'));
    lastslash_pos = find(fullpath == '\', 1, 'last');
	fullpath = fullpath(1 : lastslash_pos - 1);
    lastslash_pos = find(fullpath == '\', 1, 'last');
	path = fullpath(1 : lastslash_pos);
end