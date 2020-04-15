function Global_P=Plot_from_localedge_to_global(locx,locy,locz,LonT0,LatT0,T0radius)
%The function Plot_from_localedge_to_global is to convert the local edge
%system of a point P(locx,locy,locz) to the global coordinate system in
%order to plot the point P.

%In the local edge system,Z->up£¬X->North, Y->East;
%Parameters locx,locy,locz are the local coordinates and LonT0,LatT0,rT0 are
%the longitude, latitude and altitude from the T0 to the center of the
%earth.

%The presentation for the distance from P to T0 in the local edge system.
vec_T0P_loc=[locx;
             locy;
             locz];
%Converting the T0P into the global coordinates using the following matrix.
    aa=(90-LatT0);
    bb=(180-LonT0);
    transmatrix=[cosd(aa)*cosd(bb) ,-sind(bb),-sind(aa)*cosd(bb);...
                 -cosd(aa)*sind(bb),-cosd(bb), sind(aa)*sind(bb);...
                     sind(aa),           0,            cosd(aa)];
%Converting formula
    vec_T0P_glo=transmatrix*vec_T0P_loc;
%The global coordinates of T0
     Rt=T0radius;
     Global_T0=[Rt*cosd(LatT0)*cosd(LonT0);...
                 Rt*cosd(LatT0)*sind(LonT0);...
                 Rt*sind(LatT0)];
%The global coordinates of the point P     
     Global_P=Global_T0+vec_T0P_glo;
end