

function  CVSCDCFunction(a, b, x, y)

%Read in breast cancer statistics
B = csvread(a, 1, 0) 

%Remove the disease index and metric index
B=B(B(:,1) == x,:); B=B(B(:,2) == y,:); B = B(:,3:end);

A = B;

A = [A(:,1), transpose(sortrows(transpose(A(:,2:end)),-2))]

header = {'Year','All','White','Black','Asian','Hispanic', 'Native American'};

b 


writetable(array2table([header; num2cell(A)]),b,'Delimiter',',')


 

end


