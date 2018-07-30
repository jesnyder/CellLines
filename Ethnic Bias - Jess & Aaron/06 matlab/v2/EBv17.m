close all;
clc; clearvars; R=10; w=1; c1 = 0*ones(5,3); c2=[1 0 0 ; 0 1 0; 0 0 1; 0 1 1; .8 .8 .8; .8 .8 .8]; c3=.7*c2; 
% Read in CDC Statistics Source: "CDC" Tab of the following url: https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1065966572
CDC = csvread('CDC.csv', 4, 0);
% Read in Cell Line Descriptions Source: CellLines Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=881362172
CL = csvread('CellLines.csv',1,1,[1,1,370,6]); CL=CL(CL(:,4)>0,:); CL=CL(CL(:,6)<1,:); CL=CL(:,1:5); CL = sortrows(CL,4); % Read Cell Line Descriptions. Remove all unknown years, remove any cell lines known to have contaminants, and sort by year the cell line was introduced 
% Read in Publicaion Count Source: PubCount Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1444937265
PC = csvread('PubCount.csv',1,0); PC = sortrows(PC,4); % Read Cell Line Descriptions. Remove all unknown years and sort by year the cell line was introduced 
PaC = csvread('PatentCount.csv',1,0); PaC = sortrows(PaC,4); % Read Cell Line Descriptions. Remove all unknown years and sort by year the cell line was introduced 


%Count the number of cell for each demographic, for each year, for each type of cancer.
YCL = []; m=1; while(m<=max(CL(:,3))); B=CL(CL(:,2)<=5,:); 
        if(m>1); B=B(B(:,3)==m,:); end;  
        Y=[zeros(100,max(B(:,2))+3)]; Y(:,1)= m*ones(100,1); Y(:,2)= [1950:1:2049]; 
        i=1; j=1; while(i<=length(Y));
            if (j>length(B)); Y(i,r+2)=max(Y(:,r+2)); i=i+1; 
            elseif(Y(i,2)==B(j,4)); r=B(j,2); Y(i,r+2)=max(Y(:,r+2))+1; j=j+1; 
            elseif(Y(i,2)<B(j,4));  i=i+B(j,4)-Y(i,2); end; end;  
        k=1; while(k<=max(B(:,2))); i=1; 
            while (i<=length(Y)); Y(i,k+2)=max(Y(1:i,k+2)); i=i+1;  end; k=k+1; end;
        YCL = transpose([transpose(YCL) transpose(Y)]); m=m+1; end; % Create a single master list of all counts
        i=1; while(i<=length(YCL)); YCL(i,end)=sum(YCL(i,3:end-1)); i=i+1; end; % Sum all the counts in the end column 
        YCLn=YCL; i=1; while(i<=length(YCL)); YCLn(i,3:end-1)=YCLn(i,3:end-1)./YCLn(i,end); i=i+1; end; YCLn = YCLn(:,1:end-1); % Normalize the counts to 1
   
%Count the number of publications citing the cell lines for each demographic, for each year, for each type of cancer.
YPC = []; m=1; while(m<=max(PC(:,3))); B=PC(PC(:,2)<=5,:); 
        if(m>1); B=B(B(:,3)==m,:); end;  
        Y=[zeros(100,max(B(:,2))+3)]; Y(:,1)= m*ones(100,1); Y(:,2)= [1950:1:2049]; 
        i=1; j=1; while(i<=length(Y)); 
            if (j>length(B)); Y(i,r+2)=max(Y(:,r+2)); i=i+1; 
            elseif(Y(i,2)==B(j,4)); r=B(j,2); Y(i,r+2)=max(Y(:,r+2))+B(j,5); j=j+1; 
            elseif(Y(i,2)<B(j,4));  i=i+B(j,4)-Y(i,2); end; end;  
        k=1; while(k<=max(B(:,2))); i=1; 
            while (i<=length(Y)); Y(i,k+2)=max(Y(1:i,k+2)); i=i+1;  end; k=k+1; end;
        YPC = transpose([transpose(YPC) transpose(Y)]); m=m+1; end; % Create a single master list of all counts
        i=1; while(i<=length(YPC)); YPC(i,end)=sum(YPC(i,3:end-1)); i=i+1; end; % Sum all the counts in the end column 
        YPCn=YPC; i=1; while(i<=length(YPC)); YPCn(i,3:end-1)=YPCn(i,3:end-1)./YPCn(i,end); i=i+1; end; YPCn = YPCn(:,1:end-1); % Normalize the counts to 1
        
%Count the number of patents citing the cell lines for each demographic, for each year, for each type of cancer.
YPaC = []; m=1; while(m<=max(PaC(:,3))); B=PaC(PaC(:,2)<=5,:); 
        if(m>1); B=B(B(:,3)==m,:); end;  
        Y=[zeros(100,max(B(:,2))+3)]; Y(:,1)= m*ones(100,1); Y(:,2)= [1950:1:2049]; 
        i=1; j=1; while(i<=length(Y)); 
            if (j>length(B)); Y(i,r+2)=max(Y(:,r+2)); i=i+1; 
            elseif(Y(i,2)==B(j,4)); r=B(j,2); Y(i,r+2)=max(Y(:,r+2))+B(j,5); j=j+1; 
            elseif(Y(i,2)<B(j,4));  i=i+B(j,4)-Y(i,2); end; end;  
        k=1; while(k<=max(B(:,2))); i=1; 
            while (i<=length(Y)); Y(i,k+2)=max(Y(1:i,k+2)); i=i+1;  end; k=k+1; end;
        YPaC = transpose([transpose(YPaC) transpose(Y)]); m=m+1; end; % Create a single master list of all counts
        i=1; while(i<=length(YPaC)); YPaC(i,end)=sum(YPaC(i,3:end-1)); i=i+1; end; % Sum all the counts in the end column 
        YPaCn=YPaC; i=1; while(i<=length(YPaC)); YPaCn(i,3:end-1)=YPaCn(i,3:end-1)./YPaCn(i,end); i=i+1; end; YPaCn = YPaCn(:,1:end-1); % Normalize the counts to 1

%CDC data on the incidence count for each disease 
YIC=[]; YICn=[]; m=1; while(m<=max(CDC(:,1))); B=CDC; B=B(B(:,1)==m,:); B=[ B(:,1:2) B(:,14:17) zeros(length(B(:,1)),1)]; Bn=B;
    i=1; while(i<=length(Bn)); Bn(i,end)=sum(Bn(i,3:end));  i=i+1; end; % Sum all the incidence counts 
    i=1; while(i<=length(Bn)); Bn(i,3:end)=Bn(i,3:end)./Bn(i,end); i=i+1; end; %Calculate the proportion of incidence count for each demographic
    Y=zeros(100,6); Y(:,1)= m*ones(length(Y),1);  Y(:,2)= [1950:1:2049]; Yn=Y;
        i=1; j=1; while(i<=length(Y)); if(j>length(B)); Y(i,3:end)=zeros(1,length(Y(i,3:end))); i=i+1; 
        elseif(Y(i,2)==B(j,2)); Y(i,3:6)=B(j,3:6); i=i+1; j=j+1; elseif(Y(i,2)<B(j,2)); i=i+B(j,2)-Y(i,2); end; end; 
        YIC  =transpose([transpose(YIC) transpose(Y)]); 
        i=1; j=1; while(i<=length(Yn)); if(j>length(Bn)); Y(i,3:end)=zeros(1,length(Yn(i,3:end))); i=i+1; 
        elseif(Yn(i,2)==Bn(j,2)); Yn(i,3:6)=Bn(j,3:6); i=i+1; j=j+1; elseif(Yn(i,2)<Bn(j,2)); i=i+Bn(j,2)-Y(i,2); end; end; 
        YICn  =transpose([transpose(YICn) transpose(Yn)]); 
    m=m+1; end;

%CDC data on the death count for each disease 
YDC=[]; YDCn=[]; m=1; while(m<=max(CDC(:,1))); B=CDC; B=B(B(:,1)==m,:); B=[ B(:,1:2) B(:,19:22) zeros(length(B(:,1)),1)]; Bn=B;
    i=1; while(i<=length(Bn)); Bn(i,end)=sum(Bn(i,3:end));  i=i+1; end; % Sum all the incidence counts 
    i=1; while(i<=length(Bn)); Bn(i,3:end)=Bn(i,3:end)./Bn(i,end); i=i+1; end; %Calculate the proportion of incidence count for each demographic
    Y=zeros(100,6); Y(:,1)= m*ones(length(Y),1);  Y(:,2)= [1950:1:2049]; Yn=Y;
        i=1; j=1; while(i<=length(Y)); if(j>length(B)); Y(i,3:end)=zeros(1,length(Y(i,3:end))); i=i+1; 
        elseif(Y(i,2)==B(j,2)); Y(i,3:6)=B(j,3:6); i=i+1; j=j+1; elseif(Y(i,2)<B(j,2)); i=i+B(j,2)-Y(i,2); end; end; 
        YDC  =transpose([transpose(YDC) transpose(Y)]); 
        i=1; j=1; while(i<=length(Yn)); if(j>length(Bn)); Y(i,3:end)=zeros(1,length(Yn(i,3:end))); i=i+1; 
        elseif(Yn(i,2)==Bn(j,2)); Yn(i,3:6)=Bn(j,3:6); i=i+1; j=j+1; elseif(Yn(i,2)<Bn(j,2)); i=i+Bn(j,2)-Y(i,2); end; end; 
        YDCn  =transpose([transpose(YDCn) transpose(Yn)]); 
    m=m+1; end;

j=min(CL(:,4)); while(j<=2016); close all;
labels = [{'Asian','Black','Hispanic','White','Unspecified' }];  labelsi =[{'Unspecified','White','Hispanic','Black','Asian' }]; 

f1 = figure; s1=2; s2=3; si=0; y = zeros(max(CL(:,2)),1);
%Cell Line Timeline
si=si+1; subplot(s1, s2, si); hold on; Y1=YCL(YCL(:,2)<=j,:); Y1=Y1(Y1(:,1)==2,:); 
i=1; while i<=max(CL(:,2)); sc1 = scatter(Y1(:,2),Y1(:,2+i),5*R); sc1.MarkerFaceColor=c2(i,:); sc1.MarkerEdgeColor=c3(i,:); i=i+1;  end; 
ylabel({'# of Cell Lines'}); ylim([.5 40]); set(gca,'YTick',[0:5:50]); 
xlabel({'Year Cell Line was Established'}); xlim([1950 2020]); set(gca,'XTick',[1950:10:2020]);
title({ num2str(sum(Y1(end,3:end-1))), 'Breast Cancer Human Cell Lines' }); box on; set(gca,'fontsize',R); hold off; 

%Pie Chart for Cell Lines by Demographic
si=si+1; subplot(s1, s2, si);  Z=[]; set(gca,'fontsize',R); Z = Y1(end,3:end-1);
if(sum(Z)==0); p1 = pie([1], ({' '})); hp = findobj(p1, 'Type', 'patch'); set(hp(1), 'FaceColor', 'w');
else p1 = pie(Z, 0*ones(5,1), labels); hp = findobj(p1, 'Type', 'patch');  i=1; k=1; while(i<=length(hp)); if(Z(k)>0); set(hp(i), 'FaceColor', c2(k,:)); i=i+1; end; k=k+1; end; end;
title({num2str(j), 'Cell Line Proportion'}); 

% Figure Stacked Bars for Cell Line Count
si = si+1; subplot(s1, s2, si); hold on; box on; grid off; set(gca,'fontsize',R); Y=YCLn(YCLn(:,1)==2,:); Y=Y(Y(:,2)<=j,:); 
b1 = barh(Y(:,2),Y(:,3:end),'Stacked','BarWidth',w); view([90 270]);
i=1; while(i<=5); b1(:,i).FaceColor = c2(i,:); b1(:,i).EdgeColor = c2(i,:);  i=i+1; end; 
ylabel({'Year'}); ylim([1950 2020]); set(gca,'YTick',[1950:10:2020]); 
xlabel({'Proportions'}); xlim([0 1.01]);  set(gca,'XTick',[-1:.1:1]); 
title({'Demographic Proportions', 'in the Cell Line Catalog'}); box on; hold off;

%Publication 
si=si+1; subplot(s1, s2, si); hold on; Ytemp=YPC(YPC(:,2)==j,:); Ytemp=Ytemp(Ytemp(:,1)==2,:);
Ytemp = [0 Ytemp(1,2) (Ytemp(:,3:end))]; Ytemp = Ytemp(:,1:end-1); Y1P(j-min(CL(:,4))+1,:) = Ytemp;
i=1; while(i<=max(CL(:,2))); sc1 = scatter(Y1P(:,2),Y1P(:,i+2),5*R); sc1.MarkerFaceColor=c2(i,:); sc1.MarkerEdgeColor=c3(i,:);i=i+1;  end; 
ylabel({'# of Publications'}); ylim([0 5E5]); set(gca,'YTick',[1E0 5E0 1E1 5E1 1E2 5E2 1E3 5E3 1E4 5E4 1E5 5E5 1E6]); set(gca,'yscale','log');
xlabel({'Year'}); xlim([1950 2020]); set(gca,'XTick',[0:10:3000]);
title({ num2str(sum(Y1P(end,3:end))), 'Medline/Scopus Publications','citing Breast Cell Lines'}); box on; set(gca,'fontsize',R); box on; hold off;

%Pie Chart for Publications by Demographic
Ytemp=YPC(YPC(:,2)==j,:); Ytemp=Ytemp(Ytemp(:,1)==2,:); Ytemp = [0 Ytemp(1,2) (Ytemp(:,3:end))]; Ytemp = Ytemp(:,1:end-1); Y1P(j-min(CL(:,4))+1,:) = Ytemp;
si=si+1; subplot(s1, s2, si);  Z=[]; set(gca,'fontsize',R); Z = max(Y1P(:,3:end)); 
if Z==0; p1 = pie([1], ({' '})); hp = findobj(p1, 'Type', 'patch'); set(hp(1), 'FaceColor', 'w');
else p1 = pie(Z, 0*ones(5,1), {' ',' ',' ', ' ', ' '}); hp = findobj(p1, 'Type', 'patch');  i=1; k=1; while(i<=length(hp)); if(Z(k)>0); set(hp(i), 'FaceColor', c2(k,:)); i=i+1; end; k=k+1; end; end;
title({num2str(j), 'Publication Proportion'}); 

% Figure Stacked Bars for Publication Count
si = si+1; subplot(s1, s2, si); hold on; grid off; set(gca,'fontsize',R);
Y=YPCn(YPCn(:,1)==2,:); Y=Y(Y(:,2)<=j,:); 
b1 = barh(Y(:,2),Y(:,3:end),'Stacked','BarWidth',w); view([90 270]);
i=1; while(i<=5); b1(:,i).FaceColor = c2(i,:); b1(:,i).EdgeColor = c2(i,:); i=i+1; end; 
ylabel({'Year'}); ylim([1950 2020]); set(gca,'YTick',[1950:10:2020]); 
xlabel({'Proportions'}); xlim([0 1.01]);  set(gca,'XTick',[-1:.1:1]); 
title({'Demographic Proportions', 'in the Publication Record'}); box on; hold off; 

AR = 9/16; %9/16 is youtube aspect ratio
size = 900; set(f1, 'Position', [0 0 size AR*size]);
savedir=strcat('Cell_Line_Time_Lapse_BC'); mkdir(savedir);
newname=[savedir '/' num2str(j) 'cell_line.jpg'];
print(f1, newname, '-djpeg', '-r300') 

j=j+30; end; 









