clear; close all; clc;

logName = 'deriveDrone_2_Standard_2017-08-16-pm';%Nom du dossier où se trouvent les fichier .ulg à étudier
ventWindFinder = 5;
moyVit = 50;%Nombre de valeurs sur lesquelles sont moyennés la vitesse de déplacement GPS
moyVent = 50;

[lat, lon, az, wind, compasX, compasY] = logsTreatment(logName);
[deb, fin] = indexSession(az);

% vitessesMoy = [];
% lesCompasX = [];
% lesCompasY = [];
% afficher( lat, lon, az, wind, vitessesMoy, lesCompasX, lesCompasY, 0, ventWindFinder )%Pour débuggage

lesLat = lat(deb(1):fin(1))';
lesLon = lon(deb(1):fin(1))';
lesAz = az(deb(1):fin(1))';
lesWind = wind(deb(1):fin(1))';
lesCompasX = compasX(deb(1):fin(1))';
lesCompasY = compasY(deb(1):fin(1))';

vitessesMoy = calculVitesse(lat(deb(1):fin(1))', lon(deb(1):fin(1))', moyVit);

lesVents = filtreVent(lesWind(lesWind~=0), moyVent);

for i=1:length(deb) 
    lesLat = {lesLat, lat(deb(i):fin(i))'};%Cette méthode pourrait être à l'origine de pb pour plus de 2 sessions par log. À vérifier
    lesLon = {lesLon, lon(deb(i):fin(i))'};
    lesAz = {lesAz, az(deb(i):fin(i))'};
    lesWind = {lesWind, wind(deb(i):fin(i))'};
    lesCompasX = {lesCompasX, compasX(deb(i):fin(i))'};
    lesCompasY = {lesCompasY, compasY(deb(i):fin(i))'};
    
    vitessesMoy = calculVitesse(lat(deb(i):fin(i))', lon(deb(i):fin(i))', moyVit);
    lesVents = {lesVents, filtreVent(lesWind{i}(lesWind{i}~=0), moyVent)};
    
    afficher( lesLat{i}, lesLon{i}, lesAz{i}, lesVents{i}, vitessesMoy, lesCompasX{i}, lesCompasY{i}, i, ventWindFinder );%affichage des données
end;



