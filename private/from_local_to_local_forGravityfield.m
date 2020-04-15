function [vec_grav_p_loc]=from_local_to_local_forGravityfield(lonp, latp, lonT0, latT0, grav_vector_T0)
% T0 is the center point of top surface of the tesseroid and is also the
% origin of the local system of equivalent mass rectangular prism.
%
% the local coordinate system is X->North, Y->East and Z->Down.
%
% This script is to transform the gravity vector(grav_x,grav_y,grav_z) from
% the local system with respect to the prism into the local system with respect 
% to the computation point P(lonp,latp,rp)
 % The transformation matrix 
    A1 = cosd(lonT0-lonp)*sind(latp)*sind(latT0) + cosd(latp)*cosd(latT0);
    A2 = sind(lonT0-lonp)*sind(latp);
    A3 = -cosd(lonT0-lonp)*sind(latp)*cosd(latT0) + cosd(latp)*sind(latT0);
    A4 = -sind(lonT0-lonp)*sind(latT0);
    A5 = cosd(lonT0-lonp);
    A6 = sind(lonT0-lonp)*cosd(latT0);
    A7 = -cosd(lonT0-lonp)*cosd(latp)*sind(latT0) + sind(latp)*cosd(latT0);
    A8 = -sind(lonT0-lonp)*cosd(latp);
    A9 = cosd(lonT0-lonp)*cosd(latp)*cosd(latT0) + sind(latp)*sind(latT0);
    TransMatrix=[A1,A2,A3;
                 A4,A5,A6;
                 A7,A8,A9];
 % matrix multiplication to transform the gravaity field from 
    [vec_grav_p_loc]=TransMatrix*[grav_vector_T0(1);...
                                  grav_vector_T0(2);...
                                  grav_vector_T0(3)];
end