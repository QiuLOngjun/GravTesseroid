% This script is to obtain the computation time and the results of the
% gravitational attraction of the crust1.0 uisng the combined GLQ method.
% The combined GLQ method uses Gauss-Legendre quadrature with orde of 2 and
% 5 for the tesserois in the far and near zone, respectively.
% The parameter Psis is the boundary between the near zone and far zone.
% The computation is performed on a 1¡ãx1¡ãgrid over the earth .
% the global variable MEAN_EARTH_RADIUS the mean radius of the earth;
% the global variable G the gravitational constant in the program.

clear all;clc;
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
tessmdNa='Crust1_Modeling';
% Setting of the order of Gauss-Legendre quadrature
Read_GL_rootandweights;%Reading the roots of Legendre polynomial and their weights
%Computation grid parameters
Hp=255000%Observation height(m)
WestGr=-180;EastGr=180;Spacinglon=1;%computation grid range for longitude and grid nodes sapcing
SouthGr=-90;NorthGr=90;Spacinglat=1;%computation grid range for latitude and spacing along laittude direction
%Generating the computation grid using the function grid_gene_pixel();
griddata=grid_gene_pixel(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp);
[gnr,gnc]=size(griddata);
%Initializing the variables 
GLQ_oneComp=zeros(gnr,1);
Psis=5
tic
%Computing the gravitational contribution at computation grid nodes
%the parameter Psis indicate the spherical distance with respect to the
%computation point and it defines the boundary between the near and far
%zone
    parfor grind=1:1:gnr
        GLQ_oneComp(grind)=Pf_combined_GLQ(griddata,grind,tessmodel,Psis,5,2,MEAN_EARTH_RADIUS_local,G_local,...
                         GL_roots,GL_weights,SI2MGAL_local);
    end 
Res_grav=[griddata(:,1:2) GLQ_oneComp];
toc
%Result variable name generation
eval([[tessmdNa,'_ObservH',num2str(Hp/1000),'km_CombinedGLQ_Psis_',num2str(Psis)] '=Res_grav;']);
save('A06_Crust1_grav',[tessmdNa,'_ObservH',num2str(Hp/1000),'km_CombinedGLQ_Psis_',num2str(Psis)] ,'-append');  %,'-append'