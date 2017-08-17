function [deb, fin] = indexSession(az)
    %les indications de début et de fin de session sont marquées par le
    %secouement du drone. Ainsi des valeurs d'accélérations verticales (az)
    %suppérieur à 0 témoignent du début ou de la fin de d'une session de test.
    %Les débuts sont indentifiables par les données stables qui les suivent, les
    %fins sont marquées par un début successif non éloigné, ou la fin des
    %données

    secSess = 300;%On considère qu'une session de log est constitué d'au moins
    %5 minutes de données calmes.
    i = 1;
    iMax = length(az);
    deb = [];
    fin = [];
    boolDeb = true;
    valSec = 0;%Valeurs au delà et en dessous de laquelle on défini une secousse
    valBasSec = -15;
    
    while i < iMax
        if az(i) > valSec | az(i) < valBasSec%si on détecte un secouement 
            if i+secSess < iMax%si on est pas à la fin du fichier
                if (length(deb) <= length(fin))%si on cherche un début
                    j = i+1;
                    while j < i+secSess%on regarde si on a pas une fin de secousse plus loin
                        if az(j) > valSec | az(i) < valBasSec%ce n'était pas la fin de la secousse
                            i = j-1;%on décale l'index à cette secousse suivante pour poursuivre la recherche (-1 à cause de incrémentation fin)
                            boolDeb = false;%flag pas début de session
                            break;
                        end;
                        j = j+1;
                    end;%fin parcours détection pas début
                    if boolDeb%si on a pas détecté de secousse suivante
                        deb = [deb, i];% on a bien affaire à un début
                    else
                        boolDeb = true;%on reset notre flag
                    end;
                elseif(length(deb) > length(fin) & i > deb(end) + secSess )%on recherche une fin
                    if az(i) > valSec | az(i) < valBasSec%si on est sur une secousse
                        fin = [fin, i];% on ajoute cette valeur en tant que fin de session
                    end;
                end;%fin recherche début ou fin avant fin fichier
            %fin on est pas à la fin du fichier
            elseif(length(deb) > length(fin))% on est dans la fin du fichier et on cherche un fin. On recherche la première secousse qui est un fin
                for j=i:iMax
                    if az(j) > valSec | az(i) < valBasSec%si on est sur une secousse
                        fin = [fin, j];%ajout de la dernière fin de session
                        break;
                    end;
                end;%fin découverte dernière fin
                break;% on sort de la boucle
            end;%fin condition fin du fichier ou pas
        end;
        i = i+1;
    end;%fin while i<imax
    while (length(deb) > length(fin))%si on détecte plus de début que de fin
        deb(end) = [];%on supprime le dernier début
    end;
end