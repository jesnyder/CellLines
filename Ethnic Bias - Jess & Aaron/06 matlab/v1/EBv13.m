clc; clearvars; R=14; w=1; c1 = 0*ones(6,3); c2 = [ 0  .6 .6 ; .6 1 .6 ; .6 .6  1 ;1 .6 .6 ;  .8 .8 .8 ; .9 .9 .9]; c3 = 1*c2; c4 = 1*c3; c5= 1*c4; c1=c2;
% Read in CDC Statistics Source: "CDC" Tab of the following url: https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1065966572
CDC = csvread('CDC.csv', 4, 0); % Read Cell Line Descriptions
% Read in Cell Line Descriptions Source: CellLines Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=881362172
CL = csvread('CellLines.csv',1,1,[1, 2, 372, 5]); CL=CL(CL(:,4)>0,:); CL=CL(CL(:,5)<1,:); CL=CL(:,1:4); CL = sortrows(CL,4); % Read Cell Line Descriptions. Remove all unknown years, remove any cell lines known to have contaminants, and sort by year the cell line was introduced 
% Read in Publicaion Count Source: PubCount Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1444937265
PC = csvread('PubCount.csv',1,0); PC = sortrows(PC,4); % Read Cell Line Descriptions. Remove all unknown years and sort by year the cell line was introduced 

%Count the number of cell for each demographic, for each year, for each type of cancer.
YCL = []; m=1; while(m<=max(CL(:,3))); B=CL(CL(:,2)<5,:); 
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
YPC = []; m=1; while(m<=max(PC(:,3))); B=PC(PC(:,2)<5,:); 
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
        
%Figure of cell count statistics        
w=.8; f1 = figure; s1=2; s2=4; si=0; 
    z = 1; while(si<7); si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YCL(YCL(:,1)==z,:); Y=Y(:,1:end-1);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Cell Line Count'}); hold off; set(gca,'xscale','log');  xlim([0 1.2*sum(Y(end,3:end))]); set(gca,'XTick',[0 1 2 4 8 16 32 60 120 250 500 1000 2000 4000 8000 15000 30000 60000 120000 240000  ]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; hold off;

        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YCLn(YCLn(:,1)==z,:);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Cell Line Count'}); hold off;  xlim([0 1.05*sum(Y(end,3:end))]); set(gca,'XTick',[0:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        if(z==1); legend('Asian','Black','Hispanic','Caucasian','Location','SouthEast','Orientation','Horizontal'); end;
    z=z+1; hold off; end;

%Figure of publication statistics 
w=.8; f2 = figure; s1=2; s2=3; si=0; 
    z = 1; while(si<5); si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YPC(YPC(:,1)==z,:); Y=Y(:,1:end-1);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Publication Count'}); hold off; set(gca,'xscale','log'); 
        xlim([0 1.2*sum(Y(end,3:end))]); 
        set(gca,'XTick',[0 1 2 4 8 16 32 60 120 250 500 1000 2000 4000 8000 15000 30000 60000 120000 240000  ]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; hold off; 

        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YPCn(YPCn(:,1)==z,:); 
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Publication Count'}); hold off; xlim([0 1.05*sum(Y(end,3:end))]); set(gca,'XTick',[0:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        if(si==2); legend('Asian','Black','Hispanic','Caucasian','Location','NorthWest','Orientation','Vertical'); end;
    z=z+1; hold off; end;

%Figure of publication - cell line statistics 
w=.8; f2 = figure; s1=2; s2=2; si=0; 
z = 1; while(si<3); si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y1=YPCn(YPCn(:,1)==z,:); Y2=YCLn(YCLn(:,1)==z,:); Y = [Y1(:,1:2) Y1(:,3:end)-Y2(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1970 2016]); set(gca,'YTick',[1950:5:2020]); 
        xlabel({'Publication-Cell Line'}); xlim([-.5 .5]);  set(gca,'XTick',[-1:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; hold off; 
    z=z+1; end;

%Figure of CDC Incidence Counts 
w=.8; f3 = figure; s1=2; s2=5; si=0; 
z = 2; while(si<9); si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YIC(YIC(:,1)==z,:); Y=Y(:,1:end);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998 2013]); set(gca,'YTick',[1998:4:2020]); 
        xlabel({'Total Incidence Count'}); hold off;  xlim([0 1.3*max(Y(:,end))]); set(gca,'XTick',1E5*[0:1:10]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
   
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YDC(YDC(:,1)==z,:); Y=Y(:,1:end);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998 2013]); set(gca,'YTick',[1998:4:2020]); 
        xlabel({'Total Death Count'}); hold off;  xlim([0 1.3*max(Y(:,end))]); set(gca,'XTick',1E4*[0:1:10]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YICn(YICn(:,1)==z,:); 
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998 2013]); set(gca,'YTick',[1998:4:2020]); 
        xlabel({'Proportional Incidence Count'}); hold off; xlim([0 1.05]); set(gca,'XTick',[0:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;

        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YDCn(YDCn(:,1)==z,:); 
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998 2013]); set(gca,'YTick',[1998:4:2020]); 
        xlabel({'Proportional Death Count'}); hold off; xlim([0 1.05]); set(gca,'XTick',[0:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
    
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YIC1=YICn(YICn(:,1)==z,:);  YDC1=YDCn(YDCn(:,1)==z,:); Y = [YIC1(:,1:2) -YIC1(:,3:end)+YDC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2013]); set(gca,'YTick',[1950:4:2020]); 
        xlabel({'Death - Incidence Count'}); hold off;  xlim(1*[-.1 .1]); set(gca,'XTick',[-1:.02:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
        elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        legend('Asian','Black','Hispanic','Caucasian','Location','SouthEast','Orientation','Vertical'); 
        
  z=z+1; hold off; end;
    
%Figure of CDC Incidence Counts 
w=.8; f4 = figure; s1=2; s2=4; si=0; 
z = 2; while(si<8); 
    
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YIC1=YICn(YICn(:,1)==z,:);  YDC1=YDCn(YDCn(:,1)==z,:); Y = [YIC1(:,1:2) YIC1(:,3:end)-YDC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2013]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Incidence - Death Count'}); hold off;  xlim(.8*[-.1 .1]); set(gca,'XTick',[-1:.02:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
    
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YPC1=YPCn(YPCn(:,1)==z,:);  YCL1=YCLn(YCLn(:,1)==z,:); Y = [YPC1(:,1:2) YPC1(:,3:end)-YCL1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2013]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Publication - Cell Count'}); hold off;  xlim([-.4 .4]); set(gca,'XTick',[-1:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;

        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YPC1=YPCn(YPCn(:,1)==z,:);  YIC1=YICn(YICn(:,1)==z,:); Y = [YPC1(:,1:2) YPC1(:,3:end)-YIC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2013]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Publication - Incidence Count'}); hold off;  xlim([-.4 .4]); set(gca,'XTick',[-1:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;

        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YPC1=YPCn(YPCn(:,1)==z,:);  YDC1=YDCn(YDCn(:,1)==z,:); Y = [YPC1(:,1:2) YPC1(:,3:end)-YDC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2013]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Publication - Death Count'}); hold off;  xlim([-.4 .4]); set(gca,'XTick',[-1:.1:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        legend('Asian','Black','Hispanic','Caucasian','Location','SouthWest','Orientation','Vertical'); 
        
  z=z+1; hold off; end;

%Figure of CDC Incidence Counts - Deah Counts 
w=.8; f5 = figure; s1=3; s2=3; si=0; 
z = 1; while(si<8); 
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YIC1=YICn(YICn(:,1)==z,:);  YDC1=YDCn(YDCn(:,1)==z,:); Y = [YIC1(:,1:2) YIC1(:,3:end)-YDC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2012.6]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Incidence - Death Count'}); hold off;  xlim([-.05 .04]); set(gca,'XTick',[-1:.01:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; box on; hold off; 
        %legend('Asian','Black','Hispanic','Caucasian','Location','SouthWest','Orientation','Vertical'); 
        
        si = si+1; subplot(s1, s2, si); hold on; grid on; set(gca,'fontsize',R);
        YPC1=YPCn(YPCn(:,1)==z,:);  YIC1=YICn(YICn(:,1)==z,:); Y = [YPC1(:,1:2) YPC1(:,3:end)-YIC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2012.6]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Publication - Incidence Count'}); hold off;  xlim([-.2 .25]); set(gca,'XTick',[-1:.05:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; box on; hold off;
        %legend('Asian','Black','Hispanic','Caucasian','Location','SouthWest','Orientation','Vertical'); 
        
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        YPC1=YPCn(YPCn(:,1)==z,:);  YDC1=YDCn(YDCn(:,1)==z,:); Y = [YPC1(:,1:2) YPC1(:,3:end)-YDC1(:,3:end)];
        b1 = barh(Y(:,2),Y(:,3:end),'BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1998.8 2012.6]); set(gca,'YTick',[1950:2:2020]); 
        xlabel({'Publication - Death Count'}); hold off;  xlim([-.2 .25]); set(gca,'XTick',[-1:.05:1]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end; box on; hold off; 
        %legend('Asian','Black','Hispanic','Caucasian','Location','SouthWest','Orientation','Vertical'); 
z=z+1; end;

%Figure of publication statistics 
w=.8; f4 = figure; s1=3; s2=2; si=0; 
    z = 1; while(si<5); si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YPC(YPC(:,1)==z,:); Y=Y(:,1:end-1);
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Publication Count'}); hold off; set(gca,'xscale','log'); xlim([0 1.2*sum(Y(end,3:end))]); set(gca,'XTick',[0 1 2 4 8 16 32 60 120 250 500 1000 2000 4000 8000 15000 30000 60000 120000 240000  ]); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;  
        legend('Asian','Black','Hispanic','Caucasian','Location','NorthWest','Orientation','Vertical'); hold off;
        
        si = si+1; subplot(s1, s2, si); hold on; box on; grid on; set(gca,'fontsize',R);
        Y=YPCn(YPCn(:,1)==z,:); 
        b1 = barh(Y(:,2),Y(:,3:end),'stacked','BarWidth',w); view([90 270]);
        i=1; while(i<5); b1(:,i).FaceColor = c4(i,:); b1(:,i).EdgeColor = c1(i,:); i=i+1; end; 
        ylabel({'Year'}); ylim([1950 2016]); set(gca,'YTick',[1950:10:2020]); 
        xlabel({'Publication Count'}); hold off; xlim([0 1.05*sum(Y(end,3:end))]); set(gca,'XTick',[0 .001 .01 .1 1]); set(gca,'xscale','log'); 
        if(z==1); title({'General'}); elseif(z==2); title({'Breast Cancer'}); elseif(z==3); title({'Prostate Cancer'}); 
            elseif(z==4); title({'Lung Cancer'});  elseif(z==5); title({'Leukemia/Lymphoma Cancer'}); end;
        legend('Asian','Black','Hispanic','Caucasian','Location','NorthWest','Orientation','Vertical'); hold off; 
    z=z+1; end;