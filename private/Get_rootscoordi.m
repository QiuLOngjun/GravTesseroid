function [ Loncoor,Latcoor,Rcoor] = Get_rootscoordi( WestLon,EastLon,SouthLat,NorthLat,TopSurf,BottomSur,GL_roots,LonOrd,LatOrd,ROrd)
%this function Get_rootscoordi is to get equivalent point coordinate in the
%integration body throught getting scaled roots in the integration limits{[X1,X2],[Y1,Y2],[Z1,Z2]}
%the result is coordinates of the roots, which is stored in array[Xcoor,Ycoor,Zcoor]
R_roots=GL_roots(0.5*(ROrd*ROrd-ROrd):0.5*(ROrd*ROrd+ROrd-2));
Lon_roots=GL_roots(0.5*(LonOrd*LonOrd-LonOrd):0.5*(LonOrd*LonOrd+LonOrd-2));
Lat_roots=GL_roots(0.5*(LatOrd*LatOrd-LatOrd):0.5*(LatOrd*LatOrd+LatOrd-2));
delta_R=BottomSur-TopSurf;
delta_Lon=EastLon-WestLon;
delta_Lat=NorthLat-SouthLat;
%Setting scaled Legendre polynomials roots.
Rcoor=0.5*delta_R*R_roots+0.5*(BottomSur+TopSurf);
Loncoor=0.5*delta_Lon*Lon_roots+0.5*(EastLon+WestLon);
Latcoor=0.5*delta_Lat*Lat_roots+0.5*(NorthLat+SouthLat);
end