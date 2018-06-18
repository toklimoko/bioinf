function [ E, macierzPunktow, fig, trasy, druki, msg ] = funkcjaL( w1, w2, kara, nagroda, brak )
t=0;
%ustalenie kary na ujemn�:
if kara>0
    kara = kara*-1;
end

%tworzenie punkt�w pocz�tkowych
zerosRow = zeros(1,length(w2)+1);
zerosColumn = zeros(1,length(w1)).';
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
            
            if (macierzPunktow(i-1,j-1)+n)<0
            macierzPunktow(i, j)=0;
            else
            macierzPunktow(i, j)=macierzPunktow(i-1,j-1)+n; 
            end
           
            wynik = [wynik 1];
        else
            wynik = [wynik 0]; %gdy nie po skosie
        end     
        
        if(max(macierzPunktow(i-1,j-1)+n,max(macierzPunktow(i-1,j)+kara,macierzPunktow(i,j-1)+kara))==macierzPunktow(i,j-1)+kara) %gdy poziomo:
            
            if (macierzPunktow(i,j-1)+kara)<0
            macierzPunktow(i, j)=0;
            else
            macierzPunktow(i, j)=macierzPunktow(i,j-1)+kara;
            end
            
            wynik = [wynik 1];
        else
            wynik = [wynik 0]; %gdy nie poziomo
        end       
        
        if(max(macierzPunktow(i-1,j-1)+n,max(macierzPunktow(i-1,j)+kara,macierzPunktow(i,j-1)+kara))==macierzPunktow(i-1,j)+kara) %gdy pionowo:

            if (macierzPunktow(i-1,j)+kara)<0
            macierzPunktow(i, j)=0;
            else
            macierzPunktow(i, j)=macierzPunktow(i-1,j)+kara;
            end
             
            wynik = [wynik 1];
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
fig=figure('Name','Local matching');
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
    
    
   while (macierzPunktow(wspolrzPktPocz(1),wspolrzPktPocz(2))~=0) %poruszanie a� do 0
       
       komorka = E{wspolrzPktPocz(1), wspolrzPktPocz(2)};
          
   if komorka(7) >1 %je�li rozdro�e
      
       kopieTras = {}; % czyszcz� cella z kopiami tras
       
       for j = 1:komorka(7)
           kopieTras{end+1} = trasa; %tu kopiuj� obecn� tras� do cella kopieTras tyle razy, ile rozdrozy + 1 (do kopieTras)
       end
       
       [noweTrasy] = rozdrozeL(E, wspolrzPktPocz, kopieTras, macierzPunktow); %<-- ustalam lokalizacje pocz�tkow� jako lok rozdroza (punkt startowy dla funkcji)

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
   
%    trasa=trasa(1:end-1,:)
   
   alreadyExists = any(cellfun(@(x) isequal(x, trasa), trasy));
   
   if ~alreadyExists
       
      trasy{end+1}=trasa;
   end
end

%M = zeros(length(w1)+1,length(w2)+1);
M = cell(length(w1)+1,length(w2)+1);

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
    wektorA=[];
    wektorB=[];
    
    
    for k = 1:length(trasy) %wyb�r trasy

    druk1 = [];
    druk2 = [];
    druk3 = [];
    kol = [];
    druk = []; 

    wydluzenie = 0;

    
    dlugoscTrasy = length(trasy{k});
    
        for l = 2:dlugoscTrasy+1+wydluzenie %wyb�r punktu na trasie

            if l<=length(trasy{k})

                if trasy{k}(l-1,1:2)-1 == trasy{k}(l,1:2) %gdy po skosie

                    druk1 = w1(trasy{k}(l-1,1)-1);
                    druk2 = ' ';
                    druk3 = w2(trasy{k}(l-1,1)-1);
                end
                if trasy{k}(l-1,1:2)-[0 1] == trasy{k}(l,1:2) %gdy po pionie
                    druk1 = '_';
                    druk2 = ' ';
                    druk3 = w2(trasy{k}(l-1,1)-1); 
                    wydluzenie = wydluzenie+1;
                end
                if trasy{k}(l-1,1:2)-[1 0] == trasy{k}(l,1:2) %gdy po poziomie
                    druk1 = w1(trasy{k}(l-1,1)-1);
                    druk2 = ' ';
                    druk3 = '_';
                    wydluzenie = wydluzenie+1;
                end

  
                    a = trasy{k}(l-1,1)-1;
                    b = trasy{k}(l-1,2)-1;
                    
                    
                    kol = [druk1;druk2;druk3];
                    druk = [druk kol];
                    druki{(k)} = druk;
                    
                    
            end
               
        end

        wektorA = [wektorA a];
        wektorB = [wektorB b];

    end

    for k = 1:length(trasy)
        
        
        a = wektorA(k);
        b = wektorB(k);
        roznica = a-b;
        if (roznica~=0)
        
                druk1 = '';
                druk2 = '';
                druk3 = '';


                if a~=1
                   for ii=1:(a-1)

                           druk1 = [druk1 w1(end)];
                           druk2 = [' ' druk2];
                           druk3 = ['_' druk3];
                           
                            kol = [druk1;druk2;druk3];
                            druk = [druk kol];
                            druk = fliplr(druk);                           
                          druk(1,:) = circshift(druk(1,:), [0 -1]);
                   end
                   druk=fliplr(druk);
                   
                     for jj=1:length(druk)
                        
                    
                        if (druk(1,jj)==druk(3,jj))
                            druk(2,jj)='|';
                        end

                    end
                end
         
                if b~=1
                   for ii=1:(b-1)
                           druk1 = ['_' druk1];
                           druk2 = [' ' druk2];
                           druk3 = [druk3 w2(end)];

                           kol = [druk1;druk2;druk3];
                           druk = [druk kol];
                           druk = fliplr(druk);                         
                          druk(3,:) = circshift(druk(3,:), [0 -1]);
                   end
                   druk=fliplr(druk);
                
                
                        for jj=1:length(druk)


                            if (druk(1,jj)==druk(3,jj))
                                druk(2,jj)='|';
                            end

                        end
                end
%          if znacznik
%              druk=flipud(druk);
%          end    
                
        end
        
        for jj=1:length(druk)-1


            if (druk(1,jj)==druk(3,jj))
            druk(2,jj)='|';
            end

        end
    
        
        druk=fliplr(druk);
        druki{(k)} = druk;
    end
    
    
    for kk=1:length(druki)
        wydruk = druki{kk}    
        zmienna = trasy{kk}(3,1:2);
        msg = ['Zatrzymanie nast�pi�o w punkcie ',num2str(zmienna)]
    end
    


    
end
               
      