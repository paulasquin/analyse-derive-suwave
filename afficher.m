function [] = afficher(lat, lon, az, ventFiltre, vitessesMoy, compasX, compasY, num, ventWindFinder, ventNonFiltre, ventTresFiltre, vitessesNonFiltre)

    figure('Name',['Déplacement pour session ' int2str(num)]);
    plot(lon(1), lat(1), '-s','MarkerSize',10,'MarkerEdgeColor','green', 'MarkerFaceColor',[1 .6 .6]);
    hold on;
    plot(lon, lat, 'r');
    plot(lon(end), lat(end), '-s','MarkerSize',10,'MarkerEdgeColor','blue', 'MarkerFaceColor',[1 .6 .6]);
    plot_google_map('MapType', 'satellite');
    
    disp(length(lat));
    disp(length(compasY));
    
    
    quiver(lon,lat,compasX,compasY);%Affichage des vents, pas pertinent
    %pour le moment, les données ne sont pas facilement exploitable
    
    figure('Name',['Accel Z pour session ' int2str(num)]);
    plot(1:length(az), az);
    
    gigaMoy = mean(vitessesMoy);
    fprintf(['Vitesse moyenne pour session ' int2str(num) ' est ' num2str(gigaMoy) '\n']);
    
    if length(ventFiltre) == 0
        fprintf(['\nPas de vent non nul pour session ' int2str(num) '\n']);
        ventMoy = ventWindFinder;
        fprintf(['On prend la moyenne des vents WindFinder =  ' int2str(ventMoy) ' pour session' int2str(num) '\n']);
    else
        figure('Name',['Vents pour session ' int2str(num)]);
        plot(1:length(ventNonFiltre), ventNonFiltre);
        hold on;
        plot(1:length(ventFiltre), ventFiltre, 'r', 'linewidth', 2);
        hold on;
        plot(1:length(ventTresFiltre), ventTresFiltre, 'g', 'linewidth', 2);
        moyVentTresFiltre = mean(ventTresFiltre);
        fprintf(['\nVent moyen très filtré pour session ' int2str(num) ' est ' num2str(moyVentTresFiltre) '\n']);
        
        for i=1:length(ventTresFiltre)
            coefsVentsPitot(i) = vitessesMoy(i)/ventTresFiltre(i);
        end;
        
        figure('Name', [ 'Coefs des vitesses Deplacement/Pitot pour session' int2str(num) ] );
        plot(1:length(coefsVentsPitot), coefsVentsPitot);
        
        moyCoefsVentsPitot = mean(coefsVentsPitot);
        fprintf(['Le coefficient des vitesses moyen à partir de Pitot pour la session ' int2str(num) ' est ' num2str( moyCoefsVentsPitot ) '\n']);
    end;
    
    figure('Name',['Vitesses pour session ' int2str(num)]);
    plot(1:length(vitessesNonFiltre), vitessesNonFiltre);
    hold on;
    plot(1:length(vitessesMoy), vitessesMoy, 'r', 'linewidth', 2);
    
    coefVentsWindfinder = gigaMoy / ventWindFinder;
    fprintf(['Le coefficient des vitesses à partir de Windfinder pour la session ' int2str(num) ' est ' num2str( coefVentsWindfinder ) '\n']);

end