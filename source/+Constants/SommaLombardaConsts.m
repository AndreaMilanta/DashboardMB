classdef SommaLombardaConsts
    %SOMMALOMBARDACONSTS Costanti relative all'impianto di SommaLombarda
    
    properties (Constant)
        panelCADPixelWidth = 6.38;
        panelCADPixelHeight = 10;
        NumPanelsInString = 23;
        MinFilareWidth = GetMinFilareWidth();
        
        % Reference points for GPS to pixel conversion
        ref1GPS = [44.481679, 11.843126];
        ref1Px = [533.0, 1393.0];
        ref2GPS = [44.482704, 11.847418];
        ref2Px = [2686.0, 634.0];
    end
    
    methods (Static, Access = public)
        function filt = FilterCADImage(cad)
            import Constants.*;
            % filter colors (blue & purple & black)
            filt = Consts.FilterOutSingleColor(cad, 'b', 255);      % filter blue
            filt = Consts.FilterOutColorRange(filt, [50,0,180], [218,185,232], 255);    %filter purple
            filt = Consts.FilterOutColorRange(filt, [0,0,0], [0,0,0], 255);    %filter black
        end

    end
end

function x = GetMinFilareWidth()
    import Constants.*;
    x = ceil(SommaLombardaConsts.NumPanelsInString/2) * SommaLombardaConsts.panelCADPixelWidth;
end

