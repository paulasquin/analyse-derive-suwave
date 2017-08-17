function [deb, fin] = indexSession(az)
    %les indications de d�but et de fin de session sont marqu�es par le
    %secouement du drone. Ainsi des valeurs d'acc�l�rations verticales (az)
    %supp�rieur � 0 t�moignent du d�but ou de la fin de d'une session de test.
    %Les d�buts sont indentifiables par les donn�es stables qui les suivent, les
    %fins sont marqu�es par un d�but successif non �loign�, ou la fin des
    %donn�es

    secSess = 300;%On consid�re qu'une session de log est constitu� d'au moins
    %5 minutes de donn�es calmes.
    i = 1;
    iMax = length(az);
    deb = [];
    fin = [];
    boolDeb = true;
    valSec = 0;%Valeurs au del� et en dessous de laquelle on d�fini une secousse
    valBasSec = -15;
    
    while i < iMax
        if az(i) > valSec | az(i) < valBasSec%si on d�tecte un secouement 
            if i+secSess < iMax%si on est pas � la fin du fichier
                if (length(deb) <= length(fin))%si on cherche un d�but
                    j = i+1;
                    while j < i+secSess%on regarde si on a pas une fin de secousse plus loin
                        if az(j) > valSec | az(i) < valBasSec%ce n'�tait pas la fin de la secousse
                            i = j-1;%on d�cale l'index � cette secousse suivante pour poursuivre la recherche (-1 � cause de incr�mentation fin)
                            boolDeb = false;%flag pas d�but de session
                            break;
                        end;
                        j = j+1;
                    end;%fin parcours d�tection pas d�but
                    if boolDeb%si on a pas d�tect� de secousse suivante
                        deb = [deb, i];% on a bien affaire � un d�but
                    else
                        boolDeb = true;%on reset notre flag
                    end;
                elseif(length(deb) > length(fin) & i > deb(end) + secSess )%on recherche une fin
                    if az(i) > valSec | az(i) < valBasSec%si on est sur une secousse
                        fin = [fin, i];% on ajoute cette valeur en tant que fin de session
                    end;
                end;%fin recherche d�but ou fin avant fin fichier
            %fin on est pas � la fin du fichier
            elseif(length(deb) > length(fin))% on est dans la fin du fichier et on cherche un fin. On recherche la premi�re secousse qui est un fin
                for j=i:iMax
                    if az(j) > valSec | az(i) < valBasSec%si on est sur une secousse
                        fin = [fin, j];%ajout de la derni�re fin de session
                        break;
                    end;
                end;%fin d�couverte derni�re fin
                break;% on sort de la boucle
            end;%fin condition fin du fichier ou pas
        end;
        i = i+1;
    end;%fin while i<imax
    while (length(deb) > length(fin))%si on d�tecte plus de d�but que de fin
        deb(end) = [];%on supprime le dernier d�but
    end;
end