% This script is to obtain the computation time and results the
% gravitational attraction component a3 of the crust1.0 model using the
% Taylor series expansion.

% The computation is performed on a 1¡ãx1¡ãgrid over the earth .
% the global variable MEAN_EARTH_RADIUS the mean radius of the earth;
% the global variable G the gravitational constant in the program.
clear all;
global MEAN_EARTH_RADIUS;global G;global SI2mEOTVOS;global SI2MGAL;
SI2mEOTVOS=1000000000000.0;SI2MGAL=100000.0;MEAN_EARTH_RADIUS = 6378137.0;G = 0.0000000000667191;
%for parfor loop, using the local variables
MEAN_EARTH_RADIUS_local=MEAN_EARTH_RADIUS;G_local=G;SI2mEOTVOS_local=SI2mEOTVOS;SI2MGAL_local=SI2MGAL;

%Reading tessroid model file from diskfile.
modelfiel='A06_Crust1.model';
tessmodel = importdata(modelfiel);
[modnr,modnc]=size(tessmodel);
tessnumber=modnr
% the tess model variable name setting
tessmdNa='Crust1_Modeling_Taylor';

%Computation grid parameters
Hp=255000%Observation height(m)
WestGr=-180;EastGr=180;Spacinglon=1;%computation grid range for longitude and grid nodes sapcing
SouthGr=-90;NorthGr=90;Spacinglat=1;%computation grid range for latitude and spacing along laittude direction
%Generating the computation grid using the function grid_gene_pixel();
griddata=grid_gene_pixel(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp);

tic
[gnr1,gnc1]=size(griddata);
Taylor_grav_1=zeros(gnr1,1);
%Computing the gravitational contribution at computation grid nodes
    parfor grind=1:1:gnr1
        Taylor_grav_1(grind)=Pf_Taylor_grav(griddata,grind,tessmodel,MEAN_EARTH_RADIUS_local,G_local,SI2MGAL_local);
    end 
toc

Res_grav=[griddata(:,1:2) Taylor_grav_1];
eval([[tessmdNa,'_ObservH',num2str(Hp/1000),'km'] '=Res_grav;']);
save('A06_Crust1_grav',[tessmdNa,'_ObservH',num2str(Hp/1000),'km'],'-append');  %,'-append'