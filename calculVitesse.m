function [vitessesMoy, vitessesNonFiltre] = calculVitesseMoy(lat, lon, moy)
    
    vitessesMoy = [];
    vitessesNonFiltre = [];
    for i=1:moy:length(lat)-moy-1%Découpage des données en sous longueurs "moy"
        sousVitesses = [];
        for j=i:i+moy%Moyennage sur la sous longueur
            B2 = lat(j)/180*pi;
            C2 = lon(j)/180*pi;
            B3 = lat(j+1)/180*pi;
            C3 = lon(j+1)/180*pi;
            vitesse=abs(acos( sin(B2)*sin(B3) + cos(B2)*cos(B3)*cos(C2-C3) )*6371*1000);%vitesse = distance car log toutes les 1sec
            sousVitesses = [sousVitesses, vitesse];
        end;
%         for k=1:moy%Ajout de moy fois la valeur moyenné pour garder les abs correspondants
%             vitessesMoy = [vitessesMoy, mean(sousVitesses)];%Ajout du moyennage des vitesses de la sous longueur
%         end;
        
        vitessesMoy = [vitessesMoy, filtrage(sousVitesses, 0.05)];
        vitessesNonFiltre = [vitessesNonFiltre, sousVitesses];
    end;
end