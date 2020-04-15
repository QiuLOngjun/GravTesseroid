%This script is to plot the figure for the derivative of the potential
%of the Earth2014 RET model
clear;close all
load A08_RETbyEarth2014_and_its_grav;
figure (101);
latmin=0.25;
latmax=59.75;
dlat=0.5;
latlim=latmin:dlat:latmax;
nlat=(latmax-latmin)/dlat+1;
lonmin=-134.75;
lonmax=-60.25;
dlon=0.5;
lonlim=lonmin:dlon:lonmax;
nlon=(lonmax-lonmin)/dlon+1;
gra = Earth2014RET_Taylor_ObservH250km(:,3);%data
gra= reshape(gra,nlon,nlat);
gra=gra';
[lon,lat]=meshgrid(lonlim,latlim);

ax1=worldmap([latmin latmax],[lonmin lonmax])
geoshow(lat,lon,gra,'DisplayType', 'texture');
cmap = cptcmap('.\private\cptfiles\sst');
colormap(cmap);
cl=colorbar;
set(get(cl,'Title'),'string','Gmal');
% load coastlines;
% geoshow(ax1, coastlat, coastlon,'DisplayType', 'polygon', 'FaceColor', 'none');
setm(ax1,'GLineStyle','-', 'Grid','on','Frame','on');
%%

figure (102);
latmin=5/120;
latmax=60-5/120;
dlat=5/60;
latlim=latmin:dlat:latmax;
nlat=round((latmax-latmin)/dlat+1);
lonmin=-135+5/120;
lonmax=-60-5/120;
dlon=5/60;
lonlim=lonmin:dlon:lonmax;
nlon=round((lonmax-lonmin)/dlon+1);
topo=Earth2014_RET_For_NorthAmerica(:,3);
topo= reshape(topo,nlon,nlat);
topo=topo';
[lon,lat]=meshgrid(lonlim,latlim);
ax2=worldmap([latmin latmax],[lonmin lonmax])
geoshow(lat,lon,topo,'DisplayType', 'texture');
cmap0 = cptcmap('.\private\cptfiles\GMT_relief');
colormap(cmap0);
cl0=colorbar;
set(get(cl0,'Title'),'string','m');
% load coastlines;
% geoshow(ax2, coastlat, coastlon,'DisplayType', 'polygon', 'FaceColor', 'none');
setm(ax2,'GLineStyle','-', 'Grid','on','Frame','on');

%%
% %Reading Earth2014_RET model
% load Earth2014_5min_Abstract
% tessmodel = Earth2014_RET_5min_spherical_appro;
% [nrtess,nctess]=size(tessmodel);
% lon_min=-135;lon_max=-60;
% lat_min=0;lat_max=60;
% kk=1;
% for ii=1:1:nctess
%    if tessmodel(1,ii)>=lon_min && tessmodel(2,ii)<=lon_max...
%       && tessmodel(3,ii)>=lat_min && tessmodel(4,ii)<=lat_max
%       topomodel(kk,1)=0.5*(tessmodel(1,ii)+tessmodel(2,ii));
%       topomodel(kk,2)=0.5*(tessmodel(3,ii)+tessmodel(4,ii));
%       if(tessmodel(5,ii)>0)
%           topomodel(kk,3)=tessmodel(5,ii);
%       else
%           topomodel(kk,3)=tessmodel(6,ii);
%       end
%       kk=kk+1;
%    end    
% end    