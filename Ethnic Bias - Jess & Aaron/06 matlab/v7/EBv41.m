close all; clc; clearvars; R=10; %R is the font size

a =2; while(a<=4); % Cancer Type (1=Undefined, 2=Breast, 3=Male Prostate, 4=Lung) 
%CDC Data from https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Download from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=2106549672
CDC = csvread('CDC.csv', 1, 0); CDC=CDC(CDC(:,1)==a,:); CDC=CDC(:,2:end); % Disease specific CDC data
CDC1=CDC(CDC(:,1)==1,:); CDC1=CDC1(:,2:end); CDC1=[CDC1(:,1), CDC1(:,2), CDC1(:,11), CDC1(:,8), CDC1(:,17), CDC1(:,14), CDC1(:,5)]; CDC2=CDC(CDC(:,1)==2,:); CDC2=CDC2(:,2:end); CDC2=[CDC2(:,1), CDC2(:,2), CDC2(:,11), CDC2(:,8), CDC2(:,17), CDC2(:,14), CDC2(:,5)];
CDC3=CDC(CDC(:,1)==3,:); CDC3=CDC3(:,2:end); CDC3=[CDC3(:,1), CDC3(:,2), CDC3(:,11), CDC3(:,8), CDC3(:,17), CDC3(:,14), CDC3(:,5)]; CDC3n=CDC3(:,1); b=transpose(sum(transpose(CDC3(:,3:end)))); i=3; while(i<=length(CDC3(1,:))) CDC3n=[CDC3n, CDC3(:,i)./b]; i=i+1; end;
CDC4=CDC(CDC(:,1)==4,:); CDC4=CDC4(:,2:end); CDC4=[CDC4(:,1), CDC4(:,2), CDC4(:,11), CDC4(:,8), CDC4(:,17), CDC4(:,14), CDC4(:,5)]; CDC4n=CDC4(:,1); b=transpose(sum(transpose(CDC4(:,3:end)))); i=3; while(i<=length(CDC4(1,:))) CDC4n=[CDC4n, CDC4(:,i)./b]; i=i+1; end;

%Download csv from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=372534005
CL = csvread('CellLineSum.csv', 1, 0); CL=CL(CL(:,1)==a,:); CL=CL(CL(:,4)==0,:); CL=[CL(:,2),CL(:,3), CL(:,5), CL(:,6)]; % Disease specific cell lines, remove contaminated cell lines
CL1=[]; i=1; while(i<=2016) CLa=CL(CL(:,end)<=i,:); CL1(i,1)=i; j=1; while(j<=max(CL(:,2))) CLb=CLa(CLa(:,2)==j,:); CL1(i,j+1)=length(CLb(:,4)); j=j+1; end; i=i+1; end; 
CL2 = [CL1(:,1)]; b=transpose(sum(transpose(CL1(:,2:end)))); i=1; while(i<=max(CL(:,2))) CL2= [CL2, CL1(:,i+1)./b]; i=i+1; end;
CL3=CL1(:,1); b1=CL1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(CL(:,2))) CL3= [CL3, b1(:,i+1)./b]; i=i+1; end;

% Download publication count from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=0
PuC = csvread('PubCount.csv', 1, 0); if(a==5) PuC=PuC(PuC(:,1)==1,:); end; PuC=PuC(PuC(:,3)==a,:); PuC=[PuC(:,1:2), PuC(:,4:5)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,3)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,2))) PuCb=PuCa(PuCa(:,2)==j,:); PuC1(i,j+1)=sum(PuCb(:,4)); j=j+1; end; i=i+1; end; 
PuC2 = [PuC1(:,1)]; b=transpose(sum(transpose(PuC1(:,2:end)))); i=1; while(i<=max(PuC(:,2))) PuC2= [PuC2, PuC1(:,i+1)./b]; i=i+1; end;
PuC3=PuC1(:,1); b1=PuC1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(PuC(:,2))) PuC3= [PuC3, b1(:,i+1)./b]; i=i+1; end;

% Download publication count from https://docs.google.com/spreadsheets/d/1PX1VQP5OoNXjQJK9c-Jpbic9BL3H0Af29erB8deGvUw/edit#gid=0
PaC = csvread('PatCount.csv', 1, 0); PaC=PaC(PaC(:,3)==a,:); PaC=[PaC(:,1:2), PaC(:,4:5)]; % Disease specific Publication count 
PaC1=[]; i=1; while(i<=2016) PaCa=PaC(PaC(:,3)<=i,:); PaC1(i,1)=i; j=1; while(j<=max(PaC(:,2))) PaCb=PaCa(PaCa(:,2)==j,:); PaC1(i,j+1)=sum(PaCb(:,4)); j=j+1; end; i=i+1; end; 
PaC2 = [PaC1(:,1)]; b=transpose(sum(transpose(PaC1(:,2:end)))); i=1; while(i<=max(PaC(:,2))) PaC2= [PaC2, PaC1(:,i+1)./b]; i=i+1; end;
PaC3=PaC1(:,1); b1=PaC1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(PaC(:,2))) PaC3= [PaC3, b1(:,i+1)./b]; i=i+1; end;

Eth = [{'All','Asian','Black','Hispanic','Native American','White','Unknown'}]; In = [{'Incidence','Death','Cell Line','Publication'}];
c=[.2 .2 .2; 1 0 0; .8 0 .2; .5 0 .5; .2 0 .8; 0 0 1; .3 .3 .3; 0 1 0; 0 1 0];

close all; f1 = figure; s1=2; s2=4; si=0; 
si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=2; while(i<=length(CDC1(1,:))); s=plot(CDC1(:,1),CDC1(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence Rate per 100k Population'}); box on; hold off; legend(Eth(:,1:end-1),'Location','SouthWest','Orientation','Vertical'); 
if(a==2) title({'(A) U.S. Breast Cancer',' Incidence Population'}); elseif(a==3) title({'(A) U.S. Prostate Cancer',' Incidence Population'}); elseif(a==4) title({'(A) U.S. Lung Cancer',' Incidence Population'}); end;
si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=2; while(i<=length(CDC2(1,:))); s=plot(CDC2(:,1),CDC2(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Death Rate per 100k Population'}); box on; hold off; 
if(a==2) title({'(B) U.S. Breast Cancer',' Death Population'}); elseif(a==3) title({'(B) U.S. Prostate Cancer',' Death Population'}); elseif(a==4) title({'(B) U.S. Lung Cancer',' Death Population'}); end;
si=si+1; subplot(s1, s2, si); hold on; i=1; while(i+1<length(PuC1(1,:))); s = scatter(PuC1(:,1),PuC1(:,i+1),2,'o','MarkerEdgeColor',c(i+1,:)); i=i+1; end; 
i=1; while(i+1<length(PuC1(1,:))); s = plot(PuC1(:,1),PuC1(:,i+1),'Color',c(i+1,:),'Linewidth',2); i=i+1; end; hold off; 
if(a==2) title({'(C) Publications citing Breast Cancer','Cell Lines by Donor Ethnicity'}); elseif(a==3) title({'(C) Publications citing Prostate Cancer','Cell Lines by Donor Ethnicity'}); elseif(a==4) title({'(C) Publications citing Lung Cancer','Cell Lines by Donor Ethnicity'}); end;
ylabel({'Cumulative No. of Publications'}); set(gca,'yscale' ,'log'); set(gca,'fontsize', R); 
xlim([1970 2016]); set(gca,'XTick',[1950:10:2015]); box on; %legend(Eth(:,2:end),'Location','NorthWest','Orientation','Vertical'); box on; 
si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); i=1; while(i+1<length(PaC1(1,:))); s = scatter(PaC1(:,1),PaC1(:,i+1),2,'o','MarkerEdgeColor',c(i+1,:)); i=i+1; end; 
i=1; while(i+1<length(PuC1(1,:))); s = plot(PaC1(:,1),PaC1(:,i+1),'Color',c(i+1,:),'Linewidth',2); i=i+1; end; hold off; 
if(a==2) title({'(D) U.S. Patents citing Breast Cancer','Cell Lines by Donor Ethnicity'}); elseif(a==3) title({'(D) U.S. Patents citing Prostate Cancer','Cell Lines by Donor Ethnicity'}); elseif(a==4) title({'(D) U.S. Patents citing Lung Cancer','Cell Lines by Donor Ethnicity'}); end;
ylabel({'Cumulative No. of Patents'}); set(gca,'yscale' ,'log');  
xlim([1990 2016]); set(gca,'XTick',[1950:4:2020]); box on; %legend(Eth(:,2:end),'Location','NorthWest','Orientation','Vertical'); box on; 

s1=2; s2=4; si=4; si=si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize', R); b=bar(CDC3n(3:end,1),CDC3n(3:end,2:end)-CDC4n(3:end,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end;
xlim([2000 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence - Death Fraction'}); 
if(a==2) title({'(E) Bias of Breast Cancer','Treatment Efficacy'}); elseif(a==3) title({'(E) Bias of Prostate Cancer','Treatment Efficacy'}); elseif(a==4) title({'(E) Bias of Lung Cancer','Treatment Efficacy'}); end;
box on; set(gca,'fontsize', R); hold off; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); b=bar(CDC4n(3:end,1),-CDC4n(3:end,2:end)+PuC3(2001:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
if(a==2) title({'(F) Bias of Breast Cancer','Publication Record'}); elseif(a==3) title({'(F) Bias of Prostate Cancer','Publication Record'}); elseif(a==4) title({'(F) Bias of Lung Cancer','Publication Record'}); end;
ylabel({'Publication - Death Fraction'}); set(gca,'YTick',[-1:.05:1]); xlim([2000 2014]); set(gca,'XTick',[1950:2:2020]); set(gca,'fontsize', R);
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); b=bar(CDC4n(3:end,1),-CDC4n(3:end,2:end)+PaC3(2001:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
if(a==2) title({'(G) Bias of Breast Cancer','U.S. Patent Record'}); elseif(a==3) title({'(G) Bias of Prostate Cancer','U.S. Patent Record'}); elseif(a==4) title({'(G) Bias of Lung Cancer','U.S. Patent Record'}); end;
ylabel({' Patent - Death Fraction'});  set(gca,'YTick',[-1:.05:1]); xlim([2000 2014]); set(gca,'XTick',[1950:2:2020]); set(gca,'fontsize', R);
si=si+1; subplot(s1, s2, si); set(gca,'fontsize', R); t=1; b=bar([CDC3n(end-t,2:end); CDC4n(end-t,2:end); CL3(end-3-t,2:end); PuC3(end-3-t,2:end); PaC3(end-3-t,2:end) ],1,'stacked'); 
i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=[1 1 1]; i=i+1; end;  
if(a==2) title({'(H) Breast Cancer Prevalence', 'and Research in 2013'}); elseif(a==3) title({'(H) Prostate Cancer Prevalence', 'and Research in 2013'}); elseif(a==4) title({'(H) Lung Cancer Prevalence', 'and Research in 2013'}); end;
set(gca,'XTickLabel',{'Incidence', 'Death', 'Cell Lines', 'Pubs', 'Patents'}); set(gca,'fontsize', R); ylabel({'Fraction'}); ylim([0 1.01]); xlim([.45 5.55]); set(gca,'XTick',[1:1:6]); 
%legend(Eth(:,2:end),'Location','NorthWest','Orientation','Vertical');
%Save image 9/16 is youtube aspect ratio
AR =.5; size = 1200; set(f1, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir); if(a==2); newname=[savedir '/' ,'BreastComposite.jpg']; elseif(a==3); newname=[savedir '/' ,'ProstateComposite.jpg']; elseif(a==4); newname=[savedir '/' ,'LungComposite.jpg']; end; print(f1, newname, '-djpeg', '-r600') ;
a=a+1; end

