close all; clc; clearvars; R=10; %R is the font size
% CDC data https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Data in gogle sheet: https://docs.google.com/spreadsheets/d/1W5fmXt9xLTvnjzmnuTThRp8C8zUKMzrAbTUxTvw3aFg/edit#gid=0
CL = csvread('CellLines.csv', 1, 0);

close all; f1 = figure; s1=3; s2=2; si=0; 
si=si+1; subplot(s1, s2, si); m=1; 
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL(CL(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); legend('Undetermined','Breast','Prostate','Lung','Location','South');

si=si+1; subplot(s1, s2, si); m=m+1;
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL(CL(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); legend('Female','Male','Unknown','Location','South','Orientation','Horizontal');

si=si+1; subplot(s1, s2, si); m=m+1;
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL(CL(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','SouthWest','Orientation','Horizontal');

si=si+2; subplot(s1, s2, si); CL1=CL(CL(:,5)>0,:);
s = scatter(CL1(:,3),CL1(:,5)); box on; xlim([0 7]); ylim([0 110]);



close all; f1 = figure; s1=2; s2=2; si=0; 
CL1=CL(CL(:,1)>0,:); 
si=si+1; subplot(s1, s2, si); m=3; 
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL1(CL1(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); 
% legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','SouthWest','Orientation','Horizontal');

CL1=CL(CL(:,1)==2,:); 
si=si+1; subplot(s1, s2, si); m=3; 
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL1(CL1(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); 
% legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','SouthWest','Orientation','Horizontal');

CL1=CL(CL(:,1)==3,:); 
si=si+1; subplot(s1, s2, si); m=3; 
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL1(CL1(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); 
% legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','SouthWest','Orientation','Horizontal');

CL1=CL(CL(:,1)==4,:); 
si=si+1; subplot(s1, s2, si); m=3; 
C=zeros(1,max(CL(:,m))); i=1; while(i<=max(CL(:,m))); B=CL1(CL1(:,m)==i,:); C(i)=length(B); i=i+1; end;
pie(C, .25*ones(1,max(CL(:,m)))); 
% legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','SouthWest','Orientation','Horizontal');

close all; f1 = figure; s1=2; s2=2; si=0; 
C=zeros(max(CL(:,1)),max(CL(:,m))); 
k=1; while(k<=max(CL(:,1))); if(k==1); CL1=CL; else CL1=CL(CL(:,1)==k,:); end;
m=3; i=1; while(i<=max(CL(:,m))); B=CL1(CL1(:,m)==i,:); C(k,i)=length(B); i=i+1; end; k=k+1; end;  
labels=({'All','Breast','Prostate','Lung'})
C = [C transpose(sum(transpose(C)))]
i=1; while(i<=length(C(1,:))); C(:,i)=C(:,i)./C(:,end); i=i+1; end;

bar(C(:,1:end-1),1,'stacked','EdgeColor',[0 0 0],'LineWidth', 0.1); box on;
legend('Asian','Black','Hispanic','Native American','White','Undefined','Location','Eastoutside','Orientation','Vertical');
