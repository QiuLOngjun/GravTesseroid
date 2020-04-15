function Plot_sphere(DrawRange,InterLon,InterLat,Ra,LineWid,LineCol)
%Plotting the whole sphere or part of a sphere.
%DrawRange uses 0,1and 2 to indicate plotting one eighths of a sphere, hemisphere and
% a whole sphere.

%InterLon the interval along the longituede direction.
%InterLat the interval along the latitude direction.
%Ra is the radius, e.g., Ra=0.4;
%LineWid is the width of the plotting line, e.g., LineWid=0.4£»
%LineCol is line colour, e.g., [192/255 192/255 192/255].

switch DrawRange
    
case {2} %The whole sphere 
 %along longitude
 for lon=0:InterLon:2*pi           %the range of the longitude 0 to 2*pi 
    tt1=-pi/2:0.001:pi/2;          %the range of latitude -pi/2 to +pi/2
    zz=Ra*sin(tt1);
    xx=Ra*cos(tt1)*cos(lon);
    yy=Ra*cos(tt1)*sin(lon);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end
  %along latitude    
 for lat=-pi/2:InterLat:pi/2     
    tt2=0:0.001:2*pi;
    dim2=size(tt2,2);
    zz=Ra*sin(lat)*ones(1,dim2);
    xx=Ra*cos(tt2)*cos(lat);
    yy=Ra*sin(tt2)*cos(lat);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end      
 
case{1}%plotting a hemisphere 
 for lon=0:InterLon:2*pi           %the range of longitude 0 to 2*pi 
    tt1=0:0.001:pi/2;              %the range of latitude 0 to +pi/2
    zz=Ra*sin(tt1);
    xx=Ra*cos(tt1)*cos(lon);
    yy=Ra*cos(tt1)*sin(lon);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end
  %along the latitude   
 for lat=0:InterLat:pi/2   
    tt2=0:0.001:2*pi;
    dim2=size(tt2,2);
    zz=Ra*sin(lat)*ones(1,dim2);
    xx=Ra*cos(tt2)*cos(lat);
    yy=Ra*sin(tt2)*cos(lat);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end    
  
case{0}%plotting only one eighths sphere
 for lon=0:InterLon:pi/2           %the range of longitude 
    tt1=0:0.001:pi/2;              
    zz=Ra*sin(tt1);
    xx=Ra*cos(tt1)*cos(lon);
    yy=Ra*cos(tt1)*sin(lon);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end
  %along latitude 
 for lat=0:InterLat:pi/2   
    tt2=0:0.001:pi/2;
    dim2=size(tt2,2);
    zz=Ra*sin(lat)*ones(1,dim2);
    xx=Ra*cos(tt2)*cos(lat);
    yy=Ra*sin(tt2)*cos(lat);
    plot3(xx,yy,zz,'Color',LineCol,'LineWidth',LineWid);
 end     
 
end
 