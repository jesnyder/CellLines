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
