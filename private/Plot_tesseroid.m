function Plot_tesseroid(Lon1,Lon2,Lat1,Lat2,Rmin,Rmax,LineWid,LineCol)
%Plotting an individual tesseroid.
%(Lon1,Lon2,Lat1,Lat2,Rmin,Rmax) that are the west longitude, east
%longitude, south latitude, north latitude, inner radius and outer radius.
% Parameter LineWid indicates the width of the plotting line.
% LineCol indicates the colour of the line.

%
lon=[Lon1,Lon2];
lat=[Lat1,Lat2];
%plotting along the radial direction.
tt=Rmin:0.001:Rmax;
 for i=1:1:2  
   for j=1:1:2          
    zz=tt.*sin(lat(j));
    xx=tt.*cos(lat(j))*cos(lon(i));
    yy=tt.*cos(lat(j))*sin(lon(i));
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
   end
 end
%along the longitudinal direction
ttlat=Lat1:0.001:Lat2;
 for i=1:1:2        
    plon_zz=Rmax*sin(ttlat);
    plon_xx=Rmax*cos(ttlat)*cos(lon(i));
    plon_yy=Rmax*cos(ttlat)*sin(lon(i));
    plot3(plon_xx,plon_yy,plon_zz,'Color',LineCol,'LineWidth',LineWid);
    plon_zz=Rmin*sin(ttlat);
    plon_xx=Rmin*cos(ttlat)*cos(lon(i));
    plon_yy=Rmin*cos(ttlat)*sin(lon(i));
    plot3(plon_xx,plon_yy,plon_zz,'Color',LineCol,'LineWidth',LineWid);
 end
%along the latitudinal direction
ttlon=Lon1:0.001:Lon2;
[nr,nc]=size(ttlon)
 for i=1:1:2         
    plat_zz=Rmax*sin(lat(i))*ones(1,nc);
    plat_xx=Rmax*cos(lat(i))*cos(ttlon);
    plat_yy=Rmax*cos(lat(i))*sin(ttlon);
    plot3(plat_xx,plat_yy,plat_zz,'Color',LineCol,'LineWidth',LineWid);
    plat_zz=Rmin*sin(lat(i))*ones(1,nc);
    plat_xx=Rmin*cos(lat(i))*cos(ttlon);
    plat_yy=Rmin*cos(lat(i))*sin(ttlon);
    plot3(plat_xx,plat_yy,plat_zz,'Color',LineCol,'LineWidth',LineWid);
 end
end