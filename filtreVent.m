function [ventsMoy] = filtreVent(vent, moy)
    
    ventsMoy = [];
    for i=1:moy:length(vent)-moy-1%D�coupage des donn�es en sous longueurs "moy"        
        sousVents = vent(i:i+moy);
        for k=1:moy%Ajout de moy fois la valeur moyenn� pour garder les abs correspondants
            ventsMoy = [ventsMoy, mean(sousVents)];%Ajout du moyennage des vitesses de la sous longueur
        end;
        
    end;
end