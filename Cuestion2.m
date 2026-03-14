clear; clc; close all;

%% Datos base
VI = 15;
fs = 10e3;
Ts = 1/fs;
Tmuertos = 0;

nciclos = 700;
ssamples = 200;

Dvec = [0 0.05:0.05:0.95 1];

Vr_bip = zeros(size(Dvec));
Vr_uni = zeros(size(Dvec));

model = 'PuenteH_dcdc_CUESTION2';
load_system(model);

StopTime = num2str(nciclos*Ts);

for k = 1:length(Dvec)

    D = Dvec(k);
    Vcont = 2*D - 1;

    assignin('base','VI',VI);
    assignin('base','fs',fs);
    assignin('base','Ts',Ts);
    assignin('base','Tmuertos',Tmuertos);
    assignin('base','nciclos',nciclos);
    assignin('base','ssamples',ssamples);
    assignin('base','D',D);
    assignin('base','Vcont',Vcont);

    %% Bipolar
    seleccion = 1;
    assignin('base','seleccion',seleccion);

    simOut = sim(model,'StopTime',StopTime);
    V = simOut.VAB;
    vab = V.signals.values;

    Vmed = mean(vab);
    vr   = vab - Vmed;
    Vr_bip(k) = sqrt(mean(vr.^2));

    %% Unipolar
    seleccion = 2;
    assignin('base','seleccion',seleccion);

    simOut = sim(model,'StopTime',StopTime);
    V = simOut.VAB;
    vab = V.signals.values;

    Vmed = mean(vab);
    vr   = vab - Vmed;
    Vr_uni(k) = sqrt(mean(vr.^2));

end

%% Normalización final
Vr_bip = Vr_bip / VI;
Vr_uni = Vr_uni / VI;

%% Gráfica
figure;
plot(Dvec, Vr_bip,'LineWidth',1.5); hold on;
plot(Dvec, Vr_uni,'LineWidth',1.5);
grid on;
xlabel('D_{T_A^+}');
ylabel('V_{AB,ripple,rms}/V_I');
legend('Bipolar','Unipolar','Location','best');
title('Tensión de rizado normalizada frente a D_{T_A^+}');
