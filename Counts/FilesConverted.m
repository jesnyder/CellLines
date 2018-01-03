
clear all; clc;


a = string('Originals/v01_PaCo.csv');
b = string('Originals/v01_PuCo.csv'); 

CSVFunction(char(a),char(string('BC/vBC_PatCount.csv')),2);
CSVFunction(char(b),char(string('BC/vBC_PubCount.csv')),2);
CSVFunction(char(a),char(string('PC/vPC_PatCount.csv')),3);
CSVFunction(char(b),char(string('PC/vPC_PubCount.csv')),3);
CSVFunction(char(a),char(string('LC/vLC_PatCount.csv')),4);
CSVFunction(char(b),char(string('LC/vLC_PubCount.csv')),4);


