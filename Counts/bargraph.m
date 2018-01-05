function  bargraph(Y1,Y2, cancertype)

f1 = figure; 

categories = {'Incidence','Morbidity','Publication','US Patents'};
title4x = cancertype; title4y = {'Fraction of Total Group'}; limy = [.4 1.01];
legs = {'White','Black','Asian','Hispanic','Native American'};

subplot(1,2,1)
bar(Y1(:,2:end), 'stacked')
set(gca, 'YScale', 'log')
ylim(limy)
title('Ethnic Represenation from 2002-2007')
ylabel(title4y); xlabel(title4x); xticks([1 2 3 4]); xticklabels(categories); legend(legs, 'Location','SouthEast');

subplot(1,2,2)
bar(Y2(:,2:end), 'stacked')
set(gca, 'YScale', 'log')
ylim(limy)
title('Ethnic Represenation from 2008-2013')
ylabel(title4y); xlabel(title4x); xticks([1 2 3 4]); xticklabels(categories); legend(legs, 'Location','SouthEast');

set(f1, 'Position', [0 0 800 300])
saveas(f1, sprintf('results.jpg'))



end