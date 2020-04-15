% This script it to generate computation grid using 7 parameters that
% include the specific calculatioin range, the spacing between the
% computation nodes and the computation height.
% Parameters: WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp 
% Note:the parameters' unit is degree and the height unit is meter.
function gridnodes=grid_gene_pixel(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp)
    if (SouthGr<-90 || NorthGr>90 || EastGr>180 || WestGr<-180)
        disp('Please Check the Parameters! Make sure that the range of the grid is right!');
        pause(10);
    end
    if (mod(NorthGr-SouthGr,Spacinglon)~=0 || mod(EastGr-WestGr,Spacinglon)~=0)
        disp('Please Check the Parameters! the range that is defined by£¨WestGr,EastGr,SouthGr,NorthGr£©is not divisible by the Spacing!');
        pause(10);
    end
nlon=(EastGr-WestGr)/Spacinglon;
nlat=(NorthGr-SouthGr)/Spacinglat;
gridnodes=zeros(nlat*nlon,3);
kk=1;
    for ilat=1:1:nlat
        for ilon=1:1:nlon
             gridnodes(kk,1)=WestGr+Spacinglon*(ilon-1)+Spacinglon*0.5;%Setting the longitude for grid nodes
             gridnodes(kk,2)=SouthGr+Spacinglat*(ilat-1)+Spacinglat*0.5;%Settinh the latitude for grid nodes
             gridnodes(kk,3)=Hp;                      %Setting the computation height for nodes
             kk=kk+1;                                 %index 
        end
    end
end