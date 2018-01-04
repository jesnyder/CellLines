%Reformat csv to present the 

function  CVSFunction(a,b,x)

% Read in the csv
B = csvread(a, 1, 0);

% Truncate for cancer type, remove gender and cancer index columns
B = B(B(:,3) == x,:);  B=[B(:,2) B(:,4:5)];

% Populate a matrix with counts per year for each ethniciy
% Column heading ethnicities, First rows is each year
i = min(B(:,2)); A = [];
while(i <= max(B(:,2)))
    
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
        
    end
    
    i=i+1; 
    
end

A = A(min(B(:,2)):end,:); 

header = {'Year','Asian','Black','Hispanic','White','Unknown'};

% Create a table, then sort
R = array2table([header; num2cell(A)]) ;
R = [R(:,1),R(:,5),R(:,6),R(:,3),R(:,2),R(:,4)]; 

% Write the table to a csv
writetable(R,b,'Delimiter',',');

end


