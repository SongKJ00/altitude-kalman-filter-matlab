function [ xp, Pp ] = KFPredict( x, P, u, Q )
%UNTITLED3 �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

persistent firstRun
persistent A B;

dt = 0.01;

if isempty(firstRun)
    A = [1 dt; 0 1];
    B = [0.5*dt^2 dt]';
       
    firstRun = 0;
end

xp = A*x + B*u;
Pp = A*P*A' + Q;

end

