% This script it to calculates the gravitational attraction caused by a
% rectangular prism  instead of the equal-mass tesseroid.
% the closed formulas for the forward modeling of the gravitational
% attraction of the prism are given by the Nagy et al. (2000), which uses 
% the local edeg system of the prism where X axis points North, Y East and Z  Down
% There are there steps for the whole process.
%Step 1: Converting a tesseroid to a rectangular prism, and make the center
%point of the top surface of the tesseroid as the origin of the edeg system
%by the function Tess2prism().
%Step 2:Transforming the position vector in globle system to local
%Cartesian coordinate (X->North,Y->East,Z->down),Note the Z axis direction
%is poiting down to comply with formulas of the Nagy et al. (2000)
%Step 3:Using the closed formulas in Nagy et al.(2000) to compute the effect of
%the prism and the result is analytical solution.
clear; clc;
global Gconst;%the unit of Gravitational Constant G is  m^3/(kg¡¤s^2
Gconst = 0.0000000000667191;
global SI2EOTVOS;
SI2EOTVOS=1000000000.0;
global SI2MGAL;
SI2MGAL=100000.0;
global MEAN_EARTH_RADIUS;
MEAN_EARTH_RADIUS = 6378137.0;
MEAN_EARTH_RADIUS_local=MEAN_EARTH_RADIUS;
SI2MGAL_local=SI2MGAL;
G_local=Gconst;
% Setting of the parameters
Hp=200000%Observation height(m)
tessWid=1;% the horizontal dimensions of the tesseroid unit is degrees, such as 1degree
TopH=2000;BottomH=0;% the top and bottome surface
tessDen=2670;% the tesseroid density unit is kg/(m)^3
% the tess model variable name setting
tessmdNa=['tess_1degx1deg','_dr',num2str((TopH-BottomH)/1000),'km'];
WestGr=0;EastGr=tessWid/2;Spacinglon=tessWid/6;%computation grid range for longitude and grid nodes sapcing
SouthGr=0;NorthGr=90;Spacinglat=0.25;%computation grid range for latitude and spacing along laittude direction
%Discretizing the shell into tesseroid model
tessmodel=tess_genera_model(tessWid,TopH,BottomH,tessDen);
[modnr,modnc]=size(tessmodel);
tessnumber=modnr
%Generating the computation grid using the function grdi_gene();
griddata=grid_gene(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp);
[gnr,gnc]=size(griddata);
gridnumber=gnr

%Closed formula for the gravitational attraction component
Density_shell=tessmodel(1,7);% Shell density is equal to tesseroid density
R1_shell=MEAN_EARTH_RADIUS+tessmodel(1,6); % inward radius R1 of the shell
R2_shell=MEAN_EARTH_RADIUS+tessmodel(1,5); % outer radius R2 of the shell
M1=Density_shell*4/3*pi*(R1_shell^3);
M2=Density_shell*4/3*pi*(R2_shell^3);
Analy_grav=Gconst*(M2-M1)/((griddata(1,3)+MEAN_EARTH_RADIUS)^2)*SI2MGAL;

%Computing the gravitational attraction at the computationa point
grav_atP=zeros(gridnumber,1);
prismmod=zeros(modnr,7);
% the mass element conversion by the function [PrismLon,PrismLat,PrismR,DX,DY,DZ,PrismDensity] 
%          =Tess2prism    (WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,tessDensity)
for itess=1:1:modnr
    [prismmod(itess,1),prismmod(itess,2),prismmod(itess,3),prismmod(itess,4),prismmod(itess,5),...
        prismmod(itess,6),prismmod(itess,7)]=Tess2prism(tessmodel(itess,1),tessmodel(itess,2),...
        tessmodel(itess,3),tessmodel(itess,4),tessmodel(itess,5)+MEAN_EARTH_RADIUS,...
        tessmodel(itess,6)+MEAN_EARTH_RADIUS,tessmodel(itess,7));
end
%Computing the gravitational attraction components at P using the function
%Pf_Prism_grav()
tic
parfor grind=1:1:gridnumber
         grav_atP(grind)=Pf_Prism_grav(griddata,grind,prismmod,MEAN_EARTH_RADIUS_local,G_local,SI2MGAL_local);
end 
AbsoError=abs(grav_atP - Analy_grav);
Differ_grav=[griddata(:,1:2) AbsoError];
toc
%Result variable name generation      
% eval([[tessmdNa,'_ObservH',num2str(Hp/1000),'km_PrismApproa'] '=Differ_grav;']);
% save('A04_Difference_grav_PrismApproa',[tessmdNa,'_ObservH',num2str(Hp/1000),'km_PrismApproa'],'-append');  %,'-append'
