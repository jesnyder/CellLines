close all; clc; clearvars; 

% CDC Statistics https://nccd.cdc.gov/uscs/cancersbyraceandethnicity.aspx
% Convert all CDC .txt data to .csv

% CDC Incidence Rate
mypath = 'CDC/Breast/'; filename = 'Table 1.1.1.1MF ';
data = importdata(['CDC/Breast/',filename,'.txt']);
csvwrite([mypath, filename, '.csv'],data.data); 
CDC = csvread([mypath,filename, '.csv' ], 0, 2); CDC(1,1)

CDCMF = [CDC]; j=1; while(j<=14); 
mypath = 'CDC/Breast/';  filename = sprintf('Table 1.1.1.1MF (%d)', j);
data = importdata([mypath,filename,'.txt']);
csvwrite([mypath, filename, '.csv'],data.data); 
CDC = csvread([mypath,filename, '.csv' ], 0, 2); CDCMF = [CDCMF ; CDC]; 
j=j+1; end; CDCMF = [2*ones(length(CDCMF(:,1)),1) CDCMF]; CDCMF(:,1:2)








