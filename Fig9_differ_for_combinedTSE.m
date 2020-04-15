%This script is to visualise the ralationship between the maximum difference 
%(between the tesseroid field and shell field) computed by the combinend Taylor series method
%and the parameter Psi that defines the boundary between the near and far zone.
clear all;
clc;
set(0,'defaultfigurecolor','w');%set background color of the figure white 
fontsize_tick=15;%set fontsize
fontsize_label=15;
fontsize_box=15;
fontsize_title=12;
%Load variables for plotting
%The load variables store the differences between the reference value and
%the numerical results obtained by Taylor series expansion and the combined
%method.
load A07_near_far_zone_combined_method.mat
load A03_Difference_grav_Taylorseries.mat 
%using the function abstract() to obtaine the maximum one of the difference
%with the same latitude.
ObservH200km_CombinedTaylor_Psis_5=abstract(tess_5minx5min_dr2km_ObservH200km_CombinedTaylor_Psis_5);
ObservH200km_CombinedTaylor_Psis_10=abstract(tess_5minx5min_dr2km_ObservH200km_CombinedTaylor_Psis_10);
ObservH200km_CombinedTaylor_Psis_15=abstract(tess_5minx5min_dr2km_ObservH200km_CombinedTaylor_Psis_15);
ObservH200km_CombinedTaylor_Psis_20=abstract(tess_5minx5min_dr2km_ObservH200km_CombinedTaylor_Psis_20);
ObservH200km_CombinedTaylor_Psis_40=abstract(tess_5minx5min_dr2km_ObservH200km_CombinedTaylor_Psis_40);
ObservH600km_CombinedTaylor_Psis_5=abstract(tess_5minx5min_dr2km_ObservH600km_CombinedTaylor_Psis_5);
ObservH600km_CombinedTaylor_Psis_10=abstract(tess_5minx5min_dr2km_ObservH600km_CombinedTaylor_Psis_10);
ObservH600km_CombinedTaylor_Psis_15=abstract(tess_5minx5min_dr2km_ObservH600km_CombinedTaylor_Psis_15);
ObservH600km_CombinedTaylor_Psis_20=abstract(tess_5minx5min_dr2km_ObservH600km_CombinedTaylor_Psis_20);
ObservH600km_CombinedTaylor_Psis_40=abstract(tess_5minx5min_dr2km_ObservH600km_CombinedTaylor_Psis_40);
ObservH200km_Taylor=abstract(tess_5minx5min_dr2km_ObservH200km_Taylor);
ObservH600km_Taylor=abstract(tess_5minx5min_dr2km_ObservH600km_Taylor);
figure(9)
%subplot211
ax211=subplot(211);
Splot1_1=semilogy(ObservH200km_CombinedTaylor_Psis_5(1:1:361,1),ObservH200km_CombinedTaylor_Psis_5(1:1:361,2),'-','Linewidth',1,'color','c'); 
hold on;
Splot1_2=semilogy(ObservH200km_CombinedTaylor_Psis_10(1:1:361,1),ObservH200km_CombinedTaylor_Psis_10(1:1:361,2),'-','Linewidth',1,'color','r'); 
hold on;
Splot1_3=semilogy(ObservH200km_CombinedTaylor_Psis_15(1:1:361,1),ObservH200km_CombinedTaylor_Psis_15(1:1:361,2),'-','Linewidth',1,'color','b'); 
hold on;
Splot1_4=semilogy(ObservH200km_CombinedTaylor_Psis_20(1:1:361,1),ObservH200km_CombinedTaylor_Psis_20(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;
Splot1_5=semilogy(ObservH200km_CombinedTaylor_Psis_40(1:1:361,1),ObservH200km_CombinedTaylor_Psis_40(1:1:361,2),'-','Linewidth',1,'color','m'); 
hold on;
Splot1_6=semilogy(ObservH200km_Taylor(1:1:361,1),ObservH200km_Taylor(1:1:361,2),'-','Linewidth',0.5,'color','g'); 
hold on;
set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax211,'position',[0.05 0.55 0.62 0.38]);
set(ax211,'xlim',[0 90]); %scales of x,  not xtick
set(ax211,'ylim',[10^-12 10^-2]);
set(ax211,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax211,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-12:2:-2);
grid on;
set(ax211,'YMinorTick','on');
set(ax211,'XMinorTick','on');
set(ax211,'Ytick',pytick);
set(ax211,'YMinorgrid','off');
%subplot legend parameters setting
h_1=legend([Splot1_1(1),Splot1_2(1),Splot1_3(1),Splot1_4(1),Splot1_5(1),Splot1_6(1)],...
    '{\psi_{s}=5\circ}',...
    '{\psi_{s}=10\circ}',...
    '{\psi_{s}=15\circ}',...
    '{\psi_{s}=20\circ}',...
    '{\psi_{s}=40\circ}',...
    '{Taylor series expansion}');
set(h_1,'Box','on');
set(h_1,'Fontsize',fontsize_box);
set(h_1,'location','EastOutside');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('the approximation error for the modeling of tesseroid of {5''}¡Á{5''} using the combined Taylor seires expanion at 200 km','position',[62 0.01],'fontsize',20);
%%
%subplot212
ax212=subplot(212);
Splot2_1=semilogy(ObservH600km_CombinedTaylor_Psis_5(1:1:361,1),ObservH600km_CombinedTaylor_Psis_5(1:1:361,2),'-','Linewidth',1,'color','c'); 
hold on;
Splot2_2=semilogy(ObservH600km_CombinedTaylor_Psis_10(1:1:361,1),ObservH600km_CombinedTaylor_Psis_10(1:1:361,2),'-','Linewidth',1,'color','r'); 
hold on;
Splot2_3=semilogy(ObservH600km_CombinedTaylor_Psis_15(1:1:361,1),ObservH600km_CombinedTaylor_Psis_15(1:1:361,2),'-','Linewidth',1,'color','b'); 
hold on;
Splot2_4=semilogy(ObservH600km_CombinedTaylor_Psis_20(1:1:361,1),ObservH600km_CombinedTaylor_Psis_20(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;
Splot2_5=semilogy(ObservH600km_CombinedTaylor_Psis_40(1:1:361,1),ObservH600km_CombinedTaylor_Psis_40(1:1:361,2),'-','Linewidth',1,'color','m'); 
hold on;
Splot2_6=semilogy(ObservH600km_Taylor(1:1:361,1),ObservH600km_Taylor(1:1:361,2),'-','Linewidth',0.5,'color','g'); 
hold on;
set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax212,'position',[0.05 0.08 0.62 0.38]);
set(ax212,'xlim',[0 90]); %scales of x,  not xtick
set(ax212,'ylim',[10^-12 10^-2]);
set(ax212,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax212,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-12:2:-2);
grid on;
set(ax212,'YMinorTick','on');
set(ax212,'XMinorTick','on');
set(ax212,'Ytick',pytick);
set(ax212,'YMinorgrid','off');
%subplot legend parameters setting
h_2=legend([Splot2_1(1),Splot2_2(1),Splot2_3(1),Splot2_4(1),Splot2_5(1),Splot2_6(1)],...
    '{\psi_{s}=5\circ}',...
    '{\psi_{s}=10\circ}',...
    '{\psi_{s}=15\circ}',...
    '{\psi_{s}=20\circ}',...
    '{\psi_{s}=40\circ}',...
    '{Taylor series expansion}');
set(h_2,'Box','on');
set(h_2,'Fontsize',fontsize_box);
set(h_2,'location','EastOutside');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('the approximation error for the modeling of tesseroid of {5''}¡Á{5''} using the combined Taylor seires expanion at 600 km','position',[62 0.01],'fontsize',20);

%% 
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