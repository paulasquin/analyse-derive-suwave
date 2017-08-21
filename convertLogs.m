function [names] = convertLogs(logName)
    
    close all; clc;
    homeDir = cd;%On r�cup�re le chemin actuel pour y revenir apr�s manip'
    cd(logName);%D�placement vers le dossier des fichiers ulog
    files = dir('*.ulg');%R�cup�ration des infos sur les fichiers .ulg

    [nFiles, ~] = size(files);
    names = {files.name};

    for i = 1:nFiles%Boucle dans les noms de fichiers
         nom = names{i};
         nom = nom(1:end-4);
         if exist([nom,'_vehicle_gps_position_0.csv'], 'file')~=2%si le fichier csv n'existe pas    
            command = ['ulog2csv.exe' ' ' names{i} ];
            disp(command);
            [status,cmdout] = system(command);

            if status == 1%Si on d�tecte une erreur dans l'ex�cution de la commande
                fprintf(['Le fichier ' names{i} '  n''a pas pu �tre d�compress�. Il est probablement corrompu (dernier fichier de log)\n']);
                names{i} = [];
            end;

            if length(findstr(cmdout, '''ulog2csv'' n''est pas reconnu')) ~= 0 %Si on d�tecte " 'ulog2csv' n'est pas reconnu " dans le message de retour (erreur fonction non trouv�)
                fprintf('L''application ulog2csv n''a pas �t� trouv�. Ex�cuter pip install pyulog pour r�soudre ce probl�me\n');
                break;
            end;
         else
            fprintf(['Le fichier ' names{i} '  est d�j� d�compress�.\n']);
         end;
    end;
    cd(homeDir);%Retour dossier de travail
end