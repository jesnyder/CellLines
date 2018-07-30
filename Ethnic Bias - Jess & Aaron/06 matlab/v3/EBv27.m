close all; 
clc; clearvars; R=15; w=1; c1 = 0*ones(5,3); c2=[.5 .5 .5 ; 1 0 0; 0 0 1; .9 .9 .9; .8 .8 .8; .8 .8 .8; .8 .8 .8]; c3=.7*c2; 
% Read in CDC Statistics Source: "CDC" Tab of the following url: https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1065966572
CDC = csvread('CDC.csv', 4, 0);
% Read in Cell Line Descriptions Source: CellLines Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=881362172
CL = csvread('CellLines.csv',1,1,[1,1,372,8]); CL=CL(CL(:,4)>0,:); CL=CL(CL(:,6)<1,:); CL=CL(:,1:end);  CL = sortrows(CL,4); % Read Cell Line Descriptions. Remove all unknown years, remove any cell lines known to have contaminants, and sort by year the cell line was introduced 
% Read in Publicaion Count Source: PubCount Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1444937265
PC = csvread('PubCount.csv',1,0); PC = sortrows(PC,4); % Read Publication Records. Remove all unknown years and sort by year the cell line was introduced 
PaC = csvread('PatentCount.csv',1,0); PaC = sortrows(PaC,4); % Read Patent Record. Remove all unknown years and sort by year the cell line was introduced 
%PaCo = csvread('PaperALL.csv',1,0); PaCo = sortrows(PaCo,-2 ); PaCo=PaCo(PaCo(:,1)>0,:); % Read Patent Count for Each Cell Line. Remove all unknown years and sort by year the cell line was introduced 
z=2; % 2  = Breast Cancer Specific
labels = [{'Asian','Black','Hispanic','White','Unspecified' }];  
labelsb = [{' ',' ',' ',' ',' ' }];  

c = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 1 1; 1 1 1];
close all; f1 = figure; s1=1; s2=3; si=0; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; 
B=CDC(CDC(:,1)==z,:); B1=[B(:,2), B(:,4:7), B(:,3)]; 
i=1; while(i<length(B1(1,:))); s=scatter(B1(:,1),B1(:,1+i)); 
    s.LineWidth=0.6; s.MarkerEdgeColor=0.7*c(i,:); s.MarkerFaceColor=c(i,:); i=i+1; end; 
xlabel({'Year'}); xlim([min(B1(:,1))-1 max(B1(:,1))+1]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Rate per 10k'}); ylim([0 150]); set(gca,'YTick',[0:20:2020]); 
title({'Incidence Rate'}); hold off; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; 
B=CDC(CDC(:,1)==z,:); B2=[B(:,2), B(:,9:12), B(:,8)]; 
i=1; while(i<length(B2(1,:))); s=plot(B2(:,2:end)); 
    %s.LineWidth=0.6; s.MarkerEdgeColor=0.7*c(i,:); s.MarkerFaceColor=c(i,:); 
    i=i+1; end; 
%xlabel({'Year'}); xlim([min(B2(:,1))-1 max(B2(:,1))+1]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Rate per 10k'}); ylim([0 150]); set(gca,'YTick',[0:20:2020]); 
title({'Incidence Rate'}); hold off; 

AR =.35; %9/16 is youtube aspect ratio
size = 1000; set(f1, 'Position', [0 0 size AR*size]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationale.jpg'];
print(f1, newname, '-djpeg', '-r600') 