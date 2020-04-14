function GLQ_grav_atApoint=Pf_GLQ_grav(griddata,grind,tessmod,Norder,MEAN_EARTH_RADIUS_local,G_local,...
                                        GL_roots,GL_weights,SI2mGal_local)
% the function is to compute the gravational contribution of tesseorids at
% one observation point.
% the parameters griddata and tessmod are the matrix of the computation grid
% and model,respectively;
% the parameter Norder is the order of the Gauss-Legendre quadrature integration
% the parameter GL_roots,GL_weights are matrixes that store the roots and their corresponding weights of the N-th order
% Gauss-Legendre quadrature                                                                                                                                            
[tessnumber,nc]=size(tessmod);            
GLQ_grav=zeros(tessnumber,1);
    for tessind=1:1:tessnumber
         GLQ_grav(tessind)=SI2mGal_local*GLQ_tess_g3(griddata(grind,1),griddata(grind,2),...
                 griddata(grind,3),tessmod(tessind,1),tessmod(tessind,2),tessmod(tessind,3),tessmod(tessind,4),...
                 tessmod(tessind,5),tessmod(tessind,6),tessmod(tessind,7),...
                 Norder,GL_roots,GL_weights,G_local,MEAN_EARTH_RADIUS_local);
    end
    GLQ_grav_atApoint=sum(GLQ_grav);
end