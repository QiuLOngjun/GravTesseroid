%This script is to visualise the approximation errors using the comnbined
%GLQ for the tesseroids of 1¡ãx1¡ãat the computation heigh hp=200 and 600km.
%The subplots 1 and 2 are approximation errors at 200 and 600 km,
%respectively.

clear all;
clc;
set(0,'defaultfigurecolor','w');%set background color of the figure white 
fontsize_tick=18;%set fontsize
fontsize_label=20;
fontsize_box=18;
fontsize_title=18;
%Load variables for plotting
load A07_near_far_zone_combined_method.mat
load A02_Difference_grav_GaussLegendre.mat
ObservH200km_CombinedGLQ_Psis_5=abstract(tess_1degx1deg_dr2km_ObservH200km_CombinedGLQ_Psis_5);
ObservH200km_CombinedGLQ_Psis_10=abstract(tess_1degx1deg_dr2km_ObservH200km_CombinedGLQ_Psis_10);
ObservH200km_CombinedGLQ_Psis_15=abstract(tess_1degx1deg_dr2km_ObservH200km_CombinedGLQ_Psis_15);
ObservH200km_CombinedGLQ_Psis_20=abstract(tess_1degx1deg_dr2km_ObservH200km_CombinedGLQ_Psis_20);
ObservH600km_CombinedGLQ_Psis_5=abstract(tess_1degx1deg_dr2km_ObservH600km_CombinedGLQ_Psis_5);
ObservH600km_CombinedGLQ_Psis_10=abstract(tess_1degx1deg_dr2km_ObservH600km_CombinedGLQ_Psis_10);
ObservH600km_CombinedGLQ_Psis_15=abstract(tess_1degx1deg_dr2km_ObservH600km_CombinedGLQ_Psis_15);
ObservH600km_CombinedGLQ_Psis_20=abstract(tess_1degx1deg_dr2km_ObservH600km_CombinedGLQ_Psis_20);
ObservH200km_Order2=abstract(tess_1degx1deg_dr2km_ObservH200km_Order2);
ObservH600km_Order2=abstract(tess_1degx1deg_dr2km_ObservH600km_Order2);
figure (7)
%subplot for tesseroid of 1degree x 1degree
ax211=subplot(211);
Splot1_1=semilogy(ObservH200km_CombinedGLQ_Psis_5(1:1:361,1),ObservH200km_CombinedGLQ_Psis_5(1:1:361,2),'-','Linewidth',1,'color','c'); 
hold on;
Splot1_2=semilogy(ObservH200km_CombinedGLQ_Psis_10(1:1:361,1),ObservH200km_CombinedGLQ_Psis_10(1:1:361,2),'-','Linewidth',1,'color','r'); 
hold on;
Splot1_3=semilogy(ObservH200km_CombinedGLQ_Psis_15(1:1:361,1),ObservH200km_CombinedGLQ_Psis_15(1:1:361,2),'-','Linewidth',1,'color','b'); 
hold on;
Splot1_4=semilogy(ObservH200km_CombinedGLQ_Psis_20(1:1:361,1),ObservH200km_CombinedGLQ_Psis_20(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;
Splot1_5=semilogy(ObservH200km_Order2(1:1:361,1),ObservH200km_Order2(1:1:361,2),'-','Linewidth',0.5,'color','g'); 
hold on;
set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax211,'position',[0.05 0.52 0.62 0.42]);
set(ax211,'xlim',[0 90]); %scales of x,  not xtick
set(ax211,'ylim',[10^-9 10^-1]);
set(ax211,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax211,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-9:2:-1);
grid on;
set(ax211,'YMinorTick','on');
set(ax211,'XMinorTick','on');
set(ax211,'Ytick',pytick);
set(ax211,'YMinorgrid','off');
%subplot legend parameters setting
h_1=legend([Splot1_1(1),Splot1_2(1),Splot1_3(1),Splot1_4(1),Splot1_5(1)],...
    '{\psi_{s}=5\circ}',...
    '{\psi_{s}=10\circ}',...
    '{\psi_{s}=15\circ}',...
    '{\psi_{s}=20\circ}',...
    '{Gauss-Legendre with Order 2}');
set(h_1,'Box','on');
set(h_1,'Fontsize',fontsize_box);
set(h_1,'location','EastOutside');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('the approximation error for the modeling of tesseroid of {1\circ}¡Á{1\circ} using the combined GLQ at 200 km','position',[60 0.15],'fontsize',20);
%subgraph name
text(-10.5,0.1,'a)','fontsize',fontsize_title);



%subplot(212) for tesseroid size 1degree
ax212=subplot(212);
Splot2_1=semilogy(ObservH600km_CombinedGLQ_Psis_5(1:1:361,1),ObservH600km_CombinedGLQ_Psis_5(1:1:361,2),'-','Linewidth',1,'color','c'); 
hold on;
Splot2_2=semilogy(ObservH600km_CombinedGLQ_Psis_10(1:1:361,1),ObservH600km_CombinedGLQ_Psis_10(1:1:361,2),'-','Linewidth',1,'color','r'); 
hold on;
Splot2_3=semilogy(ObservH600km_CombinedGLQ_Psis_15(1:1:361,1),ObservH600km_CombinedGLQ_Psis_15(1:1:361,2),'-','Linewidth',1,'color','b'); 
hold on;
Splot2_4=semilogy(ObservH600km_CombinedGLQ_Psis_20(1:1:361,1),ObservH600km_CombinedGLQ_Psis_20(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;
Splot2_5=semilogy(ObservH600km_Order2(1:1:361,1),ObservH600km_Order2(1:1:361,2),'-','Linewidth',0.5,'color','g'); 
hold on;

set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax212,'position',[0.05 0.07 0.62 0.35]);
set(ax212,'xlim',[0 90]); %scales of x,  not xtick
set(ax212,'ylim',[10^-9 10^-3]); 
set(ax212,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax212,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-9:2:-3);
grid on;
set(ax212,'YMinorTick','on');
set(ax212,'XMinorTick','on');
set(ax212,'Ytick',pytick);
set(ax212,'YMinorgrid','off');
%subplot legend parameters setting
h_2=legend([Splot2_1(1),Splot2_2(1),Splot2_3(1),Splot2_4(1),Splot2_5(1)],...
    '{\psi_{s}=5\circ}',...
    '{\psi_{s}=10\circ}',...
    '{\psi_{s}=15\circ}',...
    '{\psi_{s}=20\circ}',...
    '{Gauss-Legendre with Order 2}');
set(h_2,'Box','on');
set(h_2,'Fontsize',fontsize_box);
set(h_2,'location','EastOutside');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('the approximation error for the modeling of tesseroid of {1\circ}¡Á{1\circ} using the combined GLQ at 600 km','position',[60 0.001],'fontsize',20);
%subgraph name
text(-10.5,0.001,'b)','fontsize',fontsize_title);

%%
%the computation grid contains longitude(4)*latitude(361) points and covers
%the area from the 0 degree north to 90 degrees north.
%The functioin abstract() is used to find the maximum value of the errors
%which has the same longitude.
function [res_array]=abstract(array)
array=abs(array);
kk=1;
[n,m]=size(array);
res_array=zeros(n/4,2);
    for ii=1:4:n
        res_array(kk,1)=array(ii,2);
        res_array(kk,2)=max([array(ii,3),array(ii+1,3),array(ii+2,3),array(ii+3,3)]);
        kk=kk+1;
    end
end
