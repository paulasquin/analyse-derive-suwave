clear; close all; clc;

logName = 'deriveDrone_4_Standard_2017-08-02-pm';%Nom du dossier o� se trouvent les fichier .ulg � �tudier
ventWindFinder = 2;
moyVit = 50;%Nombre de valeurs sur lesquelles sont moyenn�s la vitesse de d�placement GPS

[lat, lon, az, wind, compasX, compasY] = logsTreatment(logName);
[deb, fin] = indexSession(az);

lesLat = lat(deb(1):fin(1))';
lesLon = lon(deb(1):fin(1))';
lesAz = az(deb(1):fin(1))';
lesWind = wind(deb(1):fin(1))';
lesCompasX = compasX(deb(1):fin(1))';
lesCompasY = compasY(deb(1):fin(1))';

vitesssesMoy = calculVitesse(lat(deb(1):fin(1))', lon(deb(1):fin(1))', moyVit);

%afficher( lat, lon, az, wind )%Pour d�buggage

for i=1:length(deb) 
    lesLat = {lesLat, lat(deb(i):fin(i))'};%Cette m�thode pourrait �tre � l'origine de pb pour plus de 2 sessions par log. � v�rifier
    lesLon = {lesLon, lon(deb(i):fin(i))'};
    lesAz = {lesAz, az(deb(i):fin(i))'};
    lesWind = {lesWind, wind(deb(i):fin(i))'};
    lesCompasX = {lesCompasX, compasX(deb(i):fin(i))'};
    lesCompasY = {lesCompasY, compasY(deb(i):fin(i))'};
    
    vitessesMoy = calculVitesse(lat(deb(i):fin(i))', lon(deb(i):fin(i))', moyVit);
    
    afficher( lesLat{i}, lesLon{i}, lesAz{i}, lesWind{i}, vitessesMoy, lesCompasX{i}, lesCompasY{i}, i, ventWindFinder );%affichage des donn�es
end;

