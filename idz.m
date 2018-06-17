function [ trasa, wspolrzPktPocz] = idz( trasa, komorka, wspolrzPktPocz) 

    %poruszanie si�
    if(komorka(2)==1 && wspolrzPktPocz(1)>=1 && wspolrzPktPocz(2)>=1) %je�li po skosie i nie dobi�o do pocz�tku macierzy punktow
        wspolrzPktPocz(1)=wspolrzPktPocz(1)-1;
        wspolrzPktPocz(2)=wspolrzPktPocz(2)-1;
        trasa=[trasa;wspolrzPktPocz];

    elseif(komorka(3)==1 && wspolrzPktPocz(2)>=1) %je�li po poziomie i jesli nie dobilo lewej strony
        wspolrzPktPocz(2)=wspolrzPktPocz(2)-1;
        trasa=[trasa;wspolrzPktPocz];

    elseif(komorka(4)==1 && wspolrzPktPocz(1)>=1) %je�li po pionie i jesli nie dobilo gory
        wspolrzPktPocz(1)=wspolrzPktPocz(1)-1;
        trasa=[trasa;wspolrzPktPocz];

    end    
    
end

