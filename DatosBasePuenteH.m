%Datos base Puente H
D = 0.2;
Vcont=-0.6;%señal de control
fs=10e3;%Frecuencia conmutación portadora triangular
Ts=1/fs;
Tmuertos=0;%Tiempo muerto

%Config. simulación
nciclos=700;%nº ciclos a simular
ssamples=200;%nº muestras por periodo para paso de simulación discreto
