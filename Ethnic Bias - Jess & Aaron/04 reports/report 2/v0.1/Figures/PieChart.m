clc
R = 13;

Eth = [ 7 8 62 60];
Ethlabels ={'Asian', 'Black','Caucasian' ,'Unspecified'};

Gen = [ 48 65 24];
Genlabels ={'Female','Male' ,'Unspecified'};

All = [1 6 3 1 4 26 35 1 17 24 19 ];
Alllabels = {'Asian Female', 'Asian Male', 'Black Female', 'Black Male', 'Black Unspecified' ,'Caucasian Female', 'Caucasian Male', 'Caucasian Unspecified', 'Unspecified Female', 'Unspecified Male', 'Unspecified'};


f1 = figure 
subplot(2,2,1)
explode = 3*ones(length(Gen),1);
p = pie(Gen, explode) 
hold on 
set(gca,'fontsize', R)
legend(labels,'Location','eastoutside','Orientation','vertical')
hold off

subplot(2,2,3)
explode = 3*ones(length(Eth),1);
p = pie(Eth,explode) 
hold on 
set(gca,'fontsize', R)
legend(Ethlabels,'Location','eastoutside','Orientation','vertical')
hold off

subplot(1,2,2)
explode = 3*ones(length(All),1);
p = pie(All,explode) 
hold on 
set(gca,'fontsize', R)
legend(Alllabels,'Location','southoutside','Orientation','vertical')
hold off


saveas(f1,'PieChart_01.jpg')

f2 = figure; 
subplot(1,2,1)
hold on 
F1 = [1	1	3	3	4	4	4	4	6	7	12	14	31	31	32	36	39	40	44	44	47	48	51	53	54	54	54	55	56	58	58	58	58	58	61	62	62	63	64	64	67	69	74	77	77	82	85];
F2 = .5*ones(1,length(F1));
scatter(F1,F2)

M1 = [0	1	1	1	1	1	2	3	8	15	19	19	22	22	24	25	26	26	26	35	35	35	36	37	38	38	38	41	43	44	45	50	51	53	53	53	53	54	55	55	56	58	58	59	59	59	61	61	63	65	67	69	70	72	74	76	82	84];
M2 = 1*ones(1,length(M1));
scatter(M1,M2)

legend({'Female','Male'})
box on
ylim([0 1.5])
xlim([0 90])
xlabel('Age of Donor (years)')
ylabel('Gender')
set(gca,'YTick',[100:0.5:101])
set(gca,'XTick',[0:10:90])
set(gca,'fontsize', R)
hold off

subplot(1,2,2)
hold on 
A1 = [55	1	38	38	38	35	54];
A2 = .5*ones(1,length(A1));
scatter(A1,A2)

B1 = [44	31	31	3];
B2 = 1*ones(1,length(B1));
scatter(B1,B2)

C1 = [0	1	1	1	1	3	4	4	6	7	8	12	14	15	22	22	26	26	26	35	36	36	37	40	41	43	44	44	45	47	50	51	51	53	53	53	54	55	56	56	58	58	58	58	59	59	59	61	62	62	63	63	64	64	69	69	70	74	77	77	82];
C2 = 1.5*ones(1,length(C1));
scatter(C1,C2)

U1 = [1	1	2	3	4	4	19	19	24	25	32	35	39	48	53	53	54	54	55	58	58	58	61	61	65	67	67	72	74	76	82	84	85];
U2 = 2*ones(1,length(U1));
scatter(U1,U2)

legend({'Asian','Black','Caucasian','Unspecified'})
box on
ylim([.5 3])
xlim([0 100])
xlabel('Age of Donor (years)')
ylabel('Ethnicity')
set(gca,'YTick',[100:0.5:101])
set(gca,'XTick',[0:10:100])
set(gca,'fontsize', R)
hold off

saveas(f1,'PieChart_02.jpg')

f3 = figure;
subplot(2,2,1)
hold on
FemAge = [0	0	1	3	4	4	4	4	6	7	11	12	14	15	31	31	31	36	39	44	47	51	53	54	54	54	58	58	58	61	64	64	65	69	73	74	77	85];
FemYear = [1961	1984	1974	1974	1964	1970	1973	1979	1981	1969	1977	1974	1973	1964	1951	1954	1955	1977	1996	1964	1978	1974	1975	1973	1979	1981	1977	1980	1986	1982	1973	1973	1988	1973	1997	1977	1981	1973];
MalAge = [0	1	1	1	1	3	5	8	8	14	15	22	22	24	25	33	35	35	35	36	37	44	50	50	50	51	52	53	53	54	55	56	58	58	59	59	59	61	61	62	62	63	67	69	69	70	72	72	72	74	74];
MalYear = [1966	1967	1980	1987	2009	1964	1968	1979	1984	1977	1980	1979	1980	1978	1981	1995	1972	1987	1995	1995	1974	1966	1972	1976	1977	1976	1990	1973	1980	1981	1978	1975	1972	1993	1980	1980	1997	1966	1979	1979	1985	1970	1974	1975	1985	1978	1977	1982	1993	1990	1993];
scatter(FemYear, FemAge, 'MarkerEdgeColor',[.5 0 0], 'MarkerFaceColor', [.9 .5 .5])
scatter(MalYear, MalAge, 'd', 'MarkerEdgeColor',[0 0 .5], 'MarkerFaceColor', [.5 .5 .9])
legend({'Female','Male'}, 'location' ,'southoutside','orientation','horizontal')
xlim([1950 2015])
ylim([0 90])
xlabel('Timeline of Cell Line Origin')
ylabel('Age of Donor (years)')
set(gca,'XTick',[1950:10:2025])
set(gca,'YTick',[0:10:100])
set(gca,'fontsize', R)
box on
hold off

subplot(2,2,2)
hold on
AsianAge = [39	55	35	54];
AsianYear = [1996	1978	1987	1981];
BlackAge = [31	31	31	3	8];
BlackYear = [1951	1954	1955	1964	1979];
CauAge = [0	1	3	4	4	6	7	11	12	15	36	44	47	51	54	58	58	64	64	69	73	74	77	0	1	1	8	14	15	22	22	35	36	37	44	50	50	50	51	52	53	53	56	58	58	59	59	59	61	62	62	63	69	69	70	72	72	74	78	14	1];
CauYear = [1961	1974	1974	1964	1979	1981	1969	1977	1974	1964	1977	1964	1978	1974	1979	1977	1980	1973	1973	1973	1997	1977	1981	1966	1967	1987	1984	1977	1980	1979	1980	1972	1995	1974	1966	1972	1976	1977	1976	1990	1973	1980	1975	1972	1993	1980	1980	1997	1979	1979	1985	1970	1975	1985	1978	1977	1993	1993	1997	1973	2009];
UnAge = [0	4	4	53	54	54	58	61	85	1	5	24	25	33	35	61	67	72	74	65];
UnYear = [1984	1970	1973	1975	1973	1981	1986	1982	1973	1980	1968	1978	1981	1995	1995	1966	1974	1982	1990	1988];
scatter(AsianYear, AsianAge, 'MarkerEdgeColor',[.5 0 0], 'MarkerFaceColor', [.9 .5 .5])
scatter(BlackYear, BlackAge,'MarkerEdgeColor',[0 .5 0 ], 'MarkerFaceColor', [.5 .9 .5 ])
scatter(CauYear, CauAge,'MarkerEdgeColor',[0 0 .5], 'MarkerFaceColor', [.5 .5 .9 ])
scatter(UnYear, UnAge,'MarkerEdgeColor',[.2 .2 .2], 'MarkerFaceColor', [ .9 .9 .9])
legend({'Asian','Black','Caucasian','Unspecified'}, 'location','southoutside','orientation','horizontal')
xlim([1950 2015])
ylim([0 90])
xlabel('Timeline of Cell Line Origin')
ylabel('Age of Donor (years)')
set(gca,'XTick',[1950:10:2020])
set(gca,'YTick',[0:10:100])
set(gca,'fontsize', R)
box on
hold off

subplot(2,2,3)
hold on
A5 = transpose([FemAge; -1*ones(1,length(FemAge))])
A6 = transpose([-1*ones(1,length(MalAge)); MalAge])
boxplot( A5 )
boxplot( A6 )
scatter(1*ones(1,length(FemAge)), FemAge,  'MarkerEdgeColor',[.5 0 0], 'MarkerFaceColor', [.9 .5 .5])
scatter(2*ones(1,length(MalAge)), MalAge,  'MarkerEdgeColor',[0 0 .5], 'MarkerFaceColor', [.5 .5 .9])
legend({'Female','Male'}, 'location' ,'southoutside','orientation','horizontal')
xlim([.5 2.5])
ylim([0 90])
set(gca,'XTick',[10:10:20])
set(gca,'YTick',[0:10:100])
ylabel('Age of Donor (years)')
set(gca,'fontsize', R)
box on;
hold off

subplot(2,2,4)
hold on
A1 = transpose([AsianAge; -1*ones(1,length(AsianAge)); -1*ones(1,length(AsianAge)); -1*ones(1,length(AsianAge))])
A2 = transpose([-1*ones(1,length(BlackAge)); BlackAge;  -1*ones(1,length(BlackAge)); -1*ones(1,length(BlackAge))])
A3 = transpose([-1*ones(1,length(CauAge));-1*ones(1,length(CauAge));CauAge;  -1*ones(1,length(CauAge))])
A4 = transpose([-1*ones(1,length(UnAge));-1*ones(1,length(UnAge)); -1*ones(1,length(UnAge)); UnAge])
boxplot( A1 )
boxplot( A2 )
boxplot( A3 )
boxplot( A4 )
scatter(1*ones(1,length(AsianAge)), AsianAge, 'MarkerEdgeColor',[.5 0 0], 'MarkerFaceColor', [.9 .5 .5])
scatter(2*ones(1,length(BlackAge)), BlackAge,'MarkerEdgeColor',[0 .5 0 ], 'MarkerFaceColor', [.5 .9 .5 ])
scatter(3*ones(1,length(CauAge)), CauAge,'MarkerEdgeColor',[0 0 .5], 'MarkerFaceColor', [.5 .5 .9 ])
scatter(4*ones(1,length(UnAge)), UnAge,'MarkerEdgeColor',[.2 .2 .2], 'MarkerFaceColor', [ .9 .9 .9])
legend({'Asian','Black','Caucasian','Unspecified'}, 'location','southoutside','orientation','horizontal')
xlim([.5 4.5])
ylim([0 90])
set(gca,'XTick',[10:10:20])
set(gca,'YTick',[0:10:100])
ylabel('Age of Donor (years)')
set(gca,'fontsize', R)
box on;
hold off