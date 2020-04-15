%This script is to plot a tesseroid and its equivalent-mass rectangular
%prism; the tesseroid is shown in global coordinate system and the
%parameters used to plot the rectangular prism are given in the coordinate
%of the prism (edge system).

%The transfermation from the edge system to the globla system is carried
%out by the function Plot_from_localedge_to_global().
figure;hold;
DrawRange=0;
N1=1; N2=0.75;% the radii of the outer and inner sphere
detLon=pi/6;
detLat=pi/6;
%the parameter for the size of the tesseroid
T_west=30;
T_east=30+30;
T_south=30;
T_north=30+30;
d2r=pi/180.0;
%Ploting the tesseroid
Plot_tesseroid(T_west*d2r,T_east*d2r,T_south*d2r,T_north*d2r,N2,N1,2,[0 1 0])%the last two parameters is linewidth and line color
%Ploting the outter grid
Plot_sphere(DrawRange,detLon ,detLat ,N1 ,0.2 ,[180/255 180/255 180/255])%the last two parameters is linewidth and line color
%Plotting the inner grid
Plot_sphere(DrawRange,detLon ,detLat ,N2 ,0.2 ,[200/255 200/255 200/255])%the last two parameters is linewidth and line color
%x-axis
tt3=-1.2:0.001:1.2;
dim2=size(tt3,2);
xx=tt3;
yy=zeros(1,dim2);
zz=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',1.5);
%y-axis
tt3=-1.2:0.001:1.2;
dim2=size(tt3,2);
yy=tt3;
xx=zeros(1,dim2);
zz=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',1.5);
%z-axis
tt3=-0.5:0.001:1.2;
dim2=size(tt3,2);
zz=tt3;
xx=zeros(1,dim2);
yy=zeros(1,dim2);
plot3(xx,yy,zz,'Color',[20/255 20/255 20/255],'LineWidth',1.5);
axis equal
axis off
view(160,8);
grid on
%the equivalent mass rectangular prism of the tesseroid
[PrismLon,PrismLat,PrismR,DX,DY,DZ,PrismDensity] =Tess2prism(T_west,T_east,T_south,T_north,N1,N2,1);
%converting the informaion of the eight vertexes of the prism in the edge
%system into that in golbal system.
gol_v1=Plot_from_localedge_to_global(DX/2,DY/2,0,PrismLon,PrismLat,PrismR);
gol_v2=Plot_from_localedge_to_global(DX/2,-DY/2,0,PrismLon,PrismLat,PrismR);
gol_v3=Plot_from_localedge_to_global(-DX/2,-DY/2,0,PrismLon,PrismLat,PrismR);
gol_v4=Plot_from_localedge_to_global(-DX/2,DY/2,0,PrismLon,PrismLat,PrismR);
gol_v5=Plot_from_localedge_to_global(DX/2,DY/2,-DZ,PrismLon,PrismLat,PrismR);
gol_v6=Plot_from_localedge_to_global(DX/2,-DY/2,-DZ,PrismLon,PrismLat,PrismR);
gol_v7=Plot_from_localedge_to_global(-DX/2,-DY/2,-DZ,PrismLon,PrismLat,PrismR);
gol_v8=Plot_from_localedge_to_global(-DX/2,DY/2,-DZ,PrismLon,PrismLat,PrismR);
polyhedron.vertices = [gol_v1';gol_v2';gol_v3';gol_v4';gol_v5';gol_v6';gol_v7';gol_v8'];
polyhedron.faces = [1 2 3 4;5 6 7 8;1 2 6 5;4 3 7 8;1 4 8 5;3 2 6 7];
%plotting the prism uisng the patch()
patch(polyhedron, 'FaceColor','none','EdgeColor','r','LineWidth',1);