close all; clc; clearvars; R=10; %R is the font size
% CDC data https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Data in gogle sheet: https://docs.google.com/spreadsheets/d/1W5fmXt9xLTvnjzmnuTThRp8C8zUKMzrAbTUxTvw3aFg/edit#gid=0
a = 2; % Select disease 
CDC = csvread('CDC.csv', 1, 0); CDC=CDC(CDC(:,1)==a,:); CDC=CDC(:,2:end); % Disease specific CDC data
CL = csvread('CellLines.csv', 1, 0); CL=CL(CL(:,1)==a,:); CL=CL(:,2:end); % Disease specific cell lines
CL1=[]; i=1; while(i<=2016) CLa=CL(CL(:,5)<=i,:); CL1(i,1)=i; j=1; while(j<=max(CL(:,2))) CLb=CLa(CLa(:,2)==j,:); CL1(i,j+1)=length(CLb(:,4)); j=j+1; end; i=i+1; end; 
PuC = csvread('PubCount.csv', 1, 0); PuC=PuC(PuC(:,3)==a,:); PuC=[PuC(:,1:2), PuC(:,4:5)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,3)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,2))) PuCb=PuCa(PuCa(:,2)==j,:); PuC1(i,j+1)=sum(PuCb(:,4)); j=j+1; end; i=i+1; end; 
PuC2 = [PuC1(:,1)]; b=transpose(sum(transpose(PuC1))); i=2; while(i<=length(PuC1(1,:))) PuC2= [PuC2, PuC1(:,i)./b]; i=i+1; end;

Eth = [{'All','White','Black','Asian','American Indian','Hispanic','Unknown'}];
c=[1 1 1; 1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 1 1; 1 0 1; .25 .25 .25; .5 .5 .5];

close all; f1 = figure; s1=1; s2=3; si=0; 
%Incidence Rate by Ethnicity, Set the disease index (a) and the index type (b) 
b=1; B=CDC(CDC(:,1)==b,:); B=B(:,2:end); 
Bi=B(:,1); i=2; while(i<=length(B(1,:))); Bi=[Bi, B(:,i)./B(:,2)]; i=i+3; end;
si=si+1; subplot(s1, s2, si); hold on;  i=2; a=1; while(i<=length(B(1,:))); sc = scatter(B(:,1),B(:,i)); i=i+3; sc.MarkerFaceColor = c(a,:); sc.MarkerEdgeColor = [0 0 0]; a=a+1; end; 
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Rate per 100k Persons'}); ylim([0 150]); set(gca,'YTick',[0:10:200]); 
title({'CDC Female Breast Incidence Rate'}); 
legend(Eth,'Location','SouthWest','Orientation','Vertical'); box on; hold off; 

%Death Rate by Ethnicity, Set the disease index (a) and the index type (b)
b=2; B=CDC(CDC(:,1)==b,:); B=B(:,2:end); 
Bd=B(:,1); i=2; while(i<=length(B(1,:))); Bd=[Bd, B(:,i)./B(:,2)]; i=i+3; end;
si=si+1; subplot(s1, s2, si); hold on;  i=2; a=1; while(i<=length(B(1,:))); sc = scatter(B(:,1),B(:,i)); i=i+3; sc.MarkerFaceColor = c(a,:); sc.MarkerEdgeColor = [0 0 0]; a=a+1; end; 
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Death Rate per 100k Persons'}); ylim([0 36]); set(gca,'YTick',[0:5:100]); 
title({'CDC Female Breast Death Rate'}); 
legend(Eth,'Location','SouthWest','Orientation','Vertical'); box on; hold off; 

%Treatment Efficacy
Bid=Bi-Bd; Bid = [Bi(:,1), Bid(:,2:end)]
si=si+1; subplot(s1, s2, si); hold on;  b = bar(Bid(:,1),Bid(:,3:end),3);
i=1; while(i<=length(b)); b(:,i).FaceColor = c(i+1,:); b(:,i).EdgeColor = [0 0 0]; i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Count Fraction  - Death Count Fraction'}); ylim([-.5 .5]); set(gca,'YTick',[-.5:.1:.5]); 
title({'Treatment Efficacy'}); 
legend(Eth(2:end),'Location','NorthWest','Orientation','Vertical'); box on; hold off; 

%Save image 9/16 is youtube aspect ratio
AR =.35; size = 1000; set(f1, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir); newname=[savedir '/' ,'Rationale.jpg']; print(f1, newname, '-djpeg', '-r600') ;

close all; f2 = figure; s1=1; s2=3; si=0; 
%Incidence Rate by Ethnicity: Set the disease index (a) and the index type (b) 
b=3;  B=CDC(CDC(:,1)==b,:); B=B(:,2:end); B=B(:,any(B)); B=B(end,:); B=B(:,3:end); 
si=si+1; subplot(s1, s2, si); pie(B); title({'Breast Cancer Incidence Count'}); colormap(c(2:end,:));
a=2; C=CL(CL(:,1)==a,:); C=C(:,3:end); CC=[]; i=1; while(i<=max(CL(:,3))); CC=[CC; length(C(C(:,1)==i,:))]; i=i+1; end;

%si=si+1; subplot(s1, s2, si); CC=[CC(5), CC(2), CC(1), CC(3), CC(4),CC(6)];
%    pie(CC); title({'Breast Cancer Cell Lines'}); colormap(c(2:end,:));
%a=2; Pu=PuC(PuC(:,3)==a,:); Pu=[Pu(:,2) Pu(:,5)]; PuS=[]; i=1; while(i<=max(PuC(:,2))); p1=(Pu(Pu(:,1)==i,:)); PuS=[PuS; sum(p1(:,2))]; i=i+1; end;
%si=si+1; subplot(s1, s2, si); PuS=[PuS(5), PuS(2), PuS(1), PuS(3), PuS(4),PuS(6)];
%pie(PuS); title({'Publication Representation'}); colormap(c(2:end,:));

%Save image 9/16 is youtube aspect ratio
AR =.35; size = 1000; set(f2, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Comparison.jpg']; print(f2, newname, '-djpeg', '-r600') ;

close all; f3 = figure; s1=2; s2=2; si=0; 
% Death Count Trajectory
b=4; B=CDC(CDC(:,1)==b,:); B=B(:,2:end); B=B(:,any(B)); 
si=si+1; subplot(s1, s2, si); hold on; i=1; while(i<length(B(1,:))); p=scatter(B(:,1),B(:,i+1)); 
    p.MarkerFaceColor = c(i,:); p.MarkerEdgeColor = [0 0 0]; i=i+1; end; 
i=1; while(i<length(B(1,:))); p=plot(B(:,1),B(:,i+1)); p.Color = c(i,:); i=i+1; end; 
xlabel({'Year'}); xlim([1998 2015]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Count'}); set(gca,'yscale','log'); 
title({'Breast Cancer Incidence Count'}); legend(Eth(1:end-1),'Location','NorthWest','Orientation','Vertical');  box on; hold off;

% Publication Representation Trajectory
si=si+1; subplot(s1, s2, si); hold on; i=1; while(i<=max(CL(:,2))); p=scatter(CL1(:,1),CL1(:,i+1)); p.MarkerFaceColor = c(i+1,:); p.MarkerEdgeColor = [0 0 0]; i=i+1; end;  
i=1; while(i<=max(CL(:,2))); p=plot(CL1(:,1),CL1(:,i+1)); p.Color = c(i+1,:); i=i+1; end; 
xlabel({'Year'}); xlim([1970 2015]); set(gca,'XTick',[1950:5:2020]); 
ylabel({'Available Cell Lines'}); set(gca,'yscale','log'); 
title({'Holdings by Cell Line Banks'}); legend(Eth(2:end),'Location','NorthWest','Orientation','Vertical'); box on; hold off;

% Publication Representation Trajectory
si=si+1; subplot(s1, s2, si); hold on; i=1; while(i<=max(PuC(:,2))); p=scatter(PuC1(:,1),PuC1(:,i+1)); p.MarkerFaceColor = c(i+1,:); p.MarkerEdgeColor = [0 0 0]; i=i+1; end; 
i=1; while(i<=max(PuC(:,2))); p=plot(PuC1(:,1),PuC1(:,i+1)); p.Color = c(i+1,:); i=i+1; end; 
xlabel({'Year'}); xlim([1970 2015]); set(gca,'XTick',[1950:5:2020]); 
ylabel({'Cumulative Publications'}); set(gca,'yscale','log'); 
title({'Representation in the Publication Record'}); legend(Eth(2:end),'Location','NorthWest','Orientation','Vertical'); box on; hold off;

%Save image 9/16 is youtube aspect ratio
AR =1; size = 1000; set(f3, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Trajectory.jpg']; print(f3, newname, '-djpeg', '-r600') ;