function [ trasa, wspolrzPktPocz] = idz( trasa, komorka, wspolrzPktPocz) 

    %poruszanie siê
    if(komorka(2)==1 && wspolrzPktPocz(1)>=1 && wspolrzPktPocz(2)>=1) %jeœli po skosie i nie dobi³o do pocz¹tku macierzy punktow
        wspolrzPktPocz(1)=wspolrzPktPocz(1)-1;
        wspolrzPktPocz(2)=wspolrzPktPocz(2)-1;
        trasa=[trasa;wspolrzPktPocz];

    elseif(komorka(3)==1 && wspolrzPktPocz(2)>=1) %jeœli po poziomie i jesli nie dobilo lewej strony
        wspolrzPktPocz(2)=wspolrzPktPocz(2)-1;
        trasa=[trasa;wspolrzPktPocz];

    elseif(komorka(4)==1 && wspolrzPktPocz(1)>=1) %jeœli po pionie i jesli nie dobilo gory
        wspolrzPktPocz(1)=wspolrzPktPocz(1)-1;
        trasa=[trasa;wspolrzPktPocz];

    end    
    
end

