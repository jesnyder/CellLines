close all; clc; clearvars; R=10; %R is the font size

CDC = csvread('CDC.csv', 1, 0); CDC=CDC(:,1:4); t=1; while(t<=4)
a=2; while(a<=6); CDCt=CDC(CDC(:,1)==a,:); CDCt=CDCt(CDCt(:,2)==t,:); i=1; while(i<=length(CDCt(:,1))) CDCs(i,1)=CDCt(i,3); if(CDCt(i,1)==4); CDCs(i,2)=CDCt(i,end);  elseif(CDCt(i,1)==5); CDCs(i,3)=CDCt(i,end); elseif(CDCt(i,1)==6) CDCs(i,4)=CDCt(i,end); end; i=i+1; end; a=a+1; end; 
CDCsn = [CDCs(:,1), CDCs(:,2)./CDCs(:,2), CDCs(:,3)./CDCs(:,2), CDCs(:,4)./CDCs(:,2)];
if(t==1) CDC1=CDCs; elseif(t==2) CDC2=CDCs; elseif(t==3) CDC3=CDCs; CDC3n=CDCsn; elseif(t==4) CDC4=CDCs; CDC4n=CDCsn; end; t=t+1; end;

%Download csv from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=372534005
CL = csvread('CellLineSum.csv', 1, 0); CL=CL(CL(:,1)==4,:); CL=CL(CL(:,4)==0,:); CL=[CL(:,2), CL(:,6)]; % Disease specific cell lines, remove contaminated cell lines
CL1=[]; i=1; while(i<=2016) CLa=CL(CL(:,end)<=i,:); CL1(i,1)=i;  j=1; while(j<=max(CL(:,1))) CLb=CLa(CLa(:,1)==j,:); CL1(i,j+1)=length(CLb(:,1)); j=j+1; end; i=i+1; end; 
CL2 = transpose(sum(transpose(CL1(:,2:end)))); CL1 = [ CL1, CL2]; CL2=[CL1(:,1), CL1(:,2)./CL1(:,end), CL1(:,3)./CL1(:,end), CL1(:,4)./CL1(:,end)];
CL3 = transpose(sum(transpose(CL1(:,2:end-2)))); CL3=[CL1(:,1), CL1(:,2)./CL3, CL1(:,3)./CL3];

% Download publication count from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=0
PuC = csvread('PubCount.csv', 1, 0); PuC=PuC(PuC(:,3)==4,:); PuC=[PuC(:,1), PuC(:,4)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,2)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,1))) PuCb=PuCa(PuCa(:,1)==j,:); PuC1(i,j+1)=sum(PuCb(:,1)); j=j+1; end; i=i+1; end; 
PuC2 = transpose(sum(transpose(PuC1(:,2:end)))); PuC1 = [ PuC1, PuC2]; PuC2=[PuC1(:,1), PuC1(:,2)./PuC1(:,end), PuC1(:,3)./PuC1(:,end), PuC1(:,4)./PuC1(:,end)];
PuC3 = transpose(sum(transpose(PuC1(:,2:end-2)))); PuC3=[PuC1(:,1), PuC1(:,2)./PuC3, PuC1(:,3)./PuC3];

% Download publication count from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=0
PaC = csvread('Pat.csv', 1, 0); PaC=PaC(PaC(:,3)==4,:); PaC=[PaC(:,1), PaC(:,4)]; % Disease specific Publication count 
PaC1=[]; i=1; while(i<=2016) PaCa=PaC(PaC(:,2)<=i,:); PaC1(i,1)=i; j=1; while(j<=max(PaC(:,1))) PaCb=PaCa(PaCa(:,1)==j,:); PaC1(i,j+1)=sum(PaCb(:,1)); j=j+1; end; i=i+1; end; 
PaC2 = transpose(sum(transpose(PaC1(:,2:end)))); PaC1 = [ PaC1, PaC2]; PaC2=[PaC1(:,1), PaC1(:,2)./PaC1(:,end), PaC1(:,3)./PaC1(:,end), PaC1(:,4)./PaC1(:,end)];
PaC3 = transpose(sum(transpose(PaC1(:,2:end-2)))); PaC3=[PaC1(:,1), PaC1(:,2)./PaC3, PaC1(:,3)./PaC3];

Eth = [{'All','Female','Male','Unknown'}]; In = [{'Incidence','Death','Cell Line','Publication'}];
c=[.2 .2 .2; 1 0 0; 0 0 1; .5 .5 .5; .2 0 .8; 0 0 1; .3 .3 .3; 0 1 0; 0 1 0];

close all; f1 = figure; s1=2; s2=4; si=0; 
si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=2; while(i<=length(CDC1(1,:))); s=plot(CDC1(:,1),CDC1(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence Rate per 100k Population'}); box on; hold off; 
legend(Eth(:,1:end),'Location','NorthEast','Orientation','Vertical'); 
title({'(A) U.S. Lung Cancer',' Incidence Population'}); 
si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=2; while(i<=length(CDC2(1,:))); s=plot(CDC2(:,1),CDC2(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Death Rate per 100k Population'}); box on; hold off; 
title({'(B) U.S. Lung Cancer',' Death Population'}); 
legend(Eth(:,1:end),'Location','NorthEast','Orientation','Vertical'); 

si=si+1; subplot(s1, s2, si); hold on; i=1; while(i+1<length(PuC1(1,:))); s = plot(PuC1(:,1),PuC1(:,i+1),'Color',c(i+1,:),'Linewidth',2); i=i+1; end;
i=1; while(i+1<length(PuC1(1,:))); s = scatter(PuC1(:,1),PuC1(:,i+1),2,'o','MarkerEdgeColor',c(i+1,:)); i=i+1; end; hold off; 
title({'(C) Publications citing Lung Cancer','Cell Lines by Donor Gender'}); 
ylabel({'Cumulative No. of Publications'}); set(gca,'yscale' ,'log'); set(gca,'fontsize', R); 
xlim([1965 2016]); set(gca,'XTick',[1955:10:2015]); box on; 
legend(Eth(:,2:end),'Location','SouthEast','Orientation','Vertical'); box on; 

si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=1; while(i+1<length(PuC1(1,:))); s = plot(PaC1(:,1),PaC1(:,i+1),'Color',c(i+1,:),'Linewidth',2); i=i+1; end; 
i=1; while(i+1<length(PaC1(1,:))); s = scatter(PaC1(:,1),PaC1(:,i+1),2,'o','MarkerEdgeColor',c(i+1,:)); i=i+1; end; hold off; 
title({'(D) U.S. Patents citing Lung Cancer','Cell Lines by Donor Gender'}); 
ylabel({'Cumulative No. of Patents'}); set(gca,'yscale' ,'log');  
xlim([2000 2016]); set(gca,'XTick',[1950:4:2020]); box on; %legend(Eth(:,2:end),'Location','NorthWest','Orientation','Vertical'); box on; 
legend(Eth(:,2:end),'Location','SouthEast','Orientation','Vertical'); box on; 

si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); b=bar(CDC3n(:,1),CDC3n(:,3:end)-CDC4n(:,3:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end;
xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence - Death Fraction'}); 
title({'(E) Bias of Lung Cancer','Treatment Efficacy'}); box on; set(gca,'fontsize', R); hold off; 
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); b=bar(CDC4n(:,1),-CDC4n(:,3:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(F) Bias of Lung Cancer','Publication Record'}); 
ylabel({'Publication - Death Fraction'}); set(gca,'YTick',[-1:.05:1]); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); set(gca,'fontsize', R);
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); b=bar(CDC4n(:,1),-CDC4n(:,3:end)+PaC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(G) Bias of Lung Cancer','U.S. Patent Record'}); 
ylabel({' Patent - Death Fraction'});  set(gca,'YTick',[-1:.05:1]); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); set(gca,'fontsize', R);
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); t=1; b=bar([CDC3n(end-t,3:end); CDC4n(end-t,3:end); CL3(end-3-t,2:end); PuC3(end-3-t,2:end); PaC3(end-3-t,2:end) ],1,'stacked'); 
i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=[1 1 1]; i=i+1; end;  
title({'(H) Lung Cancer Prevalence', 'and Research in 2013'}); 
set(gca,'XTickLabel',{'Incidence', 'Death', 'Cell Lines', 'Pubs', 'Patents'}); set(gca,'fontsize', R); ylabel({'Fraction'}); ylim([0 1.01]); set(gca,'YTick',[0:.1:1]); xlim([.45 5.55]); set(gca,'XTick',[1:1:6]); 

AR =.5; size = 1200; set(f1, 'Position', [0 0 size AR*size]); 
savedir=strcat('Lung Figures'); mkdir(savedir); newname=[savedir '/' ,'LungComposite.jpg']; 
