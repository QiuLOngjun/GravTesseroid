function [res]=Pointmass_tess_g3(Lonp,Latp,Zp,WestLon,EastLon,SouthLat,NorthLat,Htop,Hbottom,density,Gconst,MEAN_EARTH_RADIUS)
%This script is to calculate the gravitatioinal attraction of the tesseroid
%by means of the point-mass method.
%the input parameters are the same as thoes in the function
%Taylor_tess_g3().
    d2r=pi/180;
    lam=Lonp*d2r;
    phi=Latp*d2r;
    r=Zp+MEAN_EARTH_RADIUS;
    r2=Htop+MEAN_EARTH_RADIUS;
    r1=Hbottom+MEAN_EARTH_RADIUS;
    WestLon=WestLon*d2r;%western longitude,lamda1
    EastLon=EastLon*d2r;%eastern longitude,lamda2
    SouthLat=SouthLat*d2r;%southern latitude,phi1
    NorthLat=NorthLat*d2r;%northern latitude,phi2
    dr=r2-r1;dphi=NorthLat-SouthLat;dlam=EastLon-WestLon;
    ra=0.5*(r1+r2);phia=0.5*(SouthLat+NorthLat);lama=0.5*(WestLon+EastLon);
    cos_psic=sin(phi)*sin(phia)+cos(phi)*cos(phia)*cos(lama-lam);
    els=abs(r*r+ra*ra-2*r*ra*cos_psic);
    el=sqrt(els);
    res=Gconst*density*dr*dphi*dlam*ra^2*cos(phia)*(ra*cos_psic-r)/el^3;
    % the direction of r in spherical coordinate system is up, in order to comply 
    % with traditional condition, i.e, making the mass of positive density 
    % have the positive gravity value.
    res=-res;
end