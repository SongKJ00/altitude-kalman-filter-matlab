function [ x, P, h, v ] = KFUpdate( xp, Pp, z ,R )
%UNTITLED4 �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ

persistent firstRun
persistent H

if isempty(firstRun)
    H = [1 0];
    firstRun = 1;
end

K = Pp*H'*inv(H*Pp*H' + R);
x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;

h = x(1);
v = x(2);
end

