function [GLQ_grav_atP] = Pf_combined_GLQ(griddata,grind,tessmod,Psis,Highorder,Loworder,MEAN_EARTH_RADIUS_local,G_local,...
                                        GL_roots,GL_weights,SI2mGal_local)
% Pf_combined_GLQ is to compute the gravational attraction of tesseorids using
% the combined method, i.e., we employ  Gauss-Legendre quadrature with high 
% order and low order to perform the modeling in the near zone and far zone,
% respecitvely.
% griddata and tessmod are the matrix of the computation grid
% and the model,respectively.
% Psis is the boundary between the near and far zone;
% Highorder and Loworder are the orders of the Gauss-Legendre
% quadrature integration to use in the near and far zones respectively.
% the parameter GL_roots,GL_weights are matrixes that store the roots and their
% corresponding weights of the N-th order Gauss-Legendre quadrature   
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

GLQ_near=zeros(nearnr,1);
for nearid=1:1:nearnr
        GLQ_near(nearid)=SI2mGal_local*GLQ_tess_g3(griddata(grind,1),griddata(grind,2),...
                 griddata(grind,3),tessmod_near(nearid,1),tessmod_near(nearid,2),tessmod_near(nearid,3),...
                 tessmod_near(nearid,4),tessmod_near(nearid,5),tessmod_near(nearid,6),tessmod_near(nearid,7),...
                 Highorder,GL_roots,GL_weights,G_local,MEAN_EARTH_RADIUS_local);  
end

GLQ_far=zeros(farnr,1);
for farid=1:1:farnr
        GLQ_far(farid)=SI2mGal_local*GLQ_tess_g3(griddata(grind,1),griddata(grind,2),...
                 griddata(grind,3),tessmod_far(farid,1),tessmod_far(farid,2),tessmod_far(farid,3),...
                 tessmod_far(farid,4),tessmod_far(farid,5),tessmod_far(farid,6),tessmod_far(farid,7),...
                 Loworder,GL_roots,GL_weights,G_local,MEAN_EARTH_RADIUS_local);  
end

GLQ_grav_atP=sum(GLQ_near)+sum(GLQ_far);
end