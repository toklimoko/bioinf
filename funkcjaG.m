function [ E, macierzPunktow, fig, trasy, druki ] = funkcjaG( w1, w2, kara, nagroda, brak )
t=0;
%ustalenie kary na ujemn�:
if kara>0
    kara = kara*-1;
end

%tworzenie punkt�w pocz�tkowych
zerosRow = (0:(length(w2))).* -1;
zerosColumn = (1:(length(w1))).' .* -1;

%tworz� macierz punkt�w
macierzPunktow = zeros(length(w1), length(w2));

macierzPunktow = [zerosColumn macierzPunktow]; %dopisanie pierwszej kolumny
macierzPunktow = [zerosRow; macierzPunktow]; %dopisanie pierwszego wiersza -0 uzyskujemy macierz z punktami na osiach

E = cell(length(w1)+1,length(w2)+1); %do opisu kom�rek

%poruszanie si�:
for i=2:length(w1)+1
    for j=2:length(w2)+1
        
        %[0 0 0 0] :
        %pierwsza pozycja: zgodno�� liter (1/0)
        %druga pozycja: czy skos (1/0)
        %trzecia pozycja: czy poziom (1/0)
        %czwarta pozycja: czy pion (1/0)
        
        wynik = 0;
              
        if (w2(j-1)==w1(i-1)) %gdy zgadzaj� si� litery
            wynik = 1;
            n = nagroda; %gdy zgoda
        else
            n = brak; %gdy niezgoda
        end
       
        if(max(macierzPunktow(i-1,j-1)+n,max(macierzPunktow(i-1,j)+kara,macierzPunktow(i,j-1)+kara))==macierzPunktow(i-1,j-1)+n) %gdy po skosie:         
             macierzPunktow(i, j)=macierzPunktow(i-1,j-1)+n;           
            wynik = [wynik 1];
            
        else
            wynik = [wynik 0]; %gdy nie po skosie
        end     
        
        if(max(macierzPunktow(i-1,j-1)+n,max(macierzPunktow(i-1,j)+kara,macierzPunktow(i,j-1)+kara))==macierzPunktow(i,j-1)+kara) %gdy poziomo:
            wynik = [wynik 1];
             macierzPunktow(i, j)=macierzPunktow(i,j-1)+kara;
        else
            wynik = [wynik 0]; %gdy nie poziomo
        end       
        
        if(max(macierzPunktow(i-1,j-1)+n,max(macierzPunktow(i-1,j)+kara,macierzPunktow(i,j-1)+kara))==macierzPunktow(i-1,j)+kara) %gdy pionowo:
            wynik = [wynik 1];
             macierzPunktow(i, j)=macierzPunktow(i-1,j)+kara;
        else
            wynik = [wynik 0]; %gdy nie pionowo
        end
        
        wynik = [wynik, i, j, sum(wynik(2:4)), 1] %dodanie informacji o lokalizacji (i,j), sumie kierunkow (czy rozdroze) oraz kierunku na start
        E{i,j} = wynik;
    end
end

%E %macierz z opisem ruch�w
%celldisp(E)

%wyswietlanie
fig=figure('Name','Global matching');
colormap('jet')
macierzPunktow
imagesc(macierzPunktow)
hold on
colorbar

set(gca,'XAxisLocation','top');
xlabel('Sekwencja 1');
ylabel('Sekwencja 2');

%znajdywanie lokalizacji maksim�w

kopiaZMaximami = macierzPunktow;
maskaCzyszczaca = zeros(length(w1),length(w2));
maskaCzyszczaca = [maskaCzyszczaca ones(length(w1),1)];
maskaCzyszczaca = [maskaCzyszczaca; ones(1, length(w2)+1)];
kopiaZMaximami = kopiaZMaximami .* maskaCzyszczaca;

max_num = max(kopiaZMaximami(:));
[x,y]=find(kopiaZMaximami==max_num);

%sprawdzanie sciezek dla kazdego punktu maximum

iloscMaximow = length(x);
trasy = {};
linie = '';

for i = 1:iloscMaximow
    
    wspolrzPktPocz=[x(i) y(i)]; %pobierz kolejne wsp punktu maximum
    trasa=wspolrzPktPocz;
    
    
   while (wspolrzPktPocz(1)~=1 && wspolrzPktPocz(2)~=1) %poruszanie a� do (1,1)
    
       komorka = E{wspolrzPktPocz(1), wspolrzPktPocz(2)};
          
   if komorka(7) >1 %je�li rozdro�e
      
       kopieTras = {}; % czyszcz� cella z kopiami tras
       
       for j = 1:komorka(7)
           kopieTras{end+1} = trasa; %tu kopiuj� obecn� tras� do cella kopieTras tyle razy, ile rozdrozy + 1 (do kopieTras)
       end
       
       [noweTrasy] = rozdrozeG(E, wspolrzPktPocz, kopieTras); %<-- ustalam lokalizacje pocz�tkow� jako lok rozdroza (punkt startowy dla funkcji)

       rozmiar = size(noweTrasy);
       for j = 1:rozmiar(2)
       
           alreadyExists = any(cellfun(@(x) isequal(x, noweTrasy{j}), trasy));
   
           if ~alreadyExists
              trasy{end+1}=noweTrasy{j};%<-- tu dodaj� noweTrasy do cella trasy
           end
       
       end     
   end
  
   [ trasa, wspolrzPktPocz ] = idz( trasa, komorka, wspolrzPktPocz );
      
   end
   
   alreadyExists = any(cellfun(@(x) isequal(x, trasa), trasy));
   
   if ~alreadyExists
      trasy{end+1}=trasa;
   end
end

for k = 1:length(trasy)
    
    x=trasy{k}(:,2)
    y=trasy{k}(:,1)
 
    plot(x,y,'.', 'MarkerSize', 20);
    t=t+1;
    
    %automatyczna legenda
    S = sprintf('Trasa %d*', 1:t);
    C = regexp(S, '*', 'split');
    legend(C{:})
    
end

    %druk
    
    druki = cell(1,length(trasy));

    for k = 1:length(trasy)

    druk1 = [];
    druk2 = [];
    druk3 = [];
    kol = [];
    druk = [];   

        for l = 2:length(trasy{k})+1

            if l<=length(trasy{k})

            if trasy{k}(l-1,1:2)-1 == trasy{k}(l,1:2) %gdy po skosie
                druk1 = w1(trasy{k}(l-1,1)-1);
                druk3 = w2(trasy{k}(l-1,1)-1);
            end
            if trasy{k}(l-1,1:2)-[0 1] == trasy{k}(l,1:2) %gdy po pionie
                druk1 = '_';
                druk3 = w2(trasy{k}(l-1,1)-1); 
            end
            if trasy{k}(l-1,1:2)-[1 0] == trasy{k}(l,1:2) %gdy po poziomie
                druk1 = w1(trasy{k}(l-1,1)-1);
                druk3 = '_';
            end

                if druk1 == druk3
                   druk2 = '|';
                else
                   druk2 = ' ';
                end           

                kol = [druk1;druk2;druk3];
                druk = [druk kol];

            end
        end

        druk = fliplr(druk);
        druki{(k)} = druk;
    end
    
end
