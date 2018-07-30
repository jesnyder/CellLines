close all; clc; clearvars; 

% CDC Statistics https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Convert all CDC .txt data to .csv


CDC = csvread('CDClong.csv', 2, 2);

close all; f1 = figure; s1=1; s2=2; si=0; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; 
B=CDC(CDC(:,1)==2,:); B=B(B(:,2)==1,:); B=B(B(:,3)==4,:); % Determine 
i=5; while(i<=length(B(1,:))) scatter(B(:,4),B(:,i)); i=i+3; end; 
xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
ylabel({'Incidence Rate per 10k'}); ylim([0 80]); set(gca,'YTick',[0:10:2020]); 
title({'Incidence Rate'}); hold off; 

si=si+1; subplot(s1, s2, si); hold on; box on; grid off; 
B=CDC(CDC(:,1)==2,:); B=B(B(:,2)==1,:); B=B(B(:,3)==2,:); % Determine 
i=5; while(i<=length(B(1,:))) scatter(B(:,4),B(:,i)); i=i+3; end; 
%xlabel({'Year'}); xlim([1998 2014]); set(gca,'XTick',[1950:2:2020]); 
%ylabel({'Incidence Rate per 10k'}); ylim([0 80]); set(gca,'YTick',[0:10:2020]); 
title({'Incidence Rate'}); hold off; 


AR =.35; %9/16 is youtube aspect ratio
size = 1000; set(f1, 'Position', [0 0 size AR*size]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationalev2.jpg'];
print(f1, newname, '-djpeg', '-r600') 