% Let T0 be the center point of top surface of the tesseorid and its
% equivalent mass rectangular prism;
% P is the computation point;
% T0P_glo is the position vector of point P with respect to T0(prism top surface
% center point) in the global coordinate system;
% T0P_loc is the position vector of point P with respect to T0(prism top surface
% center point) in the local edge system, where X->North, Y->East and Z->Up.
% This script is to transform the position vector in global system to local edge system (X->North,Y->East,Z->Up).
%Parameters (lon_P, lat_P, r_P) are the spherical coordinates of the computation point P and
%(lon_T0, lat_T0, r_T0) are the spherical coordinates of the top surface center point
%of the prism.
%Note that the r_P  and r_T0 are the distances from P and T0 to the earth
%center respectively and the earth is the spherical approximation.
function [vec_T0P_loc]=from_global_to_local_forCompPoint(lon_P, lat_P, r_P, lon_T0, lat_T0, r_T0)
    vec_T0P_glo = [r_P*cosd(lat_P)*cosd(lon_P) - r_T0*cosd(lat_T0)*cosd(lon_T0);...
              r_P*cosd(lat_P)*sind(lon_P) - r_T0*cosd(lat_T0)*sind(lon_T0);...
              r_P*sind(lat_P) - r_T0*sind(lat_T0)];
    %the transformation matrix, note that this matrix is to transform the
    %globle system to local coordinate system NEU (not the NED),be careful
    %about Z axis direction.
    aa=(90-lat_T0);
    bb=(180-lon_T0);
    transmatrix=[cosd(aa)*cosd(bb), -cosd(aa)*sind(bb),sind(aa);...
                 -sind(bb),        -cosd(bb),              0;...
                 -sind(aa)*cosd(bb), sind(aa)*sind(bb),cosd(aa)];
    vec_T0P_loc=transmatrix*vec_T0P_glo;
end