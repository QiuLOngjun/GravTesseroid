%This function is to convert the tesseroid into a equal-mass rectangular prism 
%Input parameters are information of a tesseroid geometry and density
%Note the parameters Htop and Hbottom are the distances from the top and bottom surfaces of
%the tesseroid to the center of the earth, respecitvely.
%Output£ºPrismLon,PrismLat,PrismR: the origin of the edge system;
%       dx,dy,dz: the side lengths of the prism along three dimensions
%       PrismDensity: the prism density that makes the mass of the prism
%       equal to that of the tesseroid
function [PrismLon,PrismLat,PrismR,DX,DY,DZ,PrismDensity] =Tess2prism(WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,tessDensity)
%the origin of the edge system of the prism
    PrismLon = 0.5*(WestLon+EastLon);
    PrismLat = 0.5*(SouthLat+NorthLat);
    %top surface height above the Earth surface
    PrismR = Htop; 
%convertion of the unit from£¨¡ã£©to £¨radian£©    
    d2r=pi/180.0;   
    RC = 0.5*(Hbottom + Htop);
    DX = RC*d2r*(NorthLat - SouthLat);
    DY = RC*cosd(0.5*(NorthLat + SouthLat))*d2r*(EastLon-WestLon);
    DZ = Htop - Hbottom;    % Note the origin is on the top surface of the tesseroid, and the z axis points down
% Computing the density of the prism in order to keep the same mass as the
% tesseroid.
tessvol=tess_volume(WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom);
prismvol=prism_volume(DX,DY,DZ);
if tessvol==0 || prismvol==0
    PrismDensity=tessDensity;
else
    PrismDensity = tessDensity*tessvol/prismvol;
end
    function [tess_vol]=tess_volume(WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom)
        d2r=pi/180;
        r2=Htop;
        r1=Hbottom;
        tess_vol = d2r*(EastLon - WestLon)*(r2^3 - r1^3)*(sind(NorthLat) - sind(SouthLat))/3.0;
    end
    function prism_vol=prism_volume(DX,DY,DZ)
        prism_vol=DX*DY*DZ;
    end
end