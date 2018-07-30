close all; clc; clearvars; R=10; %R is the font size
a = 2; % Cancer Type (1=Undefined, 2=Breast, 3=Male Prostate, 4=Lung) 
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
PuC = csvread('PubCount.csv', 1, 0); PuC=PuC(PuC(:,3)==a,:); PuC=[PuC(:,1:2), PuC(:,4:5)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,3)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,2))) PuCb=PuCa(PuCa(:,2)==j,:); PuC1(i,j+1)=sum(PuCb(:,4)); j=j+1; end; i=i+1; end; 
PuC2 = [PuC1(:,1)]; b=transpose(sum(transpose(PuC1(:,2:end)))); i=1; while(i<=max(PuC(:,2))) PuC2= [PuC2, PuC1(:,i+1)./b]; i=i+1; end;
PuC3=PuC1(:,1); b1=PuC1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(PuC(:,2))) PuC3= [PuC3, b1(:,i+1)./b]; i=i+1; end;

Eth = [{'All','Asian','Black','Hispanic','American Indian','White','Unknown'}]; In = [{'Incidence','Death','Cell Line','Publication'}];
c=[.2 .2 .2; 1 0 0; .8 0 .2; .5 0 .5; .2 0 .8; 0 0 1; .3 .3 .3; 0 1 0; 0 1 0];

close all; f1 = figure; s1=2; s2=2; si=0; 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC1(1,:))); s=plot(CDC1(:,1),CDC1(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence Rate per 100k Population'}); title({'(A) Breast Cancer Incidence Population'}); box on; hold off; legend(Eth(:,1:end-1),'Location','NorthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC2(1,:))); s=plot(CDC2(:,1),CDC2(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Death Rate per 100k Population'}); title({'(B) Breast Cancer Morbidity'}); box on; hold off; %legend(Eth(:,1:end-1),'Location','SouthWest','Orientation','Vertical'); 
s1=2; s2=3; si=3; si=si+1; subplot(s1, s2, si); hold on; b=bar(CDC3n(:,1),CDC3n(:,2:end)-CDC4n(:,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence - Death Fraction'}); 
title({'(C) Treatment Efficacy'}); box on; hold off; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); b=bar(CDC3n(:,1),-CDC3n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(D) Representation of Diagnosed','Cases in Publications'}); ylabel({'Publication - Incidence Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); 
si=si+1; subplot(s1, s2, si); b=bar(CDC4n(:,1),-CDC4n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(E) Representation of', 'Morbidity in Publications'});  ylabel({' Publication - Death Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]);
%Save image 9/16 is youtube aspect ratio
AR =.7; size = 800; set(f1, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir); newname=[savedir '/' ,'BreastComposite.jpg']; print(f1, newname, '-djpeg', '-r600') ;

a = 3; % Cancer Type (1=Undefined, 2=Breast, 3=Male Prostate, 4=Lung) 
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
PuC = csvread('PubCount.csv', 1, 0); PuC=PuC(PuC(:,3)==a,:); PuC=[PuC(:,1:2), PuC(:,4:5)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,3)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,2))) PuCb=PuCa(PuCa(:,2)==j,:); PuC1(i,j+1)=sum(PuCb(:,4)); j=j+1; end; i=i+1; end; 
PuC2 = [PuC1(:,1)]; b=transpose(sum(transpose(PuC1(:,2:end)))); i=1; while(i<=max(PuC(:,2))) PuC2= [PuC2, PuC1(:,i+1)./b]; i=i+1; end;
PuC3=PuC1(:,1); b1=PuC1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(PuC(:,2))) PuC3= [PuC3, b1(:,i+1)./b]; i=i+1; end;

close all; f1 = figure; s1=2; s2=2; si=0; 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC1(1,:))); s=plot(CDC1(:,1),CDC1(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence Rate per 100k Population'}); title({'(A) Prostate Cancer Incidence Population'}); box on; hold off; legend(Eth(:,1:end-1),'Location','NorthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC2(1,:))); s=plot(CDC2(:,1),CDC2(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Death Rate per 100k Population'}); title({'(B) Prostate Cancer Morbidity'}); box on; hold off; %legend(Eth(:,1:end-1),'Location','SouthWest','Orientation','Vertical'); 
s1=2; s2=3; si=3; si=si+1; subplot(s1, s2, si); hold on; b=bar(CDC3n(:,1),CDC3n(:,2:end)-CDC4n(:,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence - Death Fraction'}); 
title({'(C) Treatment Efficacy'}); box on; hold off; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); b=bar(CDC3n(:,1),-CDC3n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(D) Representation of Diagnosed','Cases in Publications'}); ylabel({'Publication - Incidence Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); 
si=si+1; subplot(s1, s2, si); b=bar(CDC4n(:,1),-CDC4n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(E) Representation of', 'Morbidity in Publications'});  ylabel({' Publication - Death Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]);
%Save image 9/16 is youtube aspect ratio
AR =.7; size = 800; set(f1, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir); newname=[savedir '/' ,'ProstateComposite.jpg']; print(f1, newname, '-djpeg', '-r600') ;

a = 4; % Cancer Type (1=Undefined, 2=Breast, 3=Male Prostate, 4=Lung) 
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
PuC = csvread('PubCount.csv', 1, 0); PuC=PuC(PuC(:,3)==a,:); PuC=[PuC(:,1:2), PuC(:,4:5)]; % Disease specific Publication count 
PuC1=[]; i=1; while(i<=2016) PuCa=PuC(PuC(:,3)<=i,:); PuC1(i,1)=i; j=1; while(j<=max(PuC(:,2))) PuCb=PuCa(PuCa(:,2)==j,:); PuC1(i,j+1)=sum(PuCb(:,4)); j=j+1; end; i=i+1; end; 
PuC2 = [PuC1(:,1)]; b=transpose(sum(transpose(PuC1(:,2:end)))); i=1; while(i<=max(PuC(:,2))) PuC2= [PuC2, PuC1(:,i+1)./b]; i=i+1; end;
PuC3=PuC1(:,1); b1=PuC1(:,1:end-1); b=transpose(sum(transpose(b1(:,2:end)))); i=1; while(i<max(PuC(:,2))) PuC3= [PuC3, b1(:,i+1)./b]; i=i+1; end;

close all; f1 = figure; s1=2; s2=2; si=0; 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC1(1,:))); s=plot(CDC1(:,1),CDC1(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence Rate per 100k Population'}); title({'(A) Lung Cancer Incidence Population'}); box on; hold off; legend(Eth(:,1:end-1),'Location','NorthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); hold on; i=2; while(i<=length(CDC2(1,:))); s=plot(CDC2(:,1),CDC2(:,i),'Color',c(i-1,:),'Linewidth',2); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Death Rate per 100k Population'}); title({'(B) Lung Cancer Morbidity'}); box on; hold off; %legend(Eth(:,1:end-1),'Location','SouthWest','Orientation','Vertical'); 
s1=2; s2=3; si=3; si=si+1; subplot(s1, s2, si); hold on; b=bar(CDC3n(:,1),CDC3n(:,2:end)-CDC4n(:,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); ylabel({'Incidence - Death Fraction'}); 
title({'(C) Treatment Efficacy'}); box on; hold off; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
si=si+1; subplot(s1, s2, si); b=bar(CDC3n(:,1),-CDC3n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(D) Representation of Diagnosed','Cases in Publications'}); ylabel({'Publication - Incidence Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]); 
si=si+1; subplot(s1, s2, si); b=bar(CDC4n(:,1),-CDC4n(:,2:end)+PuC3(1999:2013,2:end),3); i=1; while(i<=length(b)) b(i).FaceColor=c(i+1,:); b(i).EdgeColor=c(i+1,:); i=i+1; end; %legend(Eth(:,2:end),'Location','SouthWest','Orientation','Vertical'); 
title({'(E) Representation of', 'Morbidity in Publications'});  ylabel({' Publication - Death Fraction'}); ylim([-.2 .25]); set(gca,'YTick',[-1:.05:1]); xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:4:2020]);
%Save image 9/16 is youtube aspect ratio
AR =.7; size = 800; set(f1, 'Position', [0 0 size AR*size]); savedir=strcat('Figures'); mkdir(savedir); newname=[savedir '/' ,'LungComposite.jpg']; print(f1, newname, '-djpeg', '-r600') ;


