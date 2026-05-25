function A_thruster = QUAD_Distribution(gama,beta,L,R,k)

%% 推力分配
%注意推进器的分布 后面从左往右12 前面从左往右34 然后中间从左往右56 最后一个7
param1 = cos(gama);
param2 = sin(gama);
param3 = cos(beta);
param4 = sin(beta);
A_thruster = [-param2*param3, -param2*param3, param2*param3, param2*param3, 0, 0, 0;
              param1*param3, -param1*param3, param1*param3, -param1*param3, 0, 0, 0;
              param4, param4, param4, param4, 1, 1, 1;
              L*param4, -L*param4, L*param4, -L*param4, R, -R, 0;
              L*param4, L*param4, -L*param4, -L*param4, 0, 0, R;
              k*param3*param1, -k*param3*param1, -k*param3*param1, k*param3*param1, 0, 0, 0]; % 6x7 矩阵 7个推进器
end