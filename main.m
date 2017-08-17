clear; close all; clc;

logName = 'deriveDrone_2_Standard_2017-08-16-pm';%Nom du dossier o� se trouvent les fichier .ulg � �tudier
ventWindFinder = 5;
moyVit = 50;%Nombre de valeurs sur lesquelles sont moyenn�s la vitesse de d�placement GPS
moyVent = 50;

[lat, lon, az, wind, compasX, compasY] = logsTreatment(logName);
[deb, fin] = indexSession(az);

% vitessesMoy = [];
% lesCompasX = [];
% lesCompasY = [];
% afficher( lat, lon, az, wind, vitessesMoy, lesCompasX, lesCompasY, 0, ventWindFinder )%Pour d�buggage

lesLat = lat(deb(1):fin(1))';
lesLon = lon(deb(1):fin(1))';
lesAz = az(deb(1):fin(1))';
lesWind = wind(deb(1):fin(1))';
lesCompasX = compasX(deb(1):fin(1))';
lesCompasY = compasY(deb(1):fin(1))';

vitessesMoy = calculVitesse(lat(deb(1):fin(1))', lon(deb(1):fin(1))', moyVit);

lesVents = filtreVent(lesWind(lesWind~=0), moyVent);

for i=1:length(deb) 
    lesLat = {lesLat, lat(deb(i):fin(i))'};%Cette m�thode pourrait �tre � l'origine de pb pour plus de 2 sessions par log. � v�rifier
    lesLon = {lesLon, lon(deb(i):fin(i))'};
    lesAz = {lesAz, az(deb(i):fin(i))'};
    lesWind = {lesWind, wind(deb(i):fin(i))'};
    lesCompasX = {lesCompasX, compasX(deb(i):fin(i))'};
    lesCompasY = {lesCompasY, compasY(deb(i):fin(i))'};
    
    vitessesMoy = calculVitesse(lat(deb(i):fin(i))', lon(deb(i):fin(i))', moyVit);
    lesVents = {lesVents, filtreVent(lesWind{i}(lesWind{i}~=0), moyVent)};
    
    afficher( lesLat{i}, lesLon{i}, lesAz{i}, lesVents{i}, vitessesMoy, lesCompasX{i}, lesCompasY{i}, i, ventWindFinder );%affichage des donn�es
end;



