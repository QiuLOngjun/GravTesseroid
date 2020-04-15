function [grav_atP]=Pf_Prism_grav(griddata,grind,prismmod,MEAN_EARTH_RADIUS_local,G_local,SI2MGAL_local)
[prismnum,nc]=size(prismmod); 
grav_loc_atP=zeros(3,prismnum);
    for prismin=1:1:prismnum
        %convert the global coordinates of the positioin vector T0P in to
        %the edge system; the coordinates of P in edge system (ENU)
        vec_T0P_loc=from_global_to_local_forCompPoint(griddata(grind,1),griddata(grind,2),griddata(grind,3)+MEAN_EARTH_RADIUS_local,...
                         prismmod(prismin,1), prismmod(prismin,2), prismmod(prismin,3));
        %Using the local coordinates of the computation point and the prism
        %geometry information to compute the gravitational attraction at
        %P(mGal)Nagy et al.(2000), which requires the z axis point down.
        grav_vector=SI2MGAL_local*prism_grav_vector( vec_T0P_loc(1),vec_T0P_loc(2),-vec_T0P_loc(3),...
             -0.5*prismmod(prismin,4),0.5*prismmod(prismin,4),-0.5*prismmod(prismin,5),0.5*prismmod(prismin,5),...
             0,prismmod(prismin,6),prismmod(prismin,7),G_local);   
       %Converting the NED into NEU
       grav_vector(3)=-grav_vector(3);
       %Converting the resultant grav_vector in to the local coordinate system 
       %with respect to the computation point P, i.e., from NEU to NEU system
       grav_loc_atP(:,prismin)=from_local_to_local_forGravityfield( griddata(grind,1),griddata(grind,2),...
                  prismmod(prismin,1),prismmod(prismin,2),grav_vector);
       grav_loc_atP(3,prismin)=-grav_loc_atP(3,prismin); 
    end
grav_vector=sum(grav_loc_atP,2);
grav_atP=grav_vector(3);
end
