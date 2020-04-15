function [ res_GL ] = GLQ_tess_g3( Lonp,Latp,Zp,WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density,Norder,GL_roots,GL_weights,Gconst,MEAN_EARTH_RADIUS )
% This function is to calculate the gravitatinal acceleration of a individual
% tesseroid at one computation point using the Gauss-Legendre quadrature 
% integratioin in the local coordinate system with respect to the computation
% point( where X->North Y->East Z->Up).
% The program code use 1,2 and 3 to indicate X,Y and Z direction.
% One tesseroid information: (WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density) 
% One computation point information: (Lonp,Latp,Zp) 
% Norder is the order of the Gauss-Legendre quadrature;
% GL_roots and GL_weights are pre-planned arrays that are the quadrature
% nodes and corresponding weights;
% Gconstant is the gravitational constant.

% the unit convertion of Longitude and Latitude for tesseroids
d2r=pi/180;
% store one tessroid information from model data    
WestLon=WestLon*d2r;%western longitude,lamda1
EastLon=EastLon*d2r;%eastern longitude,lamda2
SouthLat=SouthLat*d2r;%southern latitude,phi1
NorthLat=NorthLat*d2r;%northern latitude,phi2
Htop=Htop+MEAN_EARTH_RADIUS;%top surface height,r2 
Hbottom=Hbottom+MEAN_EARTH_RADIUS;%bottom surface height,r1
%Setting only one computation point
lam=Lonp*d2r;
phi=Latp*d2r;
r=Zp+MEAN_EARTH_RADIUS;
%Setting weights and unscaled roots for each direction
weights=GL_weights(0.5*(Norder*Norder-Norder):0.5*(Norder*Norder+Norder-2));
roots=GL_roots(0.5*(Norder*Norder-Norder):0.5*(Norder*Norder+Norder-2));
%Setting r0 phi0 and lamda0
ra=0.5*(Htop+Hbottom);   phia=0.5*(SouthLat+NorthLat);   lama=0.5*(WestLon+EastLon);
%Setting delta_r, delta_phi, delta_lamda and omeg
delta_r=Htop-Hbottom;   delta_phi=NorthLat-SouthLat;   delta_lam=EastLon-WestLon;
%Setting scaled Legendre polynomials roots of Order N_order for lamda ,phia and ra
ra_roots=0.5*delta_r*roots+ra;
phia_roots=0.5*delta_phi*roots+phia;
lama_roots=0.5*delta_lam*roots+lama;
%Implementing GLQ procesure to compute gravitational attraction;
res_sum=0.0;
for nk=1:Norder  %loop for lamd 
    for nj=1:Norder  %loop for phi
        cos_psic=sin(phi)*sin(phia_roots(nj))+cos(phi)*cos(phia_roots(nj))*cos(lama_roots(nk)-lam);
        for ni=1:Norder  %loop for r
            tau=ra_roots(ni)*ra_roots(ni)*cos(phia_roots(nj));
            el=sqrt(r*r+ra_roots(ni)*ra_roots(ni)-2*r*ra_roots(ni)*cos_psic);
            res_sum=res_sum+weights(nk)*weights(nj)*weights(ni)*tau*(ra_roots(ni)*cos_psic-r)/(el^3);
        end
    end
end
res_GL=Gconst*density*0.125*delta_r*delta_phi*delta_lam*res_sum;
% make z direction point down to the center of the Earth                         
res_GL=-res_GL;    
end