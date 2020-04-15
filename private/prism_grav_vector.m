function [ res_grav_vector ] = prism_grav_vector( Xp,Yp,Zp,X1,X2,Y1,Y2,Z1,Z2,density,Gconstant)
%This Fuctions is to calculate the vector of the gravitational attraction
%component using the closed formula in Nagy et al.(2000).
%The calculation is performed in the edge system of the prism, where
%X->North Y->East Z->down.
%The program code uses 1,2 and 3 to indicate x,y and z
%direction, respectively.
%one prism(X1,X2,Y1,Y2,Z1,Z2) on one grid point(Xp,Yp,Zp),the unit is SI
%parametric variable Xp,Yp,Zp is the coordinates of a grid point
%parametric variable X1,X2,Y1,Y2,Z1,Z2 define the planes that bound the
%rectangular prism and its density is constant.
%Gconstant is the gravitational constant.
        xL(1)=X1-Xp;
        xL(2)=X2-Xp;
        yL(1)=Y1-Yp;
        yL(2)=Y2-Yp;
        zL(1)=Z1-Zp;
        zL(2)=Z2-Zp;
        resum_g1=0;
        resum_g2=0;
        resum_g3=0;
        for ki=2:-1:1
            for ji=2:-1:1
              for ii=2:-1:1
                  r = sqrt(xL(ii)^2+ yL(ji)^2 + zL(ki)^2);
                 kernel_g1 = -(yL(ji)*safe_log(zL(ki) + r) + zL(ki)*safe_log(yL(ji) + r)-xL(ii)*safe_atan(yL(ji)*zL(ki),xL(ii)*r));
                 kernel_g2 = -(zL(ki)*safe_log(xL(ii) + r) + xL(ii)*safe_log(zL(ki) + r)-yL(ji)*safe_atan(zL(ki)*xL(ii),yL(ji)*r));
                 kernel_g3 = -(xL(ii)*safe_log(yL(ji) + r) + yL(ji)*safe_log(xL(ii) + r)-zL(ki)*safe_atan(xL(ii)*yL(ji),zL(ki)*r));
                 resum_g1=resum_g1+power(-1, ii + ji + ki)*kernel_g1;
                 resum_g2=resum_g2+power(-1, ii + ji + ki)*kernel_g2;
                 resum_g3=resum_g3+power(-1, ii + ji + ki)*kernel_g3;
               end
            end
        end
        res_grav_vector= Gconstant*density*[resum_g1;...
                                            resum_g2;...
                                            resum_g3];
end

%subfunctions needed for above function
function [res] = safe_log(x)
%The function mkes log10() results in zero when the parameter is zero not NaN
    if x==0
      res=0;
    else
      res=log(x);
    end
end
function [res] = safe_atan(y,x)
%The function mkes log10() results in zero when the parameter is zero not NaN
    if x==0 
      res=0;
    else
      res=atan2(y,x);
    end
end