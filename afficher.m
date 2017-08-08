function [] = afficher(lat, lon, az, wind, vitessesMoy, compasX, compasY, num, ventWindFinder)
    figure('Name',['Déplacement pour session ' int2str(num)]);
    hold on;
    plot(lon(1), lat(1), '-s','MarkerSize',10,'MarkerEdgeColor','green', 'MarkerFaceColor',[1 .6 .6]);
    plot(lon, lat, 'r');
    plot(lon(end), lat(end), '-s','MarkerSize',10,'MarkerEdgeColor','blue', 'MarkerFaceColor',[1 .6 .6]);
    plot_google_map('MapType', 'satellite');
    
    %quiver(lon,lat,compasX,compasY);%Affichage des vents, pas pertinent
    %pour le moment, les données ne sont pas facilement exploitable
    
%     figure('Name',['Accel Z pour session ' int2str(num)]);
%     hold on;
%     plot(1:length(az), az);
%     
%     figure('Name',['Vents pour session ' int2str(num)]);
%     vents = wind(wind~=0);
%     plot(1:length(vents), vents);
%     fprintf(['Vent moyen pour session ' int2str(num) ' est ' num2str(mean(vents)) '\n']);
%     
    figure('Name',['Vitesses pour session ' int2str(num)]);
    plot(1:length(vitessesMoy), vitessesMoy);
    gigaMoy = mean(vitessesMoy);
    coefVents = gigaMoy / ventWindFinder;
    fprintf([num2str(ventWindFinder) ' \n' ]);
    fprintf(['Vitesse moyenne pour session ' int2str(num) ' est ' num2str(gigaMoy) '\n']);
    fprintf(['Le coefficient des vents pour session ' int2str(num) ' est ' num2str( coefVents ) '\n']);

end