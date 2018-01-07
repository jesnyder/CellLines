clear all; clc; close all; 

a = char(string('Originals/v01_PaCo.csv'));
b = char(string('Originals/v01_PuCo.csv')); 
c = char(string('Originals/v01_CDC.csv')); 

% List cancer types surveyed
z = char(string(['BC';'PC';'LC']));

% Delete and make folders for each cancer type listed in z
i = 1; while(i <= length(z(:,1))) rmdir((z(i,:)),'s');  mkdir((z(i,:))); i=i+1; end

i = 2;  %Breast Cancer
ym = 2002; while(ym < 2009)   
    Y=[]; fol = string(z(i-1,:));
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_IC.csv')),i,3, ym); Y=[y];
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_DC.csv')),i,4, ym); Y=[Y; y];
    y = CSVFunction(b,char(strcat(fol,'/v', fol,'_PubCount.csv')),i, ym); Y=[Y; y];
    y = CSVFunction(a,char(strcat(fol,'/v', fol,'_PatCount.csv')),i, ym); Y=[Y; y];

    if(ym == 2002) Y1 = Y; end
    if(ym == 2008) Y2 = Y; bargraph(Y1,Y2, 'Breast Cancer',fol); end
    ym = ym + 6; 
end

YBC = [Y1; Y2]

i = 3; %Breast Cancer
ym = 2002; while(ym < 2009)
    Y=[]; fol = string(z(i-1,:));
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_IC.csv')),i,3, ym); Y=[y];
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_DC.csv')),i,4, ym); Y=[Y; y];
    y = CSVFunction(b,char(strcat(fol,'/v', fol,'_PubCount.csv')),i, ym); Y=[Y; y];
    y = CSVFunction(a,char(strcat(fol,'/v', fol,'_PatCount.csv')),i, ym); Y=[Y; y];

    if(ym == 2002) Y1 = Y; end
    if(ym == 2008) Y2 = Y; bargraph(Y1,Y2, 'Prostate Cancer',fol); end
    ym = ym + 6; 
end

i = 4; %Lung Cancer
ym = 2002; while(ym < 2009)    
    Y=[]; fol = string(z(i-1,:));
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_IC.csv')),i,3, ym); Y=[y];
    y = CSVCDCFunction(c,char(strcat(fol,'/v', fol,'_CDC_DC.csv')),i,4, ym); Y=[Y; y];
    y = CSVFunction(b,char(strcat(fol,'/v', fol,'_PubCount.csv')),i, ym); Y=[Y; y];
    y = CSVFunction(a,char(strcat(fol,'/v', fol,'_PatCount.csv')),i, ym); Y=[Y; y];

    if(ym == 2002) Y1 = Y; end
    if(ym == 2008) Y2 = Y; bargraph(Y1,Y2, 'Lung Cancer',fol); end
    ym = ym + 6; 
end