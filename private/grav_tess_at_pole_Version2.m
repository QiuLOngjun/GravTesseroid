function [grav_res]=grav_tess_at_pole_Version2(Zp,WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density,Gconst,MEAN_EARTH_RADIUS)
%An analytical solution exists when the computation point is located at polar axis
%parameter Zp indicates the computation height, r1 the tesseroid bottom
%height, r2 the tesseroid top height,psi1 indicates (pi/2- north latitude),
%psi2 indicates (pi/2- south latitude)

%the solution of the gravitaitonal attraction of a spherical cap is provided 
%by Heck & Seitz (2007) in the appendix 4 and the solution of a tesseroid
%is the difference between two shperical cap with different spherical distances psi_i that
%count from the computation point to the edge of the cap.

%the unit convertion of Longitude and Latitude for tesseroids
d2r=pi/180;
WestLon=WestLon*d2r;
EastLon=EastLon*d2r;
SouthLat=SouthLat*d2r;
NorthLat=NorthLat*d2r;
r2=Htop+MEAN_EARTH_RADIUS;%top surface height
r1=Hbottom+MEAN_EARTH_RADIUS;%bottom surface height
psi1=pi/2-NorthLat;
psi2=pi/2-SouthLat;
delta_lam=EastLon-WestLon;
r=Zp+MEAN_EARTH_RADIUS; % the distance from the computation point to the center of the earth

%performing the computation of gravitational attraction due to one tesseroid.
if psi1~=0
    grav_res=Gconst*density*delta_lam*...
    (Grav_contribution_cap(r,r1,r2,psi2)-Grav_contribution_cap(r,r1,r2,psi1));
else
    grav_res=Gconst*density*delta_lam*Grav_contribution_cap(r,r1,r2,psi2);
end

    function [res_cap]=Grav_contribution_cap(r,r1,r2,psi)  
            res_cap=Grav_cap_sub(r,r2,psi)-Grav_cap_sub(r,r1,psi); 
    end

    function [res_sub]=Grav_cap_sub(r,ra,psi)
       elc=sqrt(r*r+ra*ra-2*r*ra*cos(psi));
       res_sub=1.0/(3*r*r)*elc^3-elc*(r-ra*cos(psi))/r+0.5*elc*cos(psi)*cos(psi)-...
                 0.5*cos(psi)*(ra-r*cos(psi))*(r-ra*cos(psi))/elc-...
                 r*cos(psi)*sin(psi)*sin(psi)*log(elc+ra-r*cos(psi))-...
                 0.5*r*r*cos(psi)*sin(psi)*sin(psi)*(r-(elc+ra)*cos(psi))/(elc*(elc+ra-r*cos(psi)))+...
                 1/(3*r*r)*ra^3;
    end 
end


