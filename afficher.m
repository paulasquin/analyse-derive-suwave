function [] = afficher(lat, lon, az, ventFiltre, vitessesMoy, compasX, compasY, num, ventWindFinder, ventNonFiltre, ventTresFiltre, vitessesNonFiltre)

    figure('Name',['D�placement pour session ' int2str(num)]);
    plot(lon(1), lat(1), '-s','MarkerSize',10,'MarkerEdgeColor','green', 'MarkerFaceColor',[1 .6 .6]);
    hold on;
    plot(lon, lat, 'r');
    plot(lon(end), lat(end), '-s','MarkerSize',10,'MarkerEdgeColor','blue', 'MarkerFaceColor',[1 .6 .6]);
    plot_google_map('MapType', 'satellite');
    
    %quiver(lon,lat,compasX,compasY);%Affichage des vents, pas pertinent
    %pour le moment, les donn�es ne sont pas facilement exploitable
    
    figure('Name',['Accel Z pour session ' int2str(num)]);
    plot(1:length(az), az);
    
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
        fprintf(['\nVent moyen tr�s filtr� pour session ' int2str(num) ' est ' num2str(moyVentTresFiltre) '\n']);
    end;
    
    
    
    figure('Name',['Vitesses pour session ' int2str(num)]);
    plot(1:length(vitessesNonFiltre), vitessesNonFiltre);
    hold on;
    plot(1:length(vitessesMoy), vitessesMoy, 'r', 'linewidth', 2);
    gigaMoy = mean(vitessesMoy);
    coefVents = gigaMoy / ventWindFinder;
    %fprintf([num2str(ventWindFinder) ' \n' ]);
    fprintf(['Vitesse moyenne pour session ' int2str(num) ' est ' num2str(gigaMoy) '\n']);
    fprintf(['Le coefficient des vents pour session ' int2str(num) ' est ' num2str( coefVents ) '\n']);

end