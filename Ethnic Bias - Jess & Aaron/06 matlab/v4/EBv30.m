close all; clc; clearvars; R=10; %R is the font size
% CDC data https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Data in gogle sheet: https://docs.google.com/spreadsheets/d/1W5fmXt9xLTvnjzmnuTThRp8C8zUKMzrAbTUxTvw3aFg/edit#gid=0
CDC = csvread('CDC.csv', 2, 4);

c = [0 0 0; 1 1 1; 1 1 1; ...
     1 0 0; .9 0 0; .8 0 0; ...
     0 1 0; 0 .9 0 ; 0 .8 0; ...
     0 0 1; 0 0 .9; 0 0 .8; ...
     .5 0 0; .9 .9 0; .8 .8 0; ...
     0 .5 0; .9 .9 .9; .8 .8 .8; ...
     0 0 .5; .9 .9 .9; .8 .8 .8;...
     .5 1 .5; 0 .9 .5; 0 .8 .5; ...
     1 1 1; 1 1 1; 1 1 1];

close all; f1 = figure; s1=1; s2=3; si=0; 

L = [{'All','White','Black','Asian','American Indian','Hispanic'}];
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
B=CDC(CDC(:,2)==2,:); B=B(B(:,3)==1,:); B=B(B(:,4)==4,:);
i=5; while(i<=length(B(1,:))) err=0.5*(B(:,i+2)-B(:,i+1)); e=errorbar(B(:,1),B(:,i),err,'o'); e.LineWidth=1.0; e.Color=c(i-4,:); i=i+3; end;
i=5; while(i<=length(B(1,:))) l=plot(B(:,1),B(:,i)); l.LineWidth=0.5; l.Color=c(i-4,:); i=i+3; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Rate per 100k Persons'}); %ylim([50 150]); set(gca,'YTick',[0:10:2020]); 
title({'CDC Female Breast Cancer: Incidence Rate'}); hold off; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
B=CDC(CDC(:,2)==2,:); B=B(B(:,3)==2,:); B=B(B(:,4)==4,:);
i=5; while(i<=length(B(1,:))) err=0.5*(B(:,i+2)-B(:,i+1)); e=errorbar(B(:,1),B(:,i),err,'o'); e.LineWidth=1.0; e.Color=c(i-4,:); i=i+3; end;
i=5; while(i<=length(B(1,:))) l=plot(B(:,1),B(:,i)); l.LineWidth=0.15; l.Color=c(i-4,:); i=i+3; end;
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Death Rate per 100k Persons'}); %ylim([50 150]); set(gca,'YTick',[0:10:2020]); 
title({'CDC Female Breast Cancer: Death Rate'}); hold off; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
B=CDC(CDC(:,2)==2,:); B=B(B(:,3)==2,:); B=B(B(:,4)==4,:); B1=B;
B=CDC(CDC(:,2)==2,:); B=B(B(:,3)==2,:); B=B(B(:,4)==4,:); B2=B;
B=B1-B2; B(:,1)=B1(:,1);

i=5; while(i<=length(B(1,:))) b=bar(B,'stacked'); end;
%xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
%ylabel({'Death Rate per 100k Persons'}); %ylim([50 150]); set(gca,'YTick',[0:10:2020]); 
title({'CDC Female Breast Cancer Death Rate'}); legend(L, 'Location','WestOutside'); hold off; 

AR =1/3; %9/16 is youtube aspect ratio
sz = 1000; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationale.jpg'];
print(f1, newname, '-djpeg', '-r600') 
