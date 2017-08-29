function [filtre] = filtrage(nonFiltre, Fc)
% Filtre Butterworth (appliqué dans les deux directions pour éliminer déphasage et doubler ordre)

    T = 1; % Sampling period
    Fs = 1/T; % Sampling frequency
    %Fc = 0.005; % Cut-off frequency
    n_filt =6; % Filter order

    %[bb,ab] = butter(n_filt,Fc/Fs*2*pi); % la fréquence de coupure est spécifiée en rad/sample
    [bb,ab] = butter(n_filt,Fc/(Fs/2)); % la fréquence de coupure est spécifiée en rad/sample

    filtre = filtfilt(bb,ab,nonFiltre);
    
end