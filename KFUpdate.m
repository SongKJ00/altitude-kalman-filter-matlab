function [ x, P, h, v ] = KFUpdate( xp, Pp, z ,R )
%UNTITLED4 이 함수의 요약 설명 위치
%   자세한 설명 위치

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

