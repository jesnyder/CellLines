clear all
clc

%% Breast Cancer
PatCount = csvread('PatCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PatCount_BC.csv',A)


PatCount = csvread('PubCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 2,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PubCount_BC.csv',A)


%% Prostate Cancer 
PatCount = csvread('PatCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 3,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PatCount_PC.csv',A)


PatCount = csvread('PubCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 3,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PubCount_PC.csv',A)


%% Lung Cancer 
PatCount = csvread('PatCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 4,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PatCount_LC.csv',A)


PatCount = csvread('PubCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=B(B(:,3) == 4,:);  B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PubCount_LC.csv',A)

%% All Cancer 
PatCount = csvread('PatCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PatCount_AllC.csv',A)


PatCount = csvread('PubCount.csv', 4, 0);
B = PatCount; A = []; i = min(B(:,2)); 
B=[B(:,2) B(:,4:5)];

while(i <= max(B(:,2)))
    C=B(B(:,2) == i,:); A(i, 1) = i; j=1; 
    
    while(j<=max(B(:,1)))
        D=C(C(:,1) == j,:); A(i, j+1) = sum(D(:,3)); j=j+1;
    end
    
    i=i+1;  
end

A = A(min(B(:,2)):end,:)
csvwrite('PubCount_AllC.csv',A)