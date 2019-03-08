clc
clear all
close all
z = linspace(0,100,1000); % Redshift

% A partir de aquí los comentarios que no aparezcan en mayúsculas son parte
% del código, que se ha comentado para no obtener todos los plots a la vez

% OBJETO C DE LA CLASE CALCULADORA COSMOLÓGICA                                   
C =  CalculadoraCosmologica();
DistanciaLuminosidad = C.dL(z);
DistanciaAngular = C.dA(z);
                                                                                        
% REPRESENTACIÓN DISTANCIA DIÁMETRO ANGULAR FRENTE A Z
%figure(1)
%plot(z,DistanciaAngular);
%xlabel('z')
%ylabel('d_A / Mpc')

% REPRESENTACIÓN DISTANCIA DE LUMINOSIDAD FRENTE A Z
%figure(2)
%plot(z,DistanciaLuminosidad);
%xlabel('z')
%ylabel('d_L / Mpc')

% FACTOR DE ESCALA
FE = C.at();
FE1 = C.at1();
FE2 = C.at2();
FE3 = C.at3();
FE4 = C.at4();
%figure (3)
%plot(FE(:,1),FE(:,2),FE1(:,1),FE1(:,2),FE2(:,1),FE2(:,2),FE3(:,1),FE3(:,2),FE4(:,1),FE4(:,2))
%legend('Observado','Einstein - de Sitter','Radiación', 'de Sitter','Milne')
%xlabel('t / Gy')
%ylabel('a(t)')
% EN ESTE PLOT t = 0 ES EL MOMENTO ACTUAL

% PARÁMETRO DE HUBBLE
PH = C.Ht();
PH1 = C.Ht1();
PH2 = C.Ht2();
PH3 = C.Ht3();
PH4 = C.Ht4();
% TIEMPOS: SE SACAN A PARTIR DE LA PRIMERA COLUMNA DE LA MATRIZ FE.
t = FE(:,1);
%figure (4)
%plot(t,PH,t,PH1,t,PH2,t,PH3,t,PH4)
%xlabel('t / Gy')
%ylabel('H(t) / Gy^-^1')
%legend('Observado','Einstein - de Sitter','Radiacion','de Sitter','Milne')

% RADIO DE HUBBLE
Radio = C.R();
Radio1 = C.R1();
Radio2 = C.R2();
Radio3= C.R3();
Radio4 = C.R4();
%figure (5)
%plot(t,Radio,t,Radio1,t,Radio2,t,Radio3,t,Radio4)
%xlabel('t / Gy')
%ylabel('R_H(t) / Mpc')
%legend('Observado','Einstein - de Sitter','Radiacion','de Sitter','Milne')

% HORIZONTE DE PARTÍCULAS
Horizonte = C.HP();
Horizonte1 = C.HP1();
Horizonte2 = C.HP2();
Horizonte3 = C.HP3();
Horizonte4 = C.HP4();
%figure (6)
%plot(t,Horizonte,t,Horizonte1,t,Horizonte2,t,Horizonte3,t,Horizonte4);
%xlabel('t / Gy')
%ylabel('H_P(t) / Mpc')
%legend('Observado','Einstein - de Sitter','Radiacion','de Sitter','Milne')

% EDAD DEL UNIVERSO EN FUNCIÓN DE Z
EdadUniverso = C.t(z);
EdadUniverso1 = C.t1(z);
EdadUniverso2 = C.t2(z);
EdadUniverso3 = C.t3(z);
EdadUniverso4 = C.t4(z);
figure (7)
plot(z,EdadUniverso,z,EdadUniverso1,z,EdadUniverso2,z,EdadUniverso3,z,EdadUniverso4);
xlabel('z')
ylabel('t(z)')
legend('Observado','Einstein - de Sitter','Radiacion','de Sitter','Milne')
% CASO PARTICULAR: EDAD ACTUAL DEL UNIVERSO                      
z1 = inf;
EdadUniverso = C.t(z1)
%EdadUniverso1 = C.t1(z1)
%EdadUniverso2 = C.t2(z1)
%EdadUniverso3 = C.t3(z1)
%EdadUniverso4 = C.t4(z1)





