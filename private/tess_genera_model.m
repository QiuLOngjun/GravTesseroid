% This script it to generate tesseroid models from a homogeneous shell
%Note: the specific integral area unit is degree and the height unit is meter.
function tessgenermodel=tess_genera_model(tessWid,TopH,BottomH,densValue)
%Discretizing one layer of spherical shell into a number of tesseroids of regular grid, 
%the parameters are the tesseroid dimensions, including horizontal dimensions and the tesseroid height  
%the shell area
WestL=-180;EastL=180;SouthL=-90;NorthL=90;density=densValue;
% initialization the variable of the result matrix
rown=(EastL-WestL)/tessWid*(NorthL-SouthL)/tessWid;
%Make sure that the subdivision number is integer
if (mod(EastL-WestL,tessWid)==0 && mod(NorthL-SouthL,tessWid)==0 )
    disp('The parameters for discretization are reasonable.');
else
    disp('Please Check the Parameters! Make sure that (EastLon-WestLon) or (NorthLat-SouthLat) can be divisible by tess_hor!');
end
%resulting matrix 
tessgenermodel=zeros(rown,7);
%discretizing process
ii=1;
    for ilat=1:(NorthL-SouthL)/tessWid
        for ilon=1:(EastL-WestL)/tessWid
             tessgenermodel(ii,1)=WestL+(ilon-1)*tessWid;
             tessgenermodel(ii,2)=WestL+ilon*tessWid;
             tessgenermodel(ii,3)=NorthL-ilat*tessWid;
             tessgenermodel(ii,4)=NorthL-(ilat-1)*tessWid;
             tessgenermodel(ii,5)=TopH;
             tessgenermodel(ii,6)=BottomH;
             tessgenermodel(ii,7)=density;   
             ii=ii+1;
        end
    end
%function end
end