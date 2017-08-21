function [names] = convertLogs(logName)
    
    close all; clc;
    homeDir = cd;%On récupère le chemin actuel pour y revenir après manip'
    cd(logName);%Déplacement vers le dossier des fichiers ulog
    files = dir('*.ulg');%Récupération des infos sur les fichiers .ulg

    [nFiles, ~] = size(files);
    names = {files.name};

    for i = 1:nFiles%Boucle dans les noms de fichiers
         nom = names{i};
         nom = nom(1:end-4);
         if exist([nom,'_vehicle_gps_position_0.csv'], 'file')~=2%si le fichier csv n'existe pas    
            command = ['ulog2csv.exe' ' ' names{i} ];
            disp(command);
            [status,cmdout] = system(command);

            if status == 1%Si on détecte une erreur dans l'exécution de la commande
                fprintf(['Le fichier ' names{i} '  n''a pas pu être décompressé. Il est probablement corrompu (dernier fichier de log)\n']);
                names{i} = [];
            end;

            if length(findstr(cmdout, '''ulog2csv'' n''est pas reconnu')) ~= 0 %Si on détecte " 'ulog2csv' n'est pas reconnu " dans le message de retour (erreur fonction non trouvé)
                fprintf('L''application ulog2csv n''a pas été trouvé. Exécuter pip install pyulog pour résoudre ce problème\n');
                break;
            end;
         else
            fprintf(['Le fichier ' names{i} '  est déjà décompressé.\n']);
         end;
    end;
    cd(homeDir);%Retour dossier de travail
end