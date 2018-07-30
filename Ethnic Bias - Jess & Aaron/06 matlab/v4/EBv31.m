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
 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==1,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); IRB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==2,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); DRB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==3,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); ICB = B; 
B=CDC(CDC(:,2)==3,:); B=B(B(:,3)==4,:); B=B(B(:,4)==4,:); B=B(B(:,1)>1999,:); DCB = B; 
DB = [ICB(:,1)]; i=6; while(i<=11); B =(ICB(:,i))./(ICB(:,5))-(DCB(:,i))./(DCB(:,5)); 
    DB = [DB,B]; i=i+1;  end;  

close all; f1 = figure; s1=1; s2=3; si=0; 
L = [{'All','White','Black','Asian','American Indian','Hispanic'}];

while(si<3);
si=si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R);
if(si==1) B=IRB; ylabel({'Incidence Rate per 100k Persons'}); title({'CDC Female Breast Cancer: Incidence Rate'});
elseif(si==2) B=DRB; ylabel({'Death Rate per 100k Persons'}); title({'CDC Female Breast Cancer: Death Rate'});
elseif(si==3) B=DB; ylabel({'Incidence Count Fraction  - Death Count Fraction'}); title({'Treatment Efficacy','(+) Incidence > Death = Effective','(-) Incidence < Death = Ineffective'}); end; 

if(si<3) 
i=5; while(i<=length(B(1,:))) err=0.5*(B(:,i+2)-B(:,i+1)); e=errorbar(B(:,1),B(:,i),err,'o'); e.LineWidth=1.0; e.Color=c(i-4,:); i=i+3; end;
i=5; while(i<=length(B(1,:))) l=plot(B(:,1),B(:,i)); l.LineWidth=0.15; l.Color=c(i-4,:); i=i+3; end;
legend(L,'Location','SouthEast','Orientation','Vertical'); 
else b=bar(DB(:,1),DB(:,2:end)); 
    i=1; while(i+1<length(DB(1,:))); b(:,i).FaceColor = c(i+i*3-i+1,:); b(:,i).EdgeColor = [0 0 0]; i=i+1; end; 
legend(L(2:end),'Location','SouthEast','Orientation','Vertical'); end;
xlabel({'Year'}); xlim([1999 2014]); set(gca,'XTick',[1950:2:2020]); 
hold off; end;

AR =1/3; %9/16 is youtube aspect ratio
sz = 1000; set(f1, 'Position', [0 0 sz AR*sz]);
savedir=strcat('Figures'); mkdir(savedir);
newname=[savedir '/' ,'Rationale.jpg'];
print(f1, newname, '-djpeg', '-r600') 
