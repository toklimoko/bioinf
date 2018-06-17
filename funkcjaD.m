function [ E, msg, figure1 ] = funkcjaD( w1, w2, okno, poziom, procent)

homolog = false;

%przeklejanie macierzy

if length(w1) > length(w2)
    diff=length(w1)-length(w2);
    for i=1:diff
        w2 = [w2 w2(i)];
    end
end


if length(w2) > length(w1)
    diff=length(w2)-length(w1);
    for i=1:diff
        w1 = [w1 w1(i)];
    end
end


%dotplot

tab = zeros(length(w1),length(w2));

for i=1:length(w1)
    for j=1:length(w2)
        if w2(j)==w1(i)
            tab(i,j)=1;
        end
    end
end


%filtracja

E = zeros(length(w1)); %nowa macierz

%pobieramy przek¹tne
for i=(-length(w1)+1):(length(w1)-1)
    
    %for i=4
    przekatna = diag(tab,i).'; %zapis przek¹tnej jako wektor
    
    %dorabianie przekatnych:
    licznikZer=0;
    
    if (i<0)
        
        for m=length(przekatna):(length(w1)-1)
            
            przekatna = [0 przekatna];
            licznikZer= licznikZer+1;
        end
        
    else if (i>0)
            
            licznikZer = length(przekatna);
            
            for n=length(przekatna):(length(w1)-1)
                
                przekatna = [przekatna 0];
                                
            end
        end
    end
    
    okienko =[];
    wektorZapisowy = zeros(1,length(przekatna));
    
    for granica=1:(length(przekatna)-okno+1) %ustalamy dystans punktu granicznego od którego zaczynamy pomiar
        
        t=0;
        for pkt=granica:(granica+okno-1) %w oknie
            
            okienko = [ okienko przekatna(pkt)];
            t=t+1; %znacznik
            
            if length(okienko)==okno

                if (sum(okienko)>=poziom)
                    
                    for e = 1:length(okienko)
                        
                        if (wektorZapisowy(granica+e-1)==0)
                            
                            wektorZapisowy(granica+e-1)=okienko(e);
                            
                        end
                        
                    end
                    
                end
                
                okienko =[];
                
            end
        end
    end
    
    
    %usuwanie nadmiaru w przekatnych:
    if (i<0)
        wektorZapisowy(1:licznikZer) = [];
        
    else if (i>0)
            wektorZapisowy(licznikZer+1:end) = [];
        end
        
    end
    D=diag(wektorZapisowy,i);
    
    E=E+D; %³¹czenie macierzy
    
end

%E=flipud(E)
E = sparse(E); %macierz rzadka

figure1 = figure;
spy(E);

title('Dotplot');
set(gca, 'YDir','reverse');
xlabel('sekwencja 1');ylabel('sekwencja 2');
legend('Punkty zgodnoœci');
%homolog:
H = sum(sum(E,1)); %sumowanie po kolumnach
p = double(procent) / 100;
if (H<=p*length(w1)*length(w2))
    homolog=true;
end

if homolog
    msg = 'Sekwencje homologiczne'
else
    msg = 'Sekwencje niehomologiczne'
end

end

