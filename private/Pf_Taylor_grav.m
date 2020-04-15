function grav_atApoint=Pf_Taylor_grav(griddata,grind,tessmod,MEAN_EARTH_RADIUS_local,G_local,SI2mGal_local)
% the function is to compute the gravational contribution of tesseorids at
% one observation point using Taylor series expansion;
% the parameters griddata and tessmod are the matrix of the computation grid
% and model,respectively;
% MEAN_EARTH_RADIUS is the mean radius of the earth                                                                                                                                       
[tessnumber,nc]=size(tessmod);            
grav=zeros(tessnumber,1);
    for tessind=1:1:tessnumber
         grav(tessind)=SI2mGal_local*Taylor_tess_g3(griddata(grind,1),griddata(grind,2),griddata(grind,3),...
                        tessmod(tessind,1),tessmod(tessind,2),tessmod(tessind,3),tessmod(tessind,4),...
                        tessmod(tessind,5),tessmod(tessind,6),tessmod(tessind,7),...
                        G_local,MEAN_EARTH_RADIUS_local);
    end
    grav_atApoint=sum(grav);
end