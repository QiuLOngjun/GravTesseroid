function Plot_plane_for_nodes(Lon1,Lon2,Lat1,Lat2,Rmin,Rmax,LineWid,LineCol,GL_roots,Norder)
%
%(Lon1,Lon2,Lat1,Lat2,Rmin,Rmax) that are the west longitude, east
%longitude, south latitude, north latitude, inner radius and outer radius.
% Parameter LineWid indicates the width of the plotting line.
% LineCol indicates the colour of the line.
% Norder indicates the number of Gauss-Legendre nodes.
[ Loncoor,Latcoor,Rcoor] = Get_rootscoordi( Lon1,Lon2,Lat1,Lat2,Rmax,Rmin,GL_roots,Norder,Norder,Norder);

%plotting the line along the longitude.
tt=Rmin:0.001:Rmax;
 for i=1:Norder-1:Norder 
   for j=1:1:Norder          
    zz=tt.*sin(Latcoor(j));
    xx=tt.*cos(Latcoor(j))*cos(Loncoor(i));
    yy=tt.*cos(Latcoor(j))*sin(Loncoor(i));
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
   end
 end

%plotting the line along the latitude.
ttlon=Loncoor(1):0.001:Loncoor(end);
[nr,nc]=size(ttlon)
 for i=1:1:Norder         
    plat_zz=Rmax*sin(Latcoor(i))*ones(1,nc);
    plat_xx=Rmax*cos(Latcoor(i))*cos(ttlon);
    plat_yy=Rmax*cos(Latcoor(i))*sin(ttlon);
    plot3(plat_xx,plat_yy,plat_zz,'Color',LineCol,'LineWidth',LineWid);
    plat_zz=Rmin*sin(Latcoor(i))*ones(1,nc);
    plat_xx=Rmin*cos(Latcoor(i))*cos(ttlon);
    plat_yy=Rmin*cos(Latcoor(i))*sin(ttlon);
    plot3(plat_xx,plat_yy,plat_zz,'Color',LineCol,'LineWidth',LineWid);
 end
 
end