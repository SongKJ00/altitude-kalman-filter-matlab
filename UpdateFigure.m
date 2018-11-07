function [] = UpdateFigure(newData)

persistent firstRun;
persistent x k accNEDList;
persistent p;

if isempty(firstRun)
    x = 1:1000;
    k = 1;
    
    accNEDList = nan(1, length(x));
    p = plot(x, accNEDList, 'Color', 'b');
    legend('Z Axis');
    
    firstRun = 1;
end

accNEDList(k) = newData + 9.80665;

k = k + 1;
if k > length(accNEDList)
    k = 1;
end

% Draw Z axis acceleration
set(p, 'ydata', accNEDList);



