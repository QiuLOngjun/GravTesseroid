function [grav_shell]=grav_shell_at_pole(hp,R1,R2,density,Gconst,MEAN_EARTH_RADIUS)
%this script is to compute the gravitational contribution of a homogeneous
%spherical shell at the computation point that is along teh polar axis.
%the result is in m/s^2
% the parameter hp indicates the height of the computation point with
% respect to the surface of the earth.
%R1 and R2 indacate the inward and outer radius of the shell, respectively.
% the density is the constant density of the shell
%MMEAN_EARTH_RADIUS is the mean radius of the earth.
%Gconst is the gravitational constant
%Closed formula for the gravitational contribution of a homogeneous
%spherical shell
R1=R1+MEAN_EARTH_RADIUS; % inward radius R1 of the shell
R2=R2+MEAN_EARTH_RADIUS; % outer radius R2 of the shell
hp=hp+MEAN_EARTH_RADIUS;
grav_shell=4.0/3*pi*density*Gconst*(R2^3-R1^3)/(hp^2);    
end