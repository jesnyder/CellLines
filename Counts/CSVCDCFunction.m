function  y = CVSCDCFunction(a, b, x, y, yearmin)

%Read in breast cancer statistics
B = csvread(a, 1, 0);

%Remove the disease index and metric index
B=B(B(:,1) == x,:); B=B(B(:,2) == y,:); B = B(:,3:end);

% Remove "All" Column, now 6 columes total
B(:,2) = [];

% Add a header, convert to a table 
header = {'Year','White','Black','Asian','Hispanic', 'Native American'};
writetable(array2table([header; num2cell(B)]),b,'Delimiter',',')

% Calculate the representative fractions over a multiyear interval
y = sumyearsfunc(B, yearmin);


end


