clc; clearvars; R = 10; R2=50; % Set font size and point size for scatter plot 

Gender = [2	1	2	3	1	1	2	1	1	1	1	1	1	2	3	3	1	3	3	3	2	2	2	2	3	2	2	1	1	2	2	1	2	1	1	2	1	1	2	2	2	1	3	2	3	1	2	2	2	2	2	2	2	1	1	1	1	3	2	2	1	3	2	2	1	2	1	1	2	3	2	2	1	2	1	1	1	1	1	2	2	2	2	2	1	2	2	2	3	3	3	3	1	1	1	1	1	1	1	1	1	2	2	2	2	2	1	1	1	2	3	2	2	3	2	1	2	2	1	2	2	2	2	2	2	2	2	1	1	2	2	2	2	2	2	2	2	2	2	2	1	1	1	1	2	2	2	2	2	2	2	2	2	2	3	3	3	2	1	1	1	1	1	1	2	2	2	2	2	2	1	1	2	2	2	2	2	2	2	2	2	3	2	2	2	2	2	3	2	2	1	1	1	1	1	1	1	1	1	1	2];
Ethnicity = [3	3	4	4	1	3	4	2	2	2	2	2	3	3	3	4	3	4	4	4	3	3	3	3	4	3	3	2	4	4	1	4	1	1	3	3	4	3	3	3	3	4	4	4	4	3	3	3	3	3	3	3	3	4	4	4	4	4	3	1	3	4	3	4	3	3	4	3	4	4	3	4	4	4	3	3	3	3	3	3	3	3	3	3	4	4	4	4	4	4	3	4	2	3	3	3	3	4	3	3	4	2	2	2	4	2	3	3	3	3	3	4	4	4	1	3	3	3	4	4	4	3	4	2	2	1	1	3	3	4	4	4	4	4	4	4	3	1	3	3	4	3	2	2	3	3	3	3	3	3	3	4	4	4	4	4	4	4	3	3	3	3	3	3	3	3	3	3	3	3	4	4	4	4	4	4	4	4	4	4	4	4	4	3	3	4	4	4	3	4	3	3	3	4	4	4	4	4	1	3	4];
Year = [1993	1971	1976	1988	1990	1977	1990	1985	1985	1951	1954	1995	1977	1972	1977	1988	1976	1995	1995	1997	1995	1975	1979	1987	1999	1971	1980	1954	1990	1990	1992	1973	1992	1992	1997	1993	1979	1981	1975	1975	1988	1982	1986	1968	1971	1974	1979	1974	1973	1973	1978	1994	1987	1973	1985	1985	1973	1995	2001	1978	1979	1976	1980	1995	1981	1993	1992	1995	1981	1983	1970	1986	1970	1977	1983	1992	1973	1981	1978	1979	1972	1966	1979	1967	1973	1973	1972	2004	1968	1988	1998	1994	1974	1973	1978	1974	1978	1981	1977	1977	1988	1969	1973	1964	1980	1967	1978	1964	1979	1967	1987	1970	1978	1992	1987	1990	1978	1978	1975	1991	1983	1975	1990	1963	1967	1990	1981	1986	1977	1966	1966	1972	1972	1977	1980	1977	1974	1981	1980	1984	1972	1995	1983	1996	1975	1985	1972	1980	1990	1975	2009	1991	1991	1981	1989	1986	1960	1991	1976	1976	1980	1980	1976	1964	1977	1978	1978	1978	1976	1976	1974	1993	1982	1974	1971	1985	1979	1968	1981	1979	1986	1986	1980	1997	1991	1995	2009	2001	1976	1986	1973	1973	1974	1988	1988	1988	1984	1993	1996	1980	1991];
Count = [1	5	5	21	8	2	12	21	1	765	4	4	13	84	12	2	2	2	8	2	1	2	9	6	3	4	291	136	1	5	2	7	1	1	3	1	1	20	1	43	6	51	1	14	9	17	2	1	1	9	8	25	5	52	3	6	27	1	7	12	41	4	66	10	231	88	1	1	5	2	9	6	151	2	3	1	22	10	6	40	3	114	1	30	35	42	3	4	29	2	1	1	12	268	20	284	3	82	26	0	1	3	3	53	2	2	9	20	21	2	1	2	20	2	35	12	73	59	501	9	10	1	1	4	1	1	10	1	158	42	1	23	3	2	127	1	185	9	10	1	9	1	4	24	1	3	244	6	1	1	56	1	1	4	3	14	2	1	12	1	26	2	1	86	5	22	6	1	48	93	11	2	16	9	24	2	61	2	188	20	1	5	6	10	2	4	1	3	4	2	10	39	23	1	1	3	38	1	137	4	1];
Age = [72	55	2	-10	1	58	84	31	31	31	31	31	40	35	-10	0	1	-10	-10	-10	-10	69	22	1	-10	52	15	31	40	82	64	15	64	49	73	74	0	62	65	56	26	61	-10	-10	-10	3	17	78	53	53	31	26	26	85	58	58	54	-10	43	55	54	-10	22	36	77	58	78	-10	25	-10	63	-10	4	2	68	59	14	6	2	61	50	44	11	1	4	53	2	1	-10	-10	78	-10	44	69	63	51	47	54	74	74	65	7	7	3	-10	16	33	4	4	11	-10	53	24	-10	35	62	59	59	53	65	55	3	42	11	7	38	38	63	36	61	61	19	19	14	1	-10	37	54	53	8	3	-10	32	0	65	62	58	55	52	47	1	49	49	-10	-10	-10	-10	49	82	81	58	58	51	44	72	70	70	70	51	50	78	58	72	67	56	34	-10	-10	-10	-10	-10	-10	84	59	41	35	-10	-10	83	66	64	64	12	-10	-10	-10	-10	-10	39	56	49];
Disease = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	3	3	3	3	3	3	3	3	3	3	3	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	4	5	5	5	5	5	5	5	5	5	5	5	5	5	5	5	5	5	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	6	7	7	7	7	7	7	7	7	7	7	5];

Master = transpose([Gender ; Ethnicity ; Year ; Count; Age; Disease]); 
Fem = Master; Fem(Fem(:,1)>1,:)=[];
Mal = Master; Mal(Mal(:,1)<2,:)=[]; Mal(Mal(:,1)>2,:)=[];
UnG = Master; UnG(UnG(:,1)<3,:)=[]; UnG(UnG(:,1)>3,:)=[];
PieG = [length(Fem),length(Mal),length(UnG)];
PieGc = [sum(Fem(:,4)), sum(Mal(:,4)),sum(UnG(:,4))];
explodeG = 3*ones(length(PieG),1); labG = {'Female','Male','Unspecified'};

Asi = Master; Asi(Asi(:,2)>1,:)=[];
Bla = Master; Bla(Bla(:,2)<2,:)=[]; Bla(Bla(:,2)>2,:)=[];
Cau = Master; Cau(Cau(:,2)<3,:)=[]; Cau(Cau(:,2)>3,:)=[];
UnE = Master; UnE(UnE(:,2)<4,:)=[]; UnE(UnE(:,2)>4,:)=[];
PieE = [length(Asi),length(Bla),length(Cau), length(UnE)];
PieEc = [sum(Asi(:,4)), sum(Bla(:,4)),sum(Cau(:,4)), sum(UnE(:,4))];
explodeE = 3*ones(length(PieE),1); labE = {'Asian', 'Black','Caucasian','Unspecified'};

co = 0.99; c1 = 0.5; % Inner and outer color for scatter plot markers
f1 = figure; % Pie charts of gender and ethnicity representation in cell lines and published literature
s1 = 2; s2 = 2; si = 0; colormap([co 0 0; 0 co 0; 0 0 co; c1 c1 c1]);
si = si+1; subplot(s1, s2, si);  h=pie(PieG, explodeG); legend(labG, 'Location','EastOutside'); title(sprintf('Available Cell Lines (%g)', round(sum(PieG)))); set(gca,'fontsize',R);  
si = si+1; subplot(s1, s2, si);  h=pie(PieE, explodeE);legend(labE, 'Location','EastOutside'); title(sprintf('Available Cell Lines (%g)', round(sum(PieE)))); set(gca,'fontsize',R);
si = si+1; subplot(s1, s2, si);  h=pie(PieGc, explodeG);legend(labG, 'Location','EastOutside'); title(sprintf('Representation in Publications (%g)', round(sum(PieGc)))); set(gca,'fontsize',R);
si = si+1; subplot(s1, s2, si);  h=pie(PieEc, explodeE); legend(labE, 'Location','EastOutside');title(sprintf('Representation in Publications (%g)', round(sum(PieEc)))); set(gca,'fontsize',R);

f2 = figure; s1 = 2; s2 = 2; si = 0;
si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ylabel('Donor Age'); 
s = scatter(3*ones(length(UnG),1),UnG(:,5), R2); s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1];
s = scatter(1*ones(length(Fem),1),Fem(:,5), R2); s.MarkerFaceColor = [co 0 0];  s.MarkerEdgeColor = [c1 0 0];
s = scatter(2*ones(length(Mal),1),Mal(:,5), R2); s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1];
A = (transpose([transpose(Fem(:,5)); -1*ones(2,length(Fem))]) ); A(A(:,1)<1,:)=[];  boxplot(A, 'Labels',labG)
A = (transpose([-1*ones(1,length(Mal)); transpose(Mal(:,5)); -1*ones(1,length(Mal))]) ); A(A(:,2)<1,:)=[];  boxplot(A, 'Labels',labG)
A = (transpose([-1*ones(3,length(UnG)); transpose(UnG(:,5))]) ); A(A(:,2)<1,:)=[]; boxplot(A, 'Labels',labG)
%legend(labG); 
ylim([0 90]); set(gca,'YTick',0:10:90); set(gca,'XTick',1950:10:2020);
title('Donor Age by Gender for Available Cell Lines'); hold off;

si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ylabel('Donor Age'); 
s = scatter(4*ones(length(UnE),1),UnE(:,5), R2); s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1];
s = scatter(1*ones(length(Asi),1),Asi(:,5), R2); s.MarkerFaceColor = [co 0 0];  s.MarkerEdgeColor = [c1 0 0];
s = scatter(2*ones(length(Bla),1),Bla(:,5), R2); s.MarkerFaceColor = [0 co 0 ]; s.MarkerEdgeColor = [ 0 c1 0];
s = scatter(3*ones(length(Cau),1),Cau(:,5), R2); s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1];
A = (transpose([transpose(Asi(:,5)); -1*ones(3,length(Asi))]) ); A(A(:,1)<1,:)=[]; boxplot(A)
A = (transpose([-1*ones(1,length(Bla)); transpose(Bla(:,5)); -1*ones(2,length(Bla))]) ); A(A(:,2)<1,:)=[]; boxplot(A)
A = (transpose([-1*ones(2,length(Cau)); transpose(Cau(:,5)); -1*ones(1,length(Cau))]) ); A(A(:,3)<1,:)=[]; boxplot(A)
A = (transpose([-1*ones(3,length(Cau)); transpose(Cau(:,5))]) ); A(A(:,4)<1,:)=[]; boxplot(A, 'Labels',labE)
%legend(labE); 
ylim([0 90]); set(gca,'YTick',0:10:90);
title('Donor Age by Ethnicity for Available Cell Lines'); hold off;

si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ylabel('Donor Age'); xlabel('Year Archived'); 
axis([1950 2016 0 90]); 
s = scatter(UnG(:,3),UnG(:,5), R2); s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1];
s = scatter(Fem(:,3),Fem(:,5), R2); s.MarkerFaceColor = [co 0 0];  s.MarkerEdgeColor = [c1 0 0];
s = scatter(Mal(:,3),Mal(:,5), R2); s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1];
ylim([0 90]); set(gca,'YTick',0:10:90);
%legend('Unspecified','Female','Male','Location','Northwest'); 
title('Timeline by Donor Age and Gender'); hold off;

si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ylabel('Donor Age'); xlabel('Year Archived'); 
axis([1950 2016 0 90]); 
s = scatter(UnE(:,3),UnE(:,5), R2); s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1];
s = scatter(Asi(:,3),Asi(:,5), R2); s.MarkerFaceColor = [co 0 0];  s.MarkerEdgeColor = [c1 0 0];
s = scatter(Bla(:,3),Bla(:,5), R2); s.MarkerFaceColor = [0 co 0 ]; s.MarkerEdgeColor = [ 0 c1 0];
s = scatter(Cau(:,3),Cau(:,5), R2); s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1];
ylim([0 90]); set(gca,'YTick',0:10:90);
% legend('Unspecified','Asian','Black','Caucasian','Location','Northwest'); 
title('Timeline by Donor Age and Ethnicity'); hold off;

f3 = figure; s1=2; s2=1; si=0; di = 1; 
    i=1; l = 1; a=2; b=1; S=ones((max(Master(:,a))*max(Master(:,b))),1); Sa=S; Sat=0; % 1 for gender, 2 for 
    si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ax = gca;
    while i< (max(Master(:,a))+1) 
      j=1;
      while j< (max(Master(:,b))+1)
        B = Master; 
        B(B(:,a)<i,:)=[]; B(B(:,a)>i,:)=[]; B(B(:,b)<j,:)=[]; B(B(:,b)>j,:)=[]; 
        S(l,1)=length(B); Sat = Sat+sum(B(:,4));   
        if (j==1); s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'o'); 
        elseif (j==2); s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'd'); 
        else s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'x'); 
        end   
        if (i==1); s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ];
        elseif (i==2); s.MarkerFaceColor = [0 co 0]; s.MarkerEdgeColor = [0 c1 0 ];
        elseif (i==3); s.MarkerFaceColor = [0 0 co]; s.MarkerEdgeColor = [0 0 c1];
        else s.MarkerFaceColor = [co co co]; s.MarkerEdgeColor = [c1 c1 c1];
        end
        B = (transpose([-1*ones(l-1,length(B(:,4))); transpose(B(:,4)); -1*ones(((max(Master(:,2)))-l),length(B(:,4)))]) );
        boxplot(B); l=l+1; j=j+1; set(gca,'yscale','log');  
      end
      i=i+1;
    end
    ax.XTickLabel = S; 
    ylim([0 800]); xlim([0 (max(Master(:,a))*max(Master(:,b))+1)]); 
    ylabel(sprintf('Pubs (Total %g)', round(sum((Sat)))));
    xlabel(sprintf('Represented Cell Lines (Total %g)', round(sum(S))));
    legend({'F,A','M,A','U,A','F,B','M,B','U,B','F,C','M,C','U,C','F,U','M,U','Un'},'Location','SouthOutside','Orientation','Horizontal');
    hold off;
    B2=Master;
    si = si+1; subplot(s1, s2, si);  hold on; box on; set(gca,'yscale','log'); set(gca,'fontsize',R); axis([1950 2016 0 900]); Bi=0; Bii=0;
    Bn = Master(Master(:,2)==1,:); Bn = Bn(Bn(:,1)==1,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==1,:); Bn = Bn(Bn(:,1)==2,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==1,:); Bn = Bn(Bn(:,1)==3,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==2,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==2,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==2,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==3,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==3,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==3,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==4,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==4,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    Bn = Master(Master(:,2)==4,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; Bi=Bi+sum(Bn(:,4)); Bii=Bii+length(Bn(:,4));
    ylabel(sprintf('Pubs (%g)', round(sum(Bi)))); xlabel(sprintf('Year Archived (Cell Lines %g)', round(Bii))); 
    hold off;

f4 = figure; s1=3; s2=4; si=0; di = 2; 
while (di < s1*s2+1)
    i=1; l = 1; a=2; b=1; S=ones((max(Master(:,a))*max(Master(:,b))),1); SP = S; B2 = [];
    si = si+1; subplot(s1, s2, si); hold on; set(gca,'fontsize',R); box on; ax = gca;
    while i< (max(Master(:,a))+1) 
      j=1;
      while j< (max(Master(:,b))+1)
        B = Master; B(B(:,6)<di,:)=[]; B(B(:,6)>di,:)=[]; 
        B(B(:,a)<i,:)=[]; B(B(:,a)>i,:)=[]; B(B(:,b)<j,:)=[]; B(B(:,b)>j,:)=[]; 
        S(l,1)=length(B(:,4)); SP(l,1)=sum(B(:,4));   
        if (j==1); s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'o'); 
        elseif (j==2); s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'd'); 
        else s = scatter(l*ones(length(B(:,4)),1),B(:,4),R2, 'x'); 
        end   
        if (i==1); s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; 
        elseif (i==2); s.MarkerFaceColor = [0 co 0]; s.MarkerEdgeColor = [0 c1 0 ];
        elseif (i==3); s.MarkerFaceColor = [0 0 co]; s.MarkerEdgeColor = [0 0 c1];
        else s.MarkerFaceColor = [co co co]; s.MarkerEdgeColor = [c1 c1 c1];
        end
        B1 = (transpose([-1*ones(l-1,length(B(:,4))); transpose(B(:,4)); -1*ones(((max(Master(:,2)))-l),length(B(:,4)))]) );
        boxplot(B1); l=l+1; j=j+1; set(gca,'yscale','log'); 
        B2 = [B2 transpose(B)];
      end
      i=i+1;
    end
    ax.XTickLabel = S;
    ylim([0 800]); xlim([0 (max(Master(:,a))*max(Master(:,b))+1)]); 
    ylabel(sprintf('Pubs (%g)', round(sum((SP)))));
    xlabel(sprintf('Cell Lines (Total %g)', round(sum(S))));
    hold off;
    if isequal(di,1); title(sprintf('Cancer')); 
    elseif isequal(di,2); title(sprintf('Brain Cancer')); 
    elseif isequal(di,3); title(sprintf('Breast Cancer ')); 
    elseif isequal(di,4); title(sprintf('Leukemia/Lymphoma')); 
    elseif isequal(di,5); title(sprintf('Lung Cancer')); 
    elseif isequal(di,6); title(sprintf('Prostate/Colon Cancer')); 
    elseif isequal(di,7); title(sprintf('Ovarian/Uterine Cancer'));
    end
    B2=transpose(B2)
    si = si+1; subplot(s1, s2, si);  hold on; box on; set(gca,'yscale','log'); ylabel(sprintf('Pubs (%g)', round(sum(B2(:,4))))); 
    xlabel(sprintf('Year Archived (Cell Lines %g)', round(length(B2(:,4))))); set(gca,'fontsize',R); axis([1950 2016 0 900]); 
    Bn = B2(B2(:,2)==1,:); Bn = Bn(Bn(:,1)==1,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; 
    Bn = B2(B2(:,2)==1,:); Bn = Bn(Bn(:,1)==2,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; 
    Bn = B2(B2(:,2)==1,:); Bn = Bn(Bn(:,1)==3,:); s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [co 0 0]; s.MarkerEdgeColor = [c1 0 0 ]; 
    Bn = B2(B2(:,2)==2,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; 
    Bn = B2(B2(:,2)==2,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; 
    Bn = B2(B2(:,2)==2,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x'); s.MarkerFaceColor = [0 co  0]; s.MarkerEdgeColor = [0 c1 0 ]; 
    Bn = B2(B2(:,2)==3,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; 
    Bn = B2(B2(:,2)==3,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; 
    Bn = B2(B2(:,2)==3,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [0 0 co ]; s.MarkerEdgeColor = [0 0 c1 ]; 
    Bn = B2(B2(:,2)==4,:); Bn = Bn(Bn(:,1)==1,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'o');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; 
    Bn = B2(B2(:,2)==4,:); Bn = Bn(Bn(:,1)==2,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'd');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; 
    Bn = B2(B2(:,2)==4,:); Bn = Bn(Bn(:,1)==3,:);  s = scatter(Bn(:,3),Bn(:,4), R2, 'x');  s.MarkerFaceColor = [co co co ]; s.MarkerEdgeColor = [c1 c1 c1 ]; 
    hold off;
%     si = si+1; subplot(s1, s2, si);  h=pie(S, 3*ones(length(S),1)); title(sprintf('Cell Lines (%g)', round(sum(S)))); set(gca,'fontsize',R);  
%     si = si+1; subplot(s1, s2, si);  h=pie(SP, 3*ones(length(SP),1)); title(sprintf('Publication (%g)', round(sum(SP)))); set(gca,'fontsize',R); 
    di=di+1;
end


