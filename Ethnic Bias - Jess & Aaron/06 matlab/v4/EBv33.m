close all; clc; clearvars; R=10; %R is the font size
% CDC data https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Data in gogle sheet: https://docs.google.com/spreadsheets/d/1W5fmXt9xLTvnjzmnuTThRp8C8zUKMzrAbTUxTvw3aFg/edit#gid=0
CDC = csvread('CDC.csv', 1, 3);
PuCo = csvread('PuCo.csv', 1, 0);
PaCo = csvread('PaCo.csv', 1, 0);
CL = csvread('CellLine.csv', 1, 0);

d = 3; CDC=CDC(CDC(:,2)==d,:); CDC=CDC(CDC(:,4)==4,:); %Disease index; 1=General, 2=Male and Female Breast, 3=Female Breast)

B=CDC(CDC(:,3)==1,:); B=B(B(:,1)>=1999,:); IRB = B; % Incidence Rate 
B=CDC(CDC(:,3)==2,:); B=B(B(:,1)>=1999,:); DRB = B; % Death Rate 
B=CDC(CDC(:,3)==3,:); B=B(B(:,1)>=1999,:); ICB = B; % Incidence Count
B=CDC(CDC(:,3)==4,:); B=B(B(:,1)>=1999,:); DCB = B; % Death Count 
DB = [ICB(:,1)]; i=6; while(i<=11); B =(ICB(:,i))./(ICB(:,5))-(DCB(:,i))./(DCB(:,5)); DB = [DB,B]; i=i+1;  end; % Treatment Efficacy Bias

% Breast Cancer Death Count in 2013 for Pie Chart - Comparison to Avialable
% Cell Lines, Publication and Patent Pie Charts
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==4,:); B=B(B(:,4)==4,:); B=B(B(:,1)>2012,:); DCB2013 = B(5:10);  

%Cell Line Figure, sums 
B=CL(CL(:,1)==2,:); CA=[]; i=1; while(i<=6); B1=B(B(:,4)==i,:); CA(i)=length(B1); i=i+1; end; n1=sum(CA); 
CA = [CA(4) CA(2) CA(1) CA(6) CA(3) CA(5)];
B=PuCo(PuCo(:,3)==2,:); PuC=[]; i=1; while(i<=6); B1=B(B(:,2)==i,:); PuC(i)=sum(B1(:,5)); i=i+1; end; n2=sum(PuC); 
PuC = [PuC(4) PuC(2) PuC(1) PuC(6) PuC(3) PuC(5)];
B=PaCo(PaCo(:,3)==2,:); PaC=[]; i=1; while(i<=6); B1=B(B(:,2)==i,:); PaC(i)=sum(B1(:,5)); i=i+1; end; n3=sum(PaC); 
PaC = [PaC(4) PaC(2) PaC(1) PaC(6) PaC(3) PaC(5)];

%Figure to demonstrate rationale
close all; f1 = figure; s1=1; s2=4; si=1; 
L = [{'All','White','Black','Asian','American Indian','Hispanic','Unspecified'}];
c = [0   0  0; 1 1 1; 1 1 1; 0   0  1; .9 0 0; .8 0 0; 1  0  0; 0 .9 0 ; 0 .8 0; 0 .8 .4; 0 0 .9; 0 0 .8; .4  0 .8; .9 .9 0; .8 .8 0; .9 .6  0; .9 .6 0; .8 .8 .8; .8 .8 .8; .9 .9 .9; .8 .8 .8; .5  1 .5; 0 .9 .5; 0 .8 .5; 1  1 1; 1 1 1; 1 1 1];
%Incidence and Death Rate Error Bar Graphs
while(si<3);
subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
if(si==1) B=IRB; ylabel({'Incidence Rate per 100k Persons'}); ylim([0 140]); title({'CDC Female Breast Cancer', 'Incidence Rate'}); end;
if(si==2) B=DRB; ylabel({'Death Rate per 100k Persons'}); ylim([0 40]); title({'CDC Female Breast Cancer', 'Death Rate'}); end;
i=5; while(i<=length(B(1,:))) err=0.5*(B(:,i+2)-B(:,i+1)); e=errorbar(B(:,1),B(:,i),err,'o'); e.LineWidth=1.0; e.Color=c(i-4,:); i=i+3; end;
i=5; while(i<=length(B(1,:))) l=plot(B(:,1),B(:,i)); l.LineWidth=0.15; l.Color=c(i-4,:); i=i+3; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); legend(L(1:end-1),'Location','SouthEast','Orientation','Vertical'); 
si=si+1; end;
%Treatment Efficacy 
s1=1; s2=2; si=2; subplot(s1, s2, si);
b=bar(DB(:,1),DB(:,2:end)); i=1; while(i+1<length(DB(1,:))); b(:,i).FaceColor = c(i+i*3-i+1,:); b(:,i).EdgeColor = [0 0 0]; i=i+1; end; 
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Count Fraction  - Death Count Fraction'}); ylim([-.05 .035]); set(gca,'YTick',[-.05:.01:.05]); 
title({'Treatment Efficacy','(+) Incidence > Death = Effective VS (-) Incidence < Death = Ineffective'}); legend(L(1:end-1),'Location','SouthEast','Orientation','Vertical'); 
hold off; 
% Save figure (9/16 is youtube aspect ratio)
AR =.35; sz = 1200; set(f1, 'Position', [0 0 sz AR*sz]);savedir=strcat('Figures'); mkdir(savedir); newname=[savedir '/' ,'Rationale.jpg']; print(f1, newname, '-djpeg', '-r600');
