function [ser, ax1, ax2]= Init(port, baudrate)
% Open Com Port
%
ser = serial(port, 'Baudrate', baudrate);
fopen(ser);

figure;
grid on;
ax1 = subplot(2, 1, 1);
title(ax1, 'Height Estimation Kalman Filter');
ylabel(ax1, 'Height (m)');

ax2 = subplot(2, 1, 2);
title(ax2, 'Vertical Velocity Estimation Kalman Filter');
ylabel('Velocity [m/s]');

end