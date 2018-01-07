
clear all; clc; close all; 

legs = {'White','Black','Asian','Hispanic','Native American'};

a = char(string('Originals/v01_CellLineSum.csv'));


% Edit the data to only include ethnicity and donor year
B = csvread(a, 1, 0); B(:,1:2)=[]; B(:,2:3)=[];  B(:,end) = []; %B=B(B(:,2) > 0,:);


i = 1960; Y = []; while(i <= max(B(:,2))) Y(i,1) = i;
j = 1; while(j<=5) C=B(B(:,2) <= i,:); C=C(C(:,1) == j,:);  Y(i,j+1) = length(C(:,2)); j=j+1; end
i = i+1; end;


% Trim off years before first cell line
Y = Y(Y(:,1) >= 1960,:)



Y = [Y(:,1), Y(:,6), Y(:,3), Y(:,4), Y(:,2), Y(:,5)]

f1 = figure; 

bar(Y(:,2:end), 1,'stacked')
set(gca,'xticklabel',Y(:,1))
ylabel('No. of Availale Cell Lines'); xlabel('Year'); xticks([2 12 22 32 42 52]); xticklabels([1960 1970 1980 1990 2000 2010]); 
legend(legs, 'Location','NorthWest');

set(f1, 'Position', [0 0 500 300])

filename = char(strcat('CellLines.jpg'));
saveas(f1, sprintf(filename));