clear all; clc; close all; 

a = char(string('Originals/v01_PaCo.csv'));
b = char(string('Originals/v01_PuCo.csv')); 
c = char(string('Originals/v01_CDC.csv')); 

z = char(string(['BC';'PC';'LC']));

i = 1; 
while(i <= length(z(:,1)))  
    rmdir((z(i,:)),'s');  
    mkdir((z(i,:)));
    i=i+1;
end

i = 2; %Breast Cancer
ym = 2002; Y=[]; 
y = CSVCDCFunction(c,char(string('BC/vBC_CDC_IC.csv')),i,3, ym); Y=[y]; 
y = CSVCDCFunction(c,char(string('BC/vBC_CDC_DC.csv')),i,4, ym); Y=[Y; y];
y = CSVFunction(a,char(string('BC/vBC_PatCount.csv')),i, ym); Y=[Y; y];
y = CSVFunction(b,char(string('BC/vBC_PubCount.csv')),i, ym); Y=[Y; y];
Y1 = Y; 

ym = 2008; Y=[]; 
y = CSVCDCFunction(c,char(string('BC/vBC_CDC_IC.csv')),i,3, ym); Y=[y]; 
y = CSVCDCFunction(c,char(string('BC/vBC_CDC_DC.csv')),i,4, ym); Y=[Y; y];
y = CSVFunction(a,char(string('BC/vBC_PatCount.csv')),i, ym); Y=[Y; y];
y = CSVFunction(b,char(string('BC/vBC_PubCount.csv')),i, ym); Y=[Y; y];
Y2 = Y;
bargraph(Y1,Y2, 'Breast Cancer')

i = 3; %Prostate Cancer
ym = 2002; Y=[];
y = CSVCDCFunction(c,char(string('PC/vPC_CDC_IC.csv')),i,3, ym); Y=[y];
y = CSVCDCFunction(c,char(string('PC/vPC_CDC_DC.csv')),i,4, ym); Y=[Y; y];
y = CSVFunction(a,char(string('PC/vPC_PatCount.csv')),i, ym); Y=[Y; y];
y = CSVFunction(b,char(string('PC/vPC_PubCount.csv')),i, ym); Y=[Y; y];
%Y1 = Y; 

ym = 2008; Y=[];
y = CSVCDCFunction(c,char(string('PC/vPC_CDC_IC.csv')),i,3, ym); Y=[y];
y = CSVCDCFunction(c,char(string('PC/vPC_CDC_DC.csv')),i,4, ym); Y=[Y; y];
y = CSVFunction(a,char(string('PC/vPC_PatCount.csv')),i, ym); Y=[Y; y];
y = CSVFunction(b,char(string('PC/vPC_PubCount.csv')),i, ym); Y=[Y; y];
%Y2 = Y;
%bargraph(Y1,Y2, 'Prostate Cancer')


i = 4; %Lung Cancer
y = CSVCDCFunction(c,char(string('LC/vLC_CDC_IC.csv')),i,3, ym);
y = CSVCDCFunction(c,char(string('LC/vLC_CDC_DC.csv')),i,4, ym);
y = CSVFunction(a,char(string('LC/vLC_PatCount.csv')),i, ym);
y = CSVFunction(b,char(string('LC/vLC_PubCount.csv')),i, ym);







