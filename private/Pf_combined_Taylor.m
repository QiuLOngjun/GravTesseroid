function [Taylor_grav_atP] = Pf_combined_Taylor(griddata,grind,tessmod,Psis,MEAN_EARTH_RADIUS_local,G_local,SI2mGal_local)
% the function is to compute the gravational contribution of tesseorids at
% one observation point,and we use the combined methods to calculate the gravitational
% effect of tesseroids. We employ Taylor seires expansioin to
% compute the gravitational effect of the tesseroids in the near zone and use
% point mass approximation method to calculate the effect of the tesseroids in the
% far zone.
% The boundary between near and far zone is indicated the parameter Psis, which
% is the spherical distance with respect to the computation point.
tessmod_near=tessmod;
tessmod_far=tessmod;
[tessnumber,nc]=size(tessmod);     
tessadd=zeros(tessnumber,1);
tessmod=[tessmod tessadd];
% the unit convertion of Longitude and Latitude for tesseroids
d2r=pi/180;
cos_Psis=cos(Psis*d2r);
lamdp=griddata(grind,1)*d2r;%computation node longitude
phip=griddata(grind,2)*d2r;%computation node latitude
for ii =1:1:tessnumber
    % store one tessroid information from model data    
    lamd0=0.5*d2r*(tessmod(ii,1)+tessmod(ii,2));%the longitude of the center of the top surface
    phi0=0.5*d2r*(tessmod(ii,3)+tessmod(ii,4));%the latitude of the center of the top surface
    % the spherical distance between the computation point and the tesseroid
    % top surface center
    tessmod(ii,8) = sin(phi0)*sin(phip)+cos(phi0)*cos(phip)*cos(lamd0-lamdp);
end
idlog=tessmod(:,8)>=cos_Psis;
tessmod_far(idlog,:)=[];
idlog_near=~idlog;
tessmod_near(idlog_near,:)=[];
[nearnr,nearnc]=size(tessmod_near);
[farnr,farnc]=size(tessmod_far);

Taylor_near=zeros(nearnr,1);
for nearind=1:1:nearnr
         Taylor_near(nearind)=SI2mGal_local*Taylor_tess_g3(griddata(grind,1),griddata(grind,2),...
                 griddata(grind,3),tessmod_near(nearind,1),tessmod_near(nearind,2),tessmod_near(nearind,3),tessmod_near(nearind,4),...
                 tessmod_near(nearind,5),tessmod_near(nearind,6),tessmod_near(nearind,7),...
                 G_local,MEAN_EARTH_RADIUS_local);
end
Taylor_grav_atP_near=sum(Taylor_near);
Taylor_far=zeros(farnr,1);
for farind=1:1:farnr
         Taylor_far(farind)=SI2mGal_local*Pointmass_tess_g3(griddata(grind,1),griddata(grind,2),...
                 griddata(grind,3),tessmod_far(farind,1),tessmod_far(farind,2),tessmod_far(farind,3),tessmod_far(farind,4),...
                 tessmod_far(farind,5),tessmod_far(farind,6),tessmod_far(farind,7),...
                 G_local,MEAN_EARTH_RADIUS_local);
end
Taylor_grav_atP_far=sum(Taylor_far);
Taylor_grav_atP=Taylor_grav_atP_far+Taylor_grav_atP_near;
%fprintf("Loop %d completed\n",grind);
end