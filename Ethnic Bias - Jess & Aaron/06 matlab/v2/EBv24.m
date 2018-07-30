close all; 
clc; clearvars; R=15; w=1; c1 = 0*ones(5,3); c2=[.5 .5 .5 ; 1 0 0; 0 0 1; .9 .9 .9; .8 .8 .8; .8 .8 .8; .8 .8 .8]; c3=.7*c2; 
% Read in CDC Statistics Source: "CDC" Tab of the following url: https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1065966572
CDC = csvread('CDC.csv', 4, 0);
% Read in Cell Line Descriptions Source: CellLines Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=881362172
CL = csvread('CellLines.csv',1,1,[1,1,372,8]); CL=CL(CL(:,4)>0,:); CL=CL(CL(:,6)<1,:); CL=CL(:,1:end);  CL = sortrows(CL,4); % Read Cell Line Descriptions. Remove all unknown years, remove any cell lines known to have contaminants, and sort by year the cell line was introduced 
% Read in Publicaion Count Source: PubCount Tab of https://docs.google.com/spreadsheets/d/1a-dC9FWy7CtdIPT_bIi9YbC0zcmLltPo5K3T5Zykkg8/edit#gid=1444937265
PC = csvread('PubCount.csv',1,0); PC = sortrows(PC,4); % Read Publication Records. Remove all unknown years and sort by year the cell line was introduced 
PaC = csvread('PatentCount.csv',1,0); PaC = sortrows(PaC,4); % Read Patent Record. Remove all unknown years and sort by year the cell line was introduced 
PaCo = csvread('PatentALL.csv',1,0); PaCo = sortrows(PaCo,-2 ); PaCo=PaCo(PaCo(:,1)>0,:); % Read Patent Count for Each Cell Line. Remove all unknown years and sort by year the cell line was introduced 
z=2; % 2  = Breast Cancer Specific
labels = [{'Asian','Black','Hispanic','White','Unspecified' }];  
labelsb = [{' ',' ',' ',' ',' ' }];  

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
        
%Count the number of patents citing the cell lines for each demographic, for each year, for each type of cancer.
YPaC = []; m=1; while(m<=max(PaC(:,3))); B=PaC(PaC(:,2)<5,:); 
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

close all; c=[.2 .2 .2; 1 0 0; 0 0 1 ; .5 .9 .5; .9 .9 .3; .5 .5 1; 1 1 0]; 
f1 = figure; s1=2; s2=2; si=0; 

%Cancer CDF
z=1; Z=[]; while(z<=s1*s2); 
si=si+1; subplot(s1, s2, si); hold on;  grid off; set(gca,'fontsize',R);
f=[];  i=1; t=1; j=1; if(z>1); A=CL(CL(:,3)==z,:); A=A(:,end); else; A=CL(:,end); end; A=A(A(:,1)>1,:); M = [max(A) length(A) std(A)]; Z=[Z std(A)];
while(i<=max(A)); A1=A(A(:,1)<(i),:); f(j,2)=length(A1); f(j,1)=i; i=i+t; j=j+1; end;
h=plot(f(:,1),f(:,2)); h.Color = c(z,:); 
f=[];  i=1; t=1; j=1; if(z>1); A=CL(CL(:,3)==z,:); A=A(:,end-1); else; A=CL(:,end-1); end; A=A(A(:,1)>1,:); M = [M; max(A) length(A) std(A)]; Z=[Z std(A)];
while(i<=max(A)); A1=A(A(:,1)<(i),:); f(j,2)=length(A1); f(j,1)=i; i=i+t; j=j+1; end;
h=plot(f(:,1),f(:,2),'--'); h.Color = c(z,:); 
if(z==1);  title({ 'CDF of General Cancer','Cell Lines Citations'}); legend('Cancer Publications','Cancer Patents','Location','SouthEast','Orientation','Vertical'); 
elseif(z==2); title({ 'CDF of Breast Cancer','Cell Lines Citations'}); legend('Breast Publications','Breast Patents','Location','SouthEast','Orientation','Vertical'); 
elseif(z==3); title({ 'CDF of Prostate Cancer','Cell Lines Citations'}); legend('Prostate Publications','Prostate Patents','Location','SouthEast','Orientation','Vertical'); 
elseif(z==4); title({ 'CDF of Lung Cancer','Cell Lines Citations'}); legend('Lung Publications','Lung Patents','Location','SouthEast','Orientation','Vertical'); 
end; 
ylabel({num2str(max(M(:,2))), 'Total Cell Lines'}); 
%xlabel({num2str((M(1,1))); 'Total Publications'; num2str((M(2,1))); 'Total Patents' }); 
xlabel({'Number of Publications/Patents Citations' }); 
box on; grid off; hold off; 
set(gca,'XTick',[1E1 1E2 1E3 1E4 1E5 1E6]); xlim([0 2*max(M(:,1))]); ylim([0 max(M(:,2))*1.05]);  set(gca,'xscale','log'); 
z=z+1; end;

AR =1; %9/16 is youtube aspect ratio
size = 1100; set(f1, 'Position', [0 0 size AR*size]);
savedir=strcat('Diversity of Cell Line Useage'); mkdir(savedir);
newname=[savedir '/' ,'CDF.jpg'];
print(f1, newname, '-djpeg', '-r600') 

