function [ noweTrasy ] = rozdrozeG( E, wspolrzPktPocz, kopieTras )

noweTrasy = {};
rozmiar = length(kopieTras);
wspolrzPktPoczKopia = wspolrzPktPocz;

for i=1:rozmiar %tyle, ile rozdro¿y
    
    trasa = kopieTras{i};
    
    %wspolrzPktPoczKopia = wspolrzPktPocz
    
    while (wspolrzPktPoczKopia(1)~=1 && wspolrzPktPoczKopia(2)~=1) %poruszanie a¿ do (1,1)
        
        komorka = E{wspolrzPktPoczKopia(1), wspolrzPktPoczKopia(2)};
        
         [ trasa, wspolrzPktPoczKopia ] = idz( trasa, komorka, wspolrzPktPoczKopia );
    end
    
   noweTrasy{end+1}=trasa;
   
   wspolrzPktPoczKopia = wspolrzPktPocz;

end
    
end
    



