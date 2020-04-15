% This script is to compute the first order derivative of the topographic 
% potential of the RET model obtained from Earthquake2014 using the
% prism approximation approach.

%The RET data (denoted by Earth2014_RET_5min_spherical_appro) is stored in
% diskfile RET_5min_computed_from_Earth2014.

%The computation grid is generated by the function grid_gene_pixel()

% Earth2014 model is provided by Michael Kuhn1 and Christian Hirt(2016),
% and please refer to Topographic gravitational potential up to second-orderderivatives: 
% an examination of approximation errors causedby rock-equivalent topography(RET)

% the global variable MEAN_EARTH_RADIUS the mean radius of the earth;
% the global variable G the gravitational constant in the program.

clear all;
global MEAN_EARTH_RADIUS;global G;global SI2mEOTVOS;global SI2MGAL;
SI2mEOTVOS=1000000000000.0;SI2MGAL=100000.0;MEAN_EARTH_RADIUS = 6378137.0;G = 0.0000000000667191;
%for parfor loop, using the local variables
MEAN_EARTH_RADIUS_local=MEAN_EARTH_RADIUS;G_local=G;SI2mEOTVOS_local=SI2mEOTVOS;SI2MGAL_local=SI2MGAL;

%Reading Earth2014_RET model
load RET_5min_computed_from_Earth2014
tessmodel = Earth2014_RET_5min_spherical_appro';
[modnr,modnc]=size(tessmodel);
tessnumber=modnr
% the tess model variable name setting
tessmdNa='Earth2014RET_Prism'

%Computation grid parameters
Hp=250000%Observation height(m)
WestGr=-135;EastGr=-60;Spacinglon=0.5;%computation grid range for longitude and grid nodes sapcing
SouthGr=0;NorthGr=60;Spacinglat=0.5;%computation grid range for latitude and spacing along laittude direction
%Generating the computation grid using the function grid_gene_pixel();
griddata=grid_gene_pixel(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp);
[gnr1,gnc1]=size(griddata);
fprintf('the number of the grid nodes is %d\n',gnr1)

tic
%the mass element conversion using function Tess2prism()
prismmod=zeros(tessnumber,7);
for itess=1:1:tessnumber
    [prismmod(itess,1),prismmod(itess,2),prismmod(itess,3),prismmod(itess,4),prismmod(itess,5),...
        prismmod(itess,6),prismmod(itess,7)]=Tess2prism(tessmodel(itess,1),tessmodel(itess,2),...
        tessmodel(itess,3),tessmodel(itess,4),tessmodel(itess,5)+MEAN_EARTH_RADIUS,...
        tessmodel(itess,6)+MEAN_EARTH_RADIUS,tessmodel(itess,7));
end
%Initializing the variables 
Prism_grav=zeros(gnr1,1);
startmatlabpool(16)
%Computing the gravitational contribution at computation grid nodes
    parfor grind=1:1:gnr1
        Prism_grav(grind)=Pf_Prism_grav(griddata,grind,prismmod,MEAN_EARTH_RADIUS_local,G_local,SI2MGAL_local);
    end 
closematlabpool   
toc

Res_grav=[griddata(:,1:2) Prism_grav];
eval([[tessmdNa,'_ObservH',num2str(Hp/1000),'km'] '=Res_grav;']);