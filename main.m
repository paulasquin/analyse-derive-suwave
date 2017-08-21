clear; close all; clc;

logName = 'deriveDrone_4_Standard_2017-08-16-pm';%Nom du dossier où se trouvent les fichier .ulg à étudier
ventWindFinder = 6;
moyVit = 50;%Nombre de valeurs sur lesquelles sont moyennés la vitesse de déplacement GPS
moyVent = 50;

[lat, lon, az, wind, compasX, compasY] = logsTreatment(logName);
[deb, fin] = indexSession(az);

for i=1:length(deb) 
    lesLat{i} = lat(deb(i):fin(i))';
    lesLon{i} = lon(deb(i):fin(i))';
    lesAz{i} = az(deb(i):fin(i))';
    lesWind{i} = wind(deb(i):fin(i))';
    lesCompasX{i} = compasX(deb(i):fin(i))';
    lesCompasY{i} = compasY(deb(i):fin(i))';
    
    [vitessesMoy{i}, vitessesNonFiltre{i}] = calculVitesse(lat(deb(i):fin(i))', lon(deb(i):fin(i))', moyVit);
    lesVents{i} = filtrage(lesWind{i}(lesWind{i}~=0), 0.005);
    
    %lesVents{i} = filtreVent(lesWind{i}(lesWind{i}~=0), moyVent);
    ventTresFiltre{i} = filtrage(lesWind{i}(lesWind{i}~=0), 0.0005);
    ventNonFiltre{i} = lesWind{i}(lesWind{i}~=0);
    
    afficher( lesLat{i}, lesLon{i}, lesAz{i}, lesVents{i}, vitessesMoy{i}, lesCompasX{i}, lesCompasY{i}, i, ventWindFinder, ventNonFiltre{i}, ventTresFiltre{i}, vitessesNonFiltre{i} );%affichage des données
end;
