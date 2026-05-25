function A_thruster = ROV_With_observer_dist(gama,beta,L,p,R)

%% 推力分配
%注意推进器的分布 后面从左往右12 前面从左往右34 然后中间从左往右56 最后一个7
param1 = cos(gama);
param2 = sin(gama);
param3 = cos(beta);
A_thruster = [-param1, -param1, param1, param1, 0, 0, 0, 0;
              -param2, param2, -param2, param2, 0, 0, 0, 0;
               0, 0, 0, 0, 1, 1, 1, 0;
              -L*param2*param3, L*param2*param3, -L*param2*param3, L*param2*param3, R, -R, 0, 0;
               L*param1*param3, L*param1*param3, -L*param1*param3, -L*param1*param3, 0, 0, R, 0;
              -p, p, p, -p, 0, 0, 0, 0;
               0, 0, 0, 0, 0, 0, 0, 1]; % 7x8 矩阵 7个推进器 1个主动推进
end