function [grav]=grav_tess_at_pole(hp,WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density,Gconst,MEAN_EARTH_RADIUS)
%this script is to compute the contribution of a tesseroid to the
%gravitational acceleration at a computation point P that is along the
%rotation axis and an analytical solution exists on this condition.

% Anna Maria Marotta1 & Riccardo Barzaghi ги2017) provided the analytical
% expression for the effect due to an individual tesseroid in thier paper's
% appendix 2.

% MEAN_EARTH_RADIUS is the mean radius of the earth
% r is the radius of the computation point to the center of the earth
% the unit of the result grav is m/s^2
r=hp+MEAN_EARTH_RADIUS; 
%
d2r=pi/180;
WestLon=WestLon*d2r;
EastLon=EastLon*d2r;
SouthLat=SouthLat*d2r;
NorthLat=NorthLat*d2r;
%theta is colatitude and theta2>theta1;
theta1=pi/2-NorthLat;
theta2=pi/2-SouthLat;
%r1 and r2 are radiuses of the bottom and top surface of the tesseroid respectively to the origin O;
r2=Htop+MEAN_EARTH_RADIUS;
r1=Hbottom+MEAN_EARTH_RADIUS;
%the difference of the pair of the longitudes, i.e. the longitudinal extension of the tesseroid.
delta_lam=EastLon-WestLon;
I=I_rq(r,r1,r2,theta2)-I_rq(r,r1,r2,theta1);
grav=Gconst*density*delta_lam*I/(r*r);
function [Irq_res]=I_rq(r,r1,r2,theta) 
    if theta==0
       Irq_res=I_rq_sub1(r,r2,theta)-I_rq_sub1(r,r1,theta);% the case of the  sectors with triangular surface
    else
	   Irq_res=I_rq_sub(r,r2,theta)-I_rq_sub(r,r1,theta);	
    end
end
function [Isub_res]=I_rq_sub(r,ra,theta)
       Isub_res=1.0/3*(ra*ra+r*r*(3*cos(theta)*cos(theta)-2)+r*ra*cos(theta))*sqrt(ra*ra+r*r-2*ra*r*cos(theta))+...
				cos(theta)*(cos(theta)*cos(theta)-1)*r*r*r*log(2*(sqrt(ra*ra+r*r-2*ra*r*cos(theta))+ra-r*cos(theta)));                 
end
function [Isub_res]=I_rq_sub1(r,ra,theta)
       Isub_res=1.0/3*(ra*ra+r*r*(3*cos(theta)*cos(theta)-2)+r*ra*cos(theta))*sqrt(ra*ra+r*r-2*ra*r*cos(theta));           
end
end