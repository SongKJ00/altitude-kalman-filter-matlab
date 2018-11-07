clear all;
clc;

% delete all connected com port now
delete(instrfindall)
% Use your own com port
[ser, ax1, ax2] = Init('COM10', 115200);

% Kalman Filter Variables
x = [0 0]';
P = 5 * eye(2);
xp = zeros(2, 1);
Pp = zeros(2, 2);
Q = [1 0; 0 3];
R = 3;

xdata = 1:1000;
idx = 1;
dataList = nan(2, length(xdata));
firstUpdateRun = 0;
firstPredictRun = 0;
gravity = 9.80665;

pHgt = line('parent', ax1, 'xdata', xdata, 'ydata', dataList(1, :), 'color', 'b');
pVel = line('parent', ax2, 'xdata', xdata, 'ydata', dataList(2, :), 'color', 'b');

while(1)
    [isOK, dataType, euler, accBody, hgt] = ParseData(ser);
    
    if isOK == 1
        % If euler angles and acc are received
        % do DCM and KF Predict
        if dataType == 1
            accNED = CoordinateTransform(euler, accBody);
            accZ = -accNED(3, :) - gravity;
            
            [xp, Pp] = KFPredict(x, P, accZ, Q);
            firstPredictRun = 1;
        % if height is received
        % do KF Update
        elseif dataType == 2 && firstPredictRun == 1
            [x, P, h, v] = KFUpdate(xp, Pp, hgt, R);
            if firstUpdateRun == 0
                axis(ax1, [0 length(xdata) h-0.5 h+0.5]);
                axis(ax2, [0 length(xdata) v-0.3 v+0.3]);
                firstUpdateRun = 1;
            end
            dataList(1, idx) = h;
            dataList(2, idx) = v;
            idx = idx + 1;
            if idx > length(xdata)
                idx = 1;
            end
            
            set(pHgt, 'ydata', dataList(1, :));
            set(pVel, 'ydata', dataList(2, :));
            
        end
    end
    pause(0.0001);
end
