%This script is to visualise the ralationship between the maximum difference 
%(between the tesseroid field and shell field)and the latitude of the
%computation nodes for the tesseroids of 1 degree * 1 degree at 200,400 and
%600 km, respectively.
%the subplots are seperated by the different computation heights.
%the tesseroid fields are obtained by the Gauss-Legendre quadrature,Taylor
%series expansion and the prism approximation approach.

clear all;
clc;
set(0,'defaultfigurecolor','w');%set background color of the figure white 
fontsize_tick=16;%set fontsize
fontsize_label=18;
fontsize_box=16;
fontsize_title=16;
%Load variables for plotting
load A02_Difference_grav_GaussLegendre.mat
load A03_Difference_grav_Taylorseries.mat
load A04_Difference_grav_PrismApproa.mat

ObservH200km_Order2=abstract(tess_1degx1deg_dr2km_ObservH200km_Order2);
ObservH200km_Order5=abstract(tess_1degx1deg_dr2km_ObservH200km_Order5);
ObservH400km_Order2=abstract(tess_1degx1deg_dr2km_ObservH400km_Order2);
ObservH400km_Order5=abstract(tess_1degx1deg_dr2km_ObservH400km_Order5);
ObservH600km_Order2=abstract(tess_1degx1deg_dr2km_ObservH600km_Order2);
ObservH600km_Order5=abstract(tess_1degx1deg_dr2km_ObservH600km_Order5);
ObservH600km_Taylor=abstract(tess_1degx1deg_dr2km_ObservH600km_Taylor);
ObservH400km_Taylor=abstract(tess_1degx1deg_dr2km_ObservH400km_Taylor);
ObservH200km_Taylor=abstract(tess_1degx1deg_dr2km_ObservH200km_Taylor);
ObservH600km_Prism=abstract(tess_1degx1deg_dr2km_ObservH600km_PrismApproa);
ObservH400km_Prism=abstract(tess_1degx1deg_dr2km_ObservH400km_PrismApproa);
ObservH200km_Prism=abstract(tess_1degx1deg_dr2km_ObservH200km_PrismApproa);

figure (3)
%subplot(221) for tesseroid of 1degree x 1degree
ax221=subplot(221);
Splot1_1=semilogy(ObservH200km_Order2(1:1:361,1),ObservH200km_Order2(1:1:361,2),'-','MarkerSize',4,'color','g'); 
hold on;
Splot1_2=semilogy(ObservH200km_Order5(1:1:361,1),ObservH200km_Order5(1:1:361,2),'-','MarkerSize',5,'color','r'); 
hold on;
Splot1_3=semilogy(ObservH200km_Taylor(1:1:361,1),ObservH200km_Taylor(1:1:361,2),'-','Linewidth',0.5,'color','b'); 
hold on;
Splot1_4=semilogy(ObservH200km_Prism(1:1:361,1),ObservH200km_Prism(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;

set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax221,'position',[0.05 0.555 0.62 0.40]);
set(ax221,'xlim',[0 90]); %scales of x,  not xtick
set(ax221,'ylim',[10^-9 10^1]); 
set(ax221,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax221,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-9:2:1);
grid on;
set(ax221,'YMinorTick','on');
set(ax221,'XMinorTick','on');
set(ax221,'Ytick',pytick);
set(ax221,'YMinorgrid','off');
%subplot221,legend parameters setting
h_1=legend([Splot1_1(1),Splot1_2(1),Splot1_3(1),Splot1_4(1)],...
    '{Gauss-Legendre with Order 2}',...
    '{Gauss-Legendre with Order 5}',...
    '{Taylor series expansion}',...
    '{prism approximation approach}');%'{\Delta\phi=\Delta\lambda=15\circ}'
set(h_1,'Box','on');
set(h_1,'Fontsize',fontsize_box);
set(h_1,'LineWidth',1);
set(h_1,'location','EastOutside');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('The maximum difference of a_{3} at 200 km ','position',[40 10],'fontsize',20);
%subgraph name
text(-10.5,10,'a)','fontsize',fontsize_title);


%subplot(223) for tesseroid size 1degree
ax223=subplot(223);
Splot3_1=semilogy(ObservH400km_Order2(1:1:361,1),ObservH400km_Order2(1:1:361,2),'-','MarkerSize',4,'color','g'); 
hold on;
Splot3_2=semilogy(ObservH400km_Order5(1:1:361,1),ObservH400km_Order5(1:1:361,2),'-','MarkerSize',5,'color','r'); 
hold on;
Splot3_3=semilogy(ObservH400km_Taylor(1:1:361,1),ObservH400km_Taylor(1:1:361,2),'-','Linewidth',0.5,'color','b'); 
hold on;
Splot3_4=semilogy(ObservH400km_Prism(1:1:361,1),ObservH400km_Prism(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;

set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax223,'position',[0.05 0.06 0.42 0.39]);
set(ax223,'xlim',[0 90]); %scales of x,  not xtick
set(ax223,'ylim',[10^-12 10^1]); 
set(ax223,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax223,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-12:2:1);
grid on;
set(ax223,'YMinorTick','on');
set(ax223,'XMinorTick','on');
set(ax223,'Ytick',pytick);
set(ax223,'YMinorgrid','off');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('The maximum difference of a_{3} at 400 km ','position',[40 10],'fontsize',20);
%subgraph name
text(-10.5,10,'b)','fontsize',fontsize_title);

%subplot(224) for tesseroid size 1degree
ax224=subplot(224);
Splot4_1=semilogy(ObservH600km_Order2(1:1:361,1),ObservH600km_Order2(1:1:361,2),'-','MarkerSize',4,'color','g'); 
hold on;
Splot4_2=semilogy(ObservH600km_Order5(1:1:361,1),ObservH600km_Order5(1:1:361,2),'-','MarkerSize',5,'color','r'); 
hold on;
Splot4_3=semilogy(ObservH600km_Taylor(1:1:361,1),ObservH600km_Taylor(1:1:361,2),'-','Linewidth',0.5,'color','b'); 
hold on;
Splot4_4=semilogy(ObservH600km_Prism(1:1:361,1),ObservH600km_Prism(1:1:361,2),'-','Linewidth',1,'color','k'); 
hold on;

set(gca,'box','on');
set(gca,'Fontsize',fontsize_tick);
%font setting
set(gca,'fontname','Times');
set(ax224,'position',[0.55 0.06 0.42 0.39]);
set(ax224,'xlim',[0 90]); %scales of x,  not xtick
set(ax224,'ylim',[10^-12 10^1]); 
set(ax224,'xtick',[0,10,20,30,40,50,60,70,80,90]);
set(ax224,'xticklabel',[0,10,20,30,40,50,60,70,80,90]);
pytick=10.^(-12:2:1);
grid on;
set(ax224,'YMinorTick','on');
set(ax224,'XMinorTick','on');
set(ax224,'Ytick',pytick);
set(ax224,'YMinorgrid','off');
ylabel({'Approximation error (mGal)'},'FontSize',fontsize_label);
xlabel({'The latitude of the observation point({\circ})'},'FontSize',fontsize_label);
title('The maximum difference of a_{3} at 600 km ','position',[40 10],'fontsize',20);
%subgraph name
text(-10.5,10,'c)','fontsize',fontsize_title);



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
