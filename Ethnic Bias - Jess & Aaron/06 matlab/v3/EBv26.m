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
k = 4;
while(si<3) si=si+1; subplot(s1, s2, si); box on; grid off; if(si<3); hold on; end;

B=CDC(CDC(:,1)==z,:)
if(si==1) B=[B(:,2), B(:,k:k+3), B(:,k-1)]; ylabel({'Incidence Rate per 10k'}); title({'Incidence Rate'});  
elseif(si==2) B=[B(:,2), B(:,k+5:k+8), B(:,k+4)]; ylabel({'Incidence Rate per 10k'}); title({'Death Rate'});  
else B=[B(:,2), B(:,k:k+3)-B(:,k+5:k+8), B(:,k-1)-B(:,k+4)]; ylabel({'Incidence - Death Rate'}); title({'Death Rate'}); end;

if(si<3) i=1; while(i<length(B(1,:))); s=scatter(B(:,1),B(:,1+i));  
        s.LineWidth=0.1; s.MarkerEdgeColor=0.7*c(i,:); s.MarkerFaceColor=c(i,:); i=i+1; end; 
elseif(si==3) b=bar(B(:,1),B(:,2:end)); i=1; while(i<length(B(1,:))); 
        b(:,i).EdgeColor = 0.7*c(i,:); b(:,i).FaceColor = c(i,:); i=i+1; end; end;

xlabel({'Year'}); xlim([min(B(:,1))-1 max(B(:,1))+1]); set(gca,'XTick',[1950:2:2020]); 
legend('Asian','Black','Hipanic','White','All','Location','SouthEast','Orientation','Vertical');
if(si<3); hold off; end; end; 

AR =.3; %9/16 is youtube aspect ratio
size = 1000; set(f1, 'Position', [0 0 size AR*size]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationale.jpg'];
print(f1, newname, '-djpeg', '-r600') 