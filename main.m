clc
clear all
close all
z = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

C =  CalculadoraCosmologica();
Tiempo = C.t(z);
Sigma = C.s(z);
%plot(z,Sigma);
%title('Sigma frente a z')

