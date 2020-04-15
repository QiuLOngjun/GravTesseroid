% This script is to obtain the computation time and results of the
% gravitational attraction component a3 of the crust1.0 model using the
% prism approximation approach.

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
tessmdNa='Crust1_Modeling_Prism';

%Computation grid parameters
Hp=255000%Observation height(m)
WestGr=-180;EastGr=180;Spacinglon=1;%computation grid range for longitude and grid nodes sapcing
SouthGr=-90;NorthGr=90;Spacinglat=1;%computation grid range for latitude and spacing along laittude direction
%Generating the computation grid using the function grid_gene_pixel();
griddata=grid_gene_pixel(WestGr,EastGr,SouthGr,NorthGr,Spacinglon,Spacinglat,Hp);
[gnr,gnc]=size(griddata);
gridnumber=gnr

%Initializing the variables 
Prism_grav=zeros(gridnumber,1);
%the mass element conversion using function Tess2prism()
prismmod=zeros(tessnumber,7);
for itess=1:1:tessnumber
    [prismmod(itess,1),prismmod(itess,2),prismmod(itess,3),prismmod(itess,4),prismmod(itess,5),...
        prismmod(itess,6),prismmod(itess,7)]=Tess2prism(tessmodel(itess,1),tessmodel(itess,2),...
        tessmodel(itess,3),tessmodel(itess,4),tessmodel(itess,5)+MEAN_EARTH_RADIUS,...
        tessmodel(itess,6)+MEAN_EARTH_RADIUS,tessmodel(itess,7));
end
tic
%Computing the gravitational contribution at computation grid nodes
%The unit of Prism_grav is mGal
    parfor grind=1:1:gridnumber
        Prism_grav(grind)=Pf_Prism_grav(griddata,grind,prismmod,MEAN_EARTH_RADIUS_local,G_local,SI2MGAL_local);
    end 
Res_grav=[griddata(:,1:2) Prism_grav];
toc
%Result variable name generation
eval([[tessmdNa,'_ObservH',num2str(Hp/1000),'km'] '=Res_grav;']);
save('A06_Crust1_grav',[tessmdNa,'_ObservH',num2str(Hp/1000),'km'],'-append');  %,'-append'