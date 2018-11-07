function dataNED = CoordinateTransform(euler, dataBody)
% Transform acceleration data in body frame to NED frame
%

DCMBodytoNED = zeros(3, 3);
roll = euler(1);
pitch = euler(2);
yaw = euler(3);

DCMBodytoNED(1, :) = [cos(yaw)*cos(pitch), -sin(yaw)*cos(roll)+cos(yaw)*sin(pitch)*sin(roll), sin(yaw)*sin(roll)+cos(yaw)*sin(pitch)*cos(roll)];
DCMBodytoNED(2, :) = [sin(yaw)*cos(pitch), cos(yaw)*cos(roll)+sin(yaw)*sin(pitch)*sin(roll), -cos(yaw)*sin(roll)+sin(yaw)*sin(pitch)*cos(roll)];
DCMBodytoNED(3, :) = [-sin(pitch), cos(pitch)*sin(roll), cos(pitch)*cos(roll)];

dataNED = DCMBodytoNED * dataBody;
end

