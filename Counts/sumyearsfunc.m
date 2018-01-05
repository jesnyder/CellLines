function  sumyears = sumyearsfunc(y,yearmin)

%Specify years to trim
Ymin = yearmin; Ydef = 5;

% Trim years
C=y(y(:,1) >= Ymin,:); C=C(C(:,1) <= Ymin+Ydef,:); C(:,1) = [];

% totals for each ethnicity
sumeth = []; i = 1; while(i<=length(C(1,:))); sumeth(i) = sum(C(:,i)); i=i+1; end

%Divide each ethnicity by the total
sumyears = [Ymin, sumeth./sum(sumeth)];

end
