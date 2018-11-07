function [check, dataType, euler, accBody, hgt] = ParseData(ser)
% Get euler, accelertaion data from com port
% Data Packet Structure is "roll pitch yaw accX accY accZ\n"

euler = zeros(3, 1);
accBody = zeros(3, 1);
hgt = 0;

data = fscanf(ser);
dataLen = size(data, 2);
dataSliceIndex = strfind(data, ' ');
dataType = 0;


if length(dataSliceIndex) >= 5
    if data(2) == 'm'
        euler(1, :) = deg2rad(str2double(data(3:dataSliceIndex(1)-1)));
        euler(2, :) = deg2rad(str2double(data(dataSliceIndex(1):dataSliceIndex(2)-1)));
        euler(3, :) = deg2rad(str2double(data(dataSliceIndex(2):dataSliceIndex(3)-1)));
        
        accBody(1, :) = str2double(data(dataSliceIndex(3):dataSliceIndex(4)-1));
        accBody(2, :) = str2double(data(dataSliceIndex(4):dataSliceIndex(5)-1));
        accBody(3, :) = str2double(data(dataSliceIndex(5):dataLen-2));
        
        %fprintf('%.2f %.2f %.2f %.2f %.2f %.2f\n', euler(1, :), euler(2, :), euler(3, :), accBody(1, :), accBody(2, :), accBody(3, :));
        dataType = 1;
    elseif data(2) == 'h'
        hgt = str2double(data(3:dataSliceIndex(1)-1));
        %fprintf('%.2f\n', hgt);
        dataType = 2;
    end
    
    check = 1;
else
    euler(:, :) = 0;
    accBody(:, :) = 0;
    hgt = 0;
    
    check = 0;
end