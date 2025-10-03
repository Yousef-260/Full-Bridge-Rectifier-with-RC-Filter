% Full Bridge Rectifier with Capacitor Filter

% Parameters
f = 50;              % Input frequency (Hz)
Vm = 100;            % Peak input voltage (V)
R = 100;             % Load resistance (Ohm)
C = 470e-6;          % Filter capacitor (F)
t = 0:1e-4:0.1;      % Simulation time vector
dt = t(2)-t(1);      % Time step

% Input AC voltage
Vin = Vm * sin(2 * pi * f * t);

% Rectified voltage
Vrect = abs(Vin);

% Output voltage with capacitor filter (simple iterative charging/discharging)
Vout = zeros(size(t));
for k = 2:length(t)
    Vout(k) = Vout(k-1) * exp(-dt/(R*C));
    if Vrect(k) > Vout(k)
        Vout(k) = Vrect(k);
    end
end

% Load current
Iout = Vout / R;

% Plotting
figure;
subplot(3,1,1);
plot(t, Vin, 'b', 'LineWidth', 1.5); grid on;
title('Input AC Voltage'); ylabel('Vin (V)');

subplot(3,1,2);
plot(t, Vrect, 'r', 'LineWidth', 1.2); hold on;
plot(t, Vout, 'k','LineWidth',1.5); grid on;
title('Full Wave Rectifier with Capacitor Filter');
ylabel('Voltage (V)'); legend('Rectified','Filtered');

subplot(3,1,3);
plot(t, Iout, 'g', 'LineWidth', 1.5); grid on;
title('Load Current'); ylabel('Iout (A)'); xlabel('Time (s)');
