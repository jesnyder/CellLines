close all; clc; clearvars; R=10; %R is the font size
% CDC data https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Data in gogle sheet: https://docs.google.com/spreadsheets/d/1W5fmXt9xLTvnjzmnuTThRp8C8zUKMzrAbTUxTvw3aFg/edit#gid=0
CDC = csvread('CDC.csv', 1, 4);
PuCo = csvread('PuCo.csv', 1, 0);
PaCo = csvread('PaCo.csv', 1, 0);
CL2 = csvread('CellLine2.csv', 1, 0);

c = [0   0  0; 1 1 1; 1 1 1; ...
     0   0  1; .9 0 0; .8 0 0; ...
     1  0  0; 0 .9 0 ; 0 .8 0; ...
     0 .8 .4; 0 0 .9; 0 0 .8; ...
    .4  0 .8; .9 .9 0; .8 .8 0; ...
    .9 .6  0; .9 .6 0; .8 .8 .8; ...
    .8 .8 .8; .9 .9 .9; .8 .8 .8;...
    .5  1 .5; 0 .9 .5; 0 .8 .5; ...
     1  1 1; 1 1 1; 1 1 1];
 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==1,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); IRB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==2,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); DRB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==3,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); ICB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==4,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); DCB = B;   
DB = [ICB(:,1)]; i=6; while(i<=11); B =(ICB(:,i))./(ICB(:,5))-(DCB(:,i))./(DCB(:,5)); DB = [DB,B]; i=i+1;  end; 

% Breast Cancer Death Count in 2013 for Pie Chart - Comparison to Avialable
% Cell Lines, Publication and Patent Pie Charts
B=CDC(CDC(:,2)==3,:); 
B=B(B(:,3)==4,:); 
B=B(B(:,4)==4,:); 
B=B(B(:,1)>2012,:); 
DCB2013 = B(5:end);  

close all; f1 = figure; s1=1; s2=4; si=1; 
L = [{'All','White','Black','Asian','American Indian','Hispanic'}];

while(si<3);
subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
if(si==1) B=IRB; ylabel({'Incidence Rate per 100k Persons'}); ylim([20 200]); title({'CDC Female Breast Cancer', 'Incidence Rate'}); end;
if(si==2) B=DRB; ylabel({'Death Rate per 100k Persons'}); ylim([0 100]); title({'CDC Female Breast Cancer', 'Death Rate'}); end;
i=5; while(i<=length(B(1,:))) err=0.5*(B(:,i+2)-B(:,i+1)); e=errorbar(B(:,1),B(:,i),err,'o'); e.LineWidth=1.0; e.Color=c(i-4,:); i=i+3; end;
i=5; while(i<=length(B(1,:))) l=plot(B(:,1),B(:,i)); l.LineWidth=0.15; l.Color=c(i-4,:); i=i+3; end;
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
legend(L,'Location','SouthEast','Orientation','Vertical'); 
si=si+1; end;

s1=1; s2=2; si=2; subplot(s1, s2, si);
b=bar(DB(:,1),DB(:,2:end)); 
    i=1; while(i+1<length(DB(1,:))); b(:,i).FaceColor = c(i+i*3-i+1,:); b(:,i).EdgeColor = [0 0 0]; i=i+1; end; 
legend(L(2:end),'Location','SouthEast','Orientation','Vertical'); 
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Count Fraction  - Death Count Fraction'}); ylim([-.05 .035]); set(gca,'YTick',[-.05:.01:.05]); 
title({'Treatment Efficacy','(+) Incidence > Death = Effective VS (-) Incidence < Death = Ineffective'}); 
hold off; 

AR =.35; %9/16 is youtube aspect ratio
sz = 1200; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationale.jpg'];
print(f1, newname, '-djpeg', '-r600') 

%Cell Line Figure, sums 
B=CL(CL(:,1)==2,:); CA=[]; i=1; while(i<=6); B1=B(B(:,4)==i,:); CA(i)=length(B1); i=i+1; end; n1=sum(CA); 
CA = [CA(4) CA(2) CA(1) CA(6) CA(3) CA(5)];

B=PuCo(PuCo(:,3)==2,:); PuC=[]; i=1; while(i<=6); B1=B(B(:,2)==i,:); PuC(i)=sum(B1(:,5)); i=i+1; end; n2=sum(PuC); 
PuC = [PuC(4) PuC(2) PuC(1) PuC(6) PuC(3) PuC(5)];

B=PaCo(PaCo(:,3)==2,:); PaC=[]; i=1; while(i<=6); B1=B(B(:,2)==i,:); PaC(i)=sum(B1(:,5)); i=i+1; end; n3=sum(PaC); 
PaC = [PaC(4) PaC(2) PaC(1) PaC(6) PaC(3) PaC(5)];

close all; f1 = figure; s1=1; s2=4; si=0; 
L = [{'All','White','Black','Asian','American Indian','Hispanic','Unknown'}];

si=si+1; subplot(s1, s2, si); pie(DCB2013(2:end),L(2:end-1)); title({'2013 Breast Cancer', 'Death Count Demographics'}); 
si=si+1; subplot(s1, s2, si); p = pie(CA,L(2:end)); title({num2str(n1),'Available Breast Cancer Cell Lines' });
colormap([c(4,:);c(7,:);c(10,:);c(13,:);c(16,:);c(19,:)]);
si=si+1; subplot(s1, s2, si); p = pie(PuC,L(2:end)); title({ num2str(n2) ,'Publications citing Breast Cancer Cell Lines'});
colormap([c(4,:);c(7,:);c(10,:);c(13,:);c(16,:);c(19,:)])
si=si+1; subplot(s1, s2, si); p = pie(PaC,L(2:end)); title({ num2str(n3) , 'Patents citing Breast Cancer Cell Lines'});
colormap([c(4,:);c(7,:);c(10,:);c(13,:);c(16,:);c(19,:)])

AR =.35; %9/16 is youtube aspect ratio
sz = 1200; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'CellLines.jpg'];
print(f1, newname, '-djpeg', '-r600') 

close all; f1 = figure; s1=1; s2=4; si=0; 
L = [{'All','White','Black','Asian','American Indian','Hispanic','Unknown'}];

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
B=DCB; 
i=1; while(i<=6) e=plot(B(:,1),B(:,i+4)); set(gca,'yscale','log'); e.LineWidth=1.0; e.Color=c(i*3-2,:); i=i+1; end;
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
legend(L,'Location','SouthEast','Orientation','Vertical'); 
ylabel({'Breast Cancer Death Counts','Source: US CDC'}); set(gca,'yscale','log');
title({'Breast Cancer Death Count Trajectory'});
%i=1; while(i<=6); e=scatter(B(:,1),B(:,i+4)); set(gca,'yscale','log'); e.MarkerEdgeColor=c(i*3-2,:); i=i+1; end;
hold off;

%Count the number of cell lines for each ethnicity for breast cancer 
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
CL3=zeros(7,7); B=CL2; B=B(B(:,1)==2,:); B=B(B(:,5)>0,:); 
j=min(B(:,5)); while(j<=2015)  B=CL2; B=B(B(:,1)==2,:); B=B(B(:,5)>0,:); B=B(B(:,5)<=j,:);
i=1; while(i<=6) B1=B(B(:,3)==i,:); CL3(j,i+1)=length(B1(:,1)); i=i+1; end; CL3(j,1)=j; j=j+1; end; CL3=CL3(CL3(:,2)>0,:);
%Plot the available cell lines
i=1; while(i<=6) e=plot(CL3(:,1),CL3(:,i+1)); e.LineWidth=1.0; e.Color=c(i*3-2+3,:); i=i+1; end;
xlabel({'Year'}); xlim([1955 2019]); set(gca,'XTick',[1950:10:2020]); 
ylabel({'Number of Available Cell Lines'}); ylim([.8 60]); set(gca,'YTick',[0 1 2 3 4 5 10 15 20 30 40 50 60 70 80 90 100]); set(gca,'yscale','log'); 
legend(L(2:end),'Location','NorthWest','Orientation','Vertical'); 
title({'Representation in Cell Lines'});
%i=1; while(i<=6); e=scatter(CL3(:,1),CL3(:,i+1)); set(gca,'yscale','log'); e.MarkerEdgeColor=c(i*3-2+3,:); i=i+1; end;
hold off;

%Count the number publications citing breast cancer cell lines
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
PuCo2=zeros(7,7); j=1950; while(j<=2015)  B=PuCo; B=B(B(:,3)==2,:); B=B(B(:,4)<=j,:);
i=1; while(i<=6) B1=B(B(:,2)==i,:); PuCo2(j,i+1)=sum(B1(:,5)); i=i+1; end; PuCo2(j,1)=j; j=j+1; end; PuCo2=PuCo2(PuCo2(:,5)>0,:)
PuCo2 = [PuCo2(:,1) PuCo2(:,5) PuCo2(:,3) PuCo2(:,2) PuCo2(:,7) PuCo2(:,4) PuCo2(:,6)];
%Plot the available cell lines
i=1; while(i<=6) e=plot(PuCo2(:,1),PuCo2(:,i+1)); e.LineWidth=1.0; e.Color=c(i*3-2+3,:); i=i+1; end;
xlabel({'Year'}); xlim([1970 2019]); set(gca,'XTick',[1950:10:2020]); 
legend(L(2:end),'Location','NorthWest','Orientation','Vertical'); 
title({'Representation in Publications'});
ylabel({'Citations of Breast Cancer Cell Lines','in Publication Database'}); set(gca,'yscale','log');
%i=1; while(i<=6); e=scatter(PuCo2(:,1),PuCo2(:,i+1)); set(gca,'yscale','log'); e.MarkerEdgeColor=c(i*3-2+3,:); i=i+1; end;
hold off;

%Count the number US patents citing breast cancer cell lines
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
PaCo2=zeros(7,7); j=1950; while(j<=2015)  B=PaCo; B=B(B(:,3)==2,:); B=B(B(:,4)<=j,:);
i=1; while(i<=6) B1=B(B(:,2)==i,:); PaCo2(j,i+1)=sum(B1(:,5)); i=i+1; end; PaCo2(j,1)=j; j=j+1; end; PaCo2=PaCo2(PaCo2(:,5)>0,:)
PaCo2 = [PaCo2(:,1) PaCo2(:,5) PaCo2(:,3) PaCo2(:,2) PaCo2(:,7) PaCo2(:,4) PaCo2(:,6)];
%Plot the available cell lines
i=1; while(i<=6) e=plot(PaCo2(:,1),PaCo2(:,i+1)); e.LineWidth=1.0; e.Color=c(i*3-2+3,:); i=i+1; end;
xlabel({'Year'}); xlim([1998 2019]); set(gca,'XTick',[1950:5:2020]); 
legend(L(2:end),'Location','NorthWest','Orientation','Vertical'); 
title({'Representation in US Patents'});
ylabel({'Citations of Breast Cancer Cell Lines','in US Patent Database'}); set(gca,'yscale','log');
%i=1; while(i<=6); e=scatter(PaCo2(:,1),PaCo2(:,i+1)); set(gca,'yscale','log'); e.MarkerEdgeColor=c(i*3-2+3,:); i=i+1; end;
hold off;

AR =.25; %9/16 is youtube aspect ratio
sz = 1200; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Trajectory.jpg'];
print(f1, newname, '-djpeg', '-r600') 

close all; f1 = figure; s1=1; s2=2; si=0; 
%Normalized fractions for death count by demographics
DCBn = transpose(DCB); DCBn=DCBn(DCBn(:,1)>0,:); DCBn=transpose(DCBn); DCBn=[DCBn(:,1) DCBn(:,6:end)]; 
DCBn(:,end+1)= transpose(sum(transpose(DCBn(:,2:end)))); 
i=2; while(i<=length(DCBn(1,:))) DCBn(:,i)=DCBn(:,i)./DCBn(:,end); i=i+1; end;
DCBn=DCBn(DCBn(:,1)>=2001,:); DCBn=DCBn(DCBn(:,1)<=2013,:); 
%Normalized fractions for publication by demographics
PuCo2n = PuCo2(:,1:end-1); PuCo2n(:,end+1)= transpose(sum(transpose(PuCo2n(:,2:end)))); 
i=2; while(i<=length(PuCo2n(1,:))) PuCo2n(:,i)=PuCo2n(:,i)./PuCo2n(:,end); i=i+1; end;
PuCo2n=PuCo2n(PuCo2n(:,1)>=2001,:); PuCo2n=PuCo2n(PuCo2n(:,1)<=2013,:); 
%Normalized fractions for US patents by demographics
PaCo2n = PaCo2(:,1:end-1); PaCo2n(:,end+1)= transpose(sum(transpose(PaCo2n(:,2:end)))); 
i=2; while(i<=length(PaCo2n(1,:))) PaCo2n(:,i)=PaCo2n(:,i)./PaCo2n(:,end); i=i+1; end;
PaCo2n=PaCo2n(PaCo2n(:,1)>=2001,:); PaCo2n=PaCo2n(PaCo2n(:,1)<=2013,:); 

%Subtraction of death count fraction - publication fraction
B = -DCBn + PuCo2n; B(:,1) = DCBn(:,1); B = B(:,1:end-1); 
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
% Bar graph of bias in patents
b=bar(B(:,1),B(:,2:end)); i=1; while(i+1<length(B(1,:))); b(:,i).FaceColor = c(i+i*3-i+1,:); b(:,i).EdgeColor = c(i+i*3-i+1,:); i=i+1; end; 
%Plot the difference between death count and publication
i=1; while(i<=5) e=plot(B(:,1),B(:,i+1)); e.LineWidth=1.0; e.Color=c(i*3-2+3,:); i=i+1; end;
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
legend(L(2:end-1),'Location','NorthWest','Orientation','Vertical'); 
title({'Publication Bias'});
ylabel({'Representative Bias','in Publication Database'}); 
hold off;

%Subtraction of death count fraction - patent fraction
B = -DCBn + PaCo2n; B(:,1) = DCBn(:,1); B = B(:,1:end-1); 
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
% Bar graph of bias in patents
b=bar(B(:,1),B(:,2:end)); i=1; while(i+1<length(B(1,:))); b(:,i).FaceColor = c(i+i*3-i+1,:); b(:,i).EdgeColor = c(i+i*3-i+1,:); i=i+1; end; 
%Plot the difference between death count and patents
i=1; while(i<=5) e=plot(B(:,1),B(:,i+1)); e.LineWidth=1.0; e.Color=c(i*3-2+3,:); i=i+1; end;
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
legend(L(2:end-1),'Location','NorthWest','Orientation','Vertical'); 
title({'US Patent Bias'});
ylabel({'Representative Bias','in US Patent Database'}); 
hold off;

AR =.4; %9/16 is youtube aspect ratio
sz = 800; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Bias.jpg'];
print(f1, newname, '-djpeg', '-r600') 



