clear all; clc; close all; 

a = char(string('Originals/v01_PaCo.csv'));
b = char(string('Originals/v01_PuCo.csv')); 
c = char(string('Originals/v01_CDC.csv')); 

z = char(string(['BC';'PC';'LC']));

i = 1; while(i < length(z(:,1)))  
    rmdir((z(i,:)),'s');  
    mkdir((z(i,:)));
    i=i+1;
end

i = 2; %Breast Cancer
CSVFunction(a,char(string('BC/vBC_PatCount.csv')),i);
CSVFunction(b,char(string('BC/vBC_PubCount.csv')),i);
CSVCDCFunction(c,char(string('BC/vBC_CDC_IC.csv')),i,3);
CSVCDCFunction(c,char(string('BC/vBC_CDC_DC.csv')),i,4);

i = 3; %Prostate Cancer
CSVFunction(a,char(string('PC/vPC_PatCount.csv')),i);
CSVFunction(b,char(string('PC/vPC_PubCount.csv')),i);
CSVCDCFunction(c,char(string('PC/vPC_CDC_IC.csv')),i,3);
CSVCDCFunction(c,char(string('PC/vPC_CDC_DC.csv')),i,4);

i = 4; %Lung Cancer
CSVFunction(a,char(string('LC/vLC_PatCount.csv')),i);
CSVFunction(b,char(string('LC/vLC_PubCount.csv')),i);
CSVCDCFunction(c,char(string('LC/vLC_CDC_IC.csv')),i,3);
CSVCDCFunction(c,char(string('LC/vLC_CDC_DC.csv')),i,4);


