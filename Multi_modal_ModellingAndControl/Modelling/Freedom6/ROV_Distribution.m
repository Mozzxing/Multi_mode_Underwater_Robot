function A_thruster = ROV_Distribution(gama,beta,L,p,R)

%% 推力分配
%注意推进器的分布 后面从左往右12 前面从左往右34 然后中间从左往右56 最后一个7
param1 = cos(gama);
param2 = sin(gama);
param3 = cos(beta);
A_thruster = [-param1, -param1, param1, param1, 0, 0, 0;
              -param2, param2, -param2, param2, 0, 0, 0;
               0, 0, 0, 0, 1, 1, 1;
              -L*param2*param3, L*param2*param3, -L*param2*param3, L*param2*param3, R, -R, 0;
               L*param1*param3, L*param1*param3, -L*param1*param3, -L*param1*param3, 0, 0, R;
              -p, p, p, -p, 0, 0, 0]; % 6x7 矩阵 7个推进器
end