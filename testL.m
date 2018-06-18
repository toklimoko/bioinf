clc, close all, clear all;

%% ustalenie 
kara = 1;
nagroda = 1;
brak = 0;

%% wczytywanie sekwencji rêczne
%  w1 = 'CATWALK';
%  w2 = 'COWARDS';
 
% w1 = 'ACGGTTCGCTTAGGG';
% w2 = 'ACGTTCGAAGCGCTG';

% w2 = 'GGTAC'
% w1 = 'AGCTA'

% w1 = 'GCATTCU';
% w2 = 'GCTTUTC';

w1 = ' GTC'
w2 = 'AATC';


%DOPASOWANIE OD WSPOLRZ...

%% 

%{
[E, macierzPunktow] =  funkcja( w1, w2, kara, nagroda, brak);

colormap('jet')
macierzPunktow
imagesc(macierzPunktow)
colorbar
%}
[E, macierzPunktow, fig, trasy, druki, msg]=funkcjaL( w1, w2, nagroda, kara, brak);

%%




