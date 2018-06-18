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

%na tym
w1 = 'AATC'
w2 = 'GTC'

%w2 = 'GGTAC'
%w1 = 'AGCTA'

% w1 = 'GCATTCU';
% w2 = 'GCTTUTC';

%  w1 = 'AGCA';
%  w2 = 'ACGA';


%% 

%{
[E, macierzPunktow] =  funkcja( w1, w2, kara, nagroda, brak);

colormap('jet')
macierzPunktow
imagesc(macierzPunktow)
colorbar
%}
[E, macierzPunktow, fig, trasy, druki, msg]=funkcjaG( w1, w2, nagroda, kara, brak);

%%




