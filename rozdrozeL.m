function [ noweTrasy ] = rozdrozeL( E, wspolrzPktPocz, kopieTras, macierzPunktow )

noweTrasy = {};
rozmiar = length(kopieTras);
wspolrzPktPoczKopia = wspolrzPktPocz;

for i=1:rozmiar %tyle, ile rozdro¿y
    
    trasa = kopieTras{i};
    
    %wspolrzPktPoczKopia = wspolrzPktPocz
    
    while (macierzPunktow(wspolrzPktPoczKopia(1),wspolrzPktPoczKopia(2))~=0) %poruszanie a¿ do (1,1)
        
        komorka = E{wspolrzPktPoczKopia(1), wspolrzPktPoczKopia(2)};
        
         [ trasa, wspolrzPktPoczKopia ] = idz( trasa, komorka, wspolrzPktPoczKopia );
    end
    
   noweTrasy{end+1}=trasa;
   
   wspolrzPktPoczKopia = wspolrzPktPocz;

end
    
end
    



