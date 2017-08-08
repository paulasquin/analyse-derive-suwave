clear all; close all; clc;

logName = 'deriveDrone_2_Standard_2017-08-02';%Dossier des fichiers ulog

homeDir = cd;

cd(logName);
files = dir('*.ulg');
[nFiles, ~] = size(files);
names = {files.name};

for i = 1:nFiles
    fprintf(names{i});
    fprintf('\n');
end

cd(homeDir);
