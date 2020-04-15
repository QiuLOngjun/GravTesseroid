function [ res ] = Taylor_tess_g3(Lonp,Latp,Zp,WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density,Gconst,MEAN_EARTH_RADIUS)
%Taylor series expansion method for modeling the gravitatinal attraction component due to a tesseroid, 
%Referred to T.Grombein et al. 2013 Optimized formulas for the gravitational field of a tesseroid, Journal of Geodesy
%Lonp,Latp,Zp is the location of the computation point
%WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density is the information of the tesseroid.
%Gconst is the Gravitational Constant and MEAN_EARTH_RADIUS is the earth radius
%the result is res in SI unit.
%the unit convertion of Longitude and Latitude for tesseroids
d2r=pi/180;
% store one tessroid information from model data    
WestLon=WestLon*d2r;%western longitude
EastLon=EastLon*d2r;%eastern longitude
SouthLat=SouthLat*d2r;%southern latitude
NorthLat=NorthLat*d2r;%northern latitude
Htop=Htop+MEAN_EARTH_RADIUS;%top surface height
Hbottom=Hbottom+MEAN_EARTH_RADIUS;%bottom surface height
%Setting Taylor point of integral domain, 
ra=0.5*(Htop+Hbottom);
phia=0.5*(SouthLat+NorthLat);
lama=0.5*(WestLon+EastLon);
%Setting delta_r, delta_phi, delta_lamda and omeg
delta_r=Htop-Hbottom;
delta_phi=NorthLat-SouthLat;
delta_lam=EastLon-WestLon;
omeg=Gconst*density*delta_r*delta_phi*delta_lam;
%Setting only one computation point
lam=Lonp*d2r;
phi=Latp*d2r;
r=Zp+MEAN_EARTH_RADIUS;
%Setting variables,using formula(42)-(52) in T.Grombein et al 2013,referred to
%Optimized formulas for the gravitational field of a tesseroid, Journal of Geodesy
cospsic=sin(phi)*sin(phia)+cos(phi)*cos(phia)*cos(lama-lam);
els=abs(r*r+ra*ra-2*r*ra*cospsic);
el=sqrt(els);
delx2=ra*cos(phia)*sin(lama-lam);
delx3=ra*cospsic-r;
%Cphi=cos(phi)*sin(phia)-sin(phi)*cos(phia)*cos(lama-lam);
%Clam=cos(phi)*cos(phia)*sin(lama-lam);
tau=ra*ra*cos(phia);
tau_k=[2*ra*cos(phia),-ra*ra*sin(phia),0]';
taup_k=[2*cos(phia),-ra*ra*cos(phia),0]';
delx2_k=[cos(phia)*sin(lama-lam),-ra*sin(phia)*sin(lama-lam),ra*cos(phia)*cos(lama-lam)]';
delx3_k=[cospsic,ra*(sin(phi)*cos(phia)-cos(phi)*sin(phia)*cos(lama-lam)),-delx2*cos(phi)]';
%delx2p_k=[0,-delx2,-delx2]';
delx3p_k=[0,-ra*cospsic,-delx2_k(3)*cos(phi)]';
elb_k=[r*cospsic-ra,r*delx3_k(2),r*delx3_k(3)]';
elbp_k=[-1,r*delx3p_k(2),r*delx3p_k(3)]';
beta_3_k=2*(delx3_k+3*delx3/(els)*elb_k);
gamma_3_k=delx3p_k+3*( 2*delx3_k.*elb_k+delx3*(elbp_k+5*elb_k.*elb_k/(els)) )/(els);
%Computing  Coefficients of Taylor series for Gravitational Attraction gz
L_3_order_zero=tau*delx3/(el^3);
L_3_order_sed=(taup_k*delx3+tau_k.*beta_3_k+tau*gamma_3_k)/(el^3); 
%Computing gz just for one tessroid at one computation point
res=omeg*L_3_order_zero+omeg/24*...
                            (delta_r*delta_r*L_3_order_sed(1)+...
                             delta_phi*delta_phi*L_3_order_sed(2)+...
                             delta_lam*delta_lam*L_3_order_sed(3));  
% make z direction point down to the center of the Earth                         
res=-res;   
end

