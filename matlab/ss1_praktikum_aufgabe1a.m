% Malte Mueller Finn Lanz 10.04.2019

%% Aufgabe 1

U = 1;
tau = 1;
dt = tau/100;

% Berechnung der Lade- und Entladekurve

t1 = 0:dt:tau;              % Ladezeit
uy1 = U * (1-exp(-t1/tau)); % Ladefunktion

t2 = tau:dt:(tau+5*tau);    % Entladezeit
uy2 = U * (1-exp(-tau/tau)) * exp(-(t2-tau)/tau);   % Entladefunktion

uy = [uy1, uy2];    % Zusammensetzen der Lade- und Entladewerte
t = [t1, t2];

plot(t, uy); grid on; grid minor; %axis tight; 

% Beschriftung des Graphen

title('Ausgangsspannung u_y(t)');
xlabel('t');
ylabel('u_y(t)');

%% Aufgabe 2
U = 1; 
T1 = 1; % Umschaltzeitpunkt
tau = 1; 
dt = tau/100;

for m = 1:10
    tau = m*T1/5;
    
    t1 = (0:dt:T1);
    uy1 = U * (1-exp(-t1/tau));
    
    t2 = (T1:dt:((T1+5*tau)));
    uy2 = U * (1-exp(-T1/tau)) * exp(-(t2-T1)/tau);
    uy = [uy1 uy2];
   
    t = [t1 t2];
    
    if (m == 1 || m == 3 || m == 10)
        plot(t, uy);
        legend(strcat('m = ', num2str(m)));
        hold on;
    end
    
    pause(0.5);

end

% Beschriftung des Plots
title('Ausgangsspannung u_y(t)');
legend('m = 1', 'm = 3', 'm = 10');
xlabel('t');
ylabel('u_y(t)');

grid on; grid minor; axis tight; % Optimierung Graph
%% Aufgabe 3

T = 5;  % Periodendauer
tau = 1;
t1 = linspace(0, tau, 1000);
t2 = linspace(tau, 4*tau, 4000);
F = 1/T;
t = [t1, t2];
dt = tau/100;

% Berechnung der Fourier-Reihe
for K = 1:40
    uyt = 0;

    for k = -K:K
        Hkf = 1 / (1 + 1i*2*pi*k*F*tau);
        Xk = exp(-1i*2*pi*k*F*(tau/2)) * (tau/T) * sinc(k*F*tau); %% sinc ohne PI!
        Yk = Hkf * Xk;
        uyt = uyt + Yk * exp(1i*2*pi*k*F*t);
    end
    if (K == 2 || K == 12 || K == 40)
        plot(t, uyt);
        legend(strcat('K = ', num2str(K))); % Ausgabe des k-ten Durchlauf
        hold on;
    end
    %pause(0.2);
end
% Beschriftung des Plots

title('Fourier-Reihe u_y(t) mit K_{max} = 40' );
xlabel('t');
ylabel('u_y(t)');
legend('K = 2', 'K = 12', 'K = 40');
grid on; grid minor;

hold off;