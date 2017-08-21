function [lat, lon, az, wind, compasX, compasY] = logsTreatment(logName)
    names = convertLogs(logName);%R�cup�ration des noms de fichier log exploitable
    nLogs = length(names);
    
    gpsTime_raw = [];
    lat  = [];
    lon  = [];
    sensorsTime = [];
    az = [];
    airspeedTime = [];
    wind = [];
    compasX = [];
    compasY = [];
    
    for i = 1:nLogs
        nom = names{i};%r�cup�ration du nom en str
        if ~isempty(nom)%On v�rifie que le nom n'a pas �t� annul� car corrompu
            nom = nom(1:end-4);%on enl�ve l'extension .ulg
            gps = csvread([logName, '\', nom, '_vehicle_gps_position_0.csv'],1,0);
            sensors = csvread([logName, '\', nom, '_sensor_combined_0.csv'],1,0);
            sensorsTime = [sensorsTime', sensors(:,1)']';
            az = [az', sensors(:,9)']';
            
            if exist([logName, '\', nom,'_airspeed_0.csv'], 'file')==2
                airspeed = csvread([logName, '\', nom,'_airspeed_0.csv'],1,0);
                airspeedTime = [airspeedTime', airspeed(:,1)']';
                wind = [wind', airspeed(:,3)']';
            else
                wind = zeros(1, length(az));
                disp('Pas de donn�es vent');
            end;
            
            gpsTime_raw = [gpsTime_raw', gps(:,2)'-14.4*10^9 ]';%Concat�nation des colonnes avec les nouvelles donn�es

            lat = [lat', gps(:,3)'/10^7]';%Diff�renciation entre d�cimales et entiers de la donn�e GPS
            lon = [lon', gps(:,4)'/10^7]';
            
            compasX = [compasX', sensors(:,12)']';
            compasY = [compasY', sensors(:,13)']';
            
        end;
        gpsTime = datevec(datenum(1970,1,1)+gpsTime_raw/1000000/86400);%R�cup�ration du temps au format classique � partir du brut gps
    end;%fin r�cup�ration et concat�nation des donn�es
end