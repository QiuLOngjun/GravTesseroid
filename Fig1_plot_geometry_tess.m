%This script is to draw the shape of the sphere and the tesseorid
addpath('.\drawing_tess_scripts')
clear all;
figure;hold;

DrawRange=1;% the value {0,1,2} of the DrawRange indicate the range of the sphere one eighth of, half and the whole sphere.
N1=1; N2=0.85;N3=0.55 % the radius of three different size for three spheres
detLon=pi/6;
detLat=pi/6;
%the shape and size of the tesseroid
T_west=pi/6;
T_east=pi/6+pi/6;
T_south=pi/6;
T_north=pi/6+pi/6;
Plot_tesseroid(T_west,T_east,T_south,T_north,N3,N2,2,[0 1 0])%the last two parameters is linewidth and line color

%plotting the outer computation grid
%Plot_sphere(DrawRange,detLon ,detLat ,1 ,0.2 ,[190/255 190/255 190/255])%the last two parameters is linewidth and line color
%Plotting the first sphere and its radius is N1
Plot_sphere(DrawRange,detLon ,detLat ,N1 ,1.2 ,[127/255 1 212/255])%the last two parameters is linewidth and line color
%Plotting the second sphere and its radius is N2
Plot_sphere(DrawRange,detLon ,detLat ,N2 ,1.2 ,[200/255 200/255 200/255])%the last two parameters is linewidth and line color
%Plotting the third sphere and its radius is N3
Plot_sphere(DrawRange,detLon ,detLat ,N3 ,1.2 ,[200/255 200/255 200/255])%the last two parameters is linewidth and line color

% x-axis 
tt3=-1.2:0.001:1.2;
dim2=size(tt3,2);
xx=tt3;
yy=zeros(1,dim2);
zz=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',0.5);
%y-axis
tt3=-1.2:0.001:1.2;
dim2=size(tt3,2);
yy=tt3;
xx=zeros(1,dim2);
zz=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',0.5);
%z-axis
tt3=-0.5:0.001:1.2;
dim2=size(tt3,2);
zz=tt3;
xx=zeros(1,dim2);
yy=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',0.5);
%Angle of view
axis equal
axis off
view(100,15);
grid on
%%
%plotting the arrows of the axis 
scatter3(1,0,0,50,'g','filled');
scatter3(0,1,0,50,'b','filled');

%%
%Showing the distribution of the Gauss-Legendre equivalent nodes
Read_GL_rootandweights;
LonOrd=2;LatOrd=2;ROrd=2;Norder=2;
[ Loncoor,Latcoor,Rcoor] = Get_rootscoordi( T_west,T_east,T_south,T_north,N2,N3,GL_roots,LonOrd,LatOrd,ROrd);
for Loni=1:1:LonOrd
    for Lati=1:1:LatOrd
        for Ri=1:1:ROrd
 scatter3(Rcoor(Ri)*cos(Latcoor(Lati))*cos(Loncoor(Loni)),Rcoor(Ri)*cos(Latcoor(Lati))*sin(Loncoor(Loni)),Rcoor(Ri)*sin(Latcoor(Lati)),30,'k','filled');%set symblo size as 15
        end
    end
end
Plot_plane_for_nodes(T_west,T_east,T_south,T_north,N3,N2,1.5,[127/255 1 252/255],GL_roots,Norder)
%%
%Showing the central point of the tesseroid
R0=0.5*(N2+N3); Lon0=0.5*(T_west+T_east); Lat0=0.5*(T_south+T_north);
scatter3(R0*cos(Lat0)*cos(Lon0),R0*cos(Lat0)*sin(Lon0),R0*sin(Lat0),50,'g','filled');