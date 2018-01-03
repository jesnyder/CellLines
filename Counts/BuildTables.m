clear all
clc

%% Breast Cancer
PatCount = csvread('Originals/v01_PaCo.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:); A = [A(:,1), transpose(sortrows(transpose(A(:,2:end)),-2))]
csvwrite('BC/vBC_PatCount.csv',A)

PatCount = csvread('Originals/v01_PuCo.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:); A = [A(:,1), transpose(sortrows(transpose(A(:,2:end)),-2))]
csvwrite('BC/vBC_PubCount.csv',A)

%% Prostate Cancer
PatCount = csvread('Originals/v01_PaCo.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:); A = [A(:,1), transpose(sortrows(transpose(A(:,2:end)),-2))]
csvwrite('PC/vPC_PatCount.csv',A)

PatCount = csvread('Originals/v01_PuCo.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:); A = [A(:,1), transpose(sortrows(transpose(A(:,2:end)),-2))]
csvwrite('PC/vPC_PubCount.csv',A)
