function [filtre] = filtrage(nonFiltre, Fc)
% Filtre Butterworth (appliqu� dans les deux directions pour �liminer d�phasage et doubler ordre)

    T = 1; % Sampling period
    Fs = 1/T; % Sampling frequency
    %Fc = 0.005; % Cut-off frequency
    n_filt =6; % Filter order

    %[bb,ab] = butter(n_filt,Fc/Fs*2*pi); % la fr�quence de coupure est sp�cifi�e en rad/sample
    [bb,ab] = butter(n_filt,Fc/(Fs/2)); % la fr�quence de coupure est sp�cifi�e en rad/sample

    filtre = filtfilt(bb,ab,nonFiltre);
    
end