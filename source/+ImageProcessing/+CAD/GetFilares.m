function filares = GetFilares(img, approxH, minW)
%GETFILARE returns a list of Filari from the CAD image
% returns a list of filares stored as rectangles
    if(size(img, 3) == 1)
        filares = GetFilaresBW(img, approxH, minW);
    else
        imgBW = rgb2gray(img);
        filares = GetFilaresBW(imgBW, approxH, minW);
    end
end

function filares = GetFilaresBW(img, approxH, minW)

    % find edges
    threshold = [0.1, 0.3];
    edges = edge(img, 'Canny', threshold);
    
    % bounding boxes
    bb = regionprops(edges, 'BoundingBox');
    bb = cat(1, bb.BoundingBox);

    % filter bounding boxes on height and width
    mask = ~(bb(:,4) >= approxH*0.8 & bb(:,4) <= approxH*1.2 & bb(:,3) >= minW);
    bb(mask,:) = [];
    filares = bb;
end


