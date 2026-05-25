function A_thruster = Wheel_Distribution(k_p,R)

%% 推力分配
%注意推进器的分布 后面从左往右12 前面从左往右34 然后中间从左往右56 最后一个7
A_thruster = [k_p, k_p, k_p, k_p, 0, 0, 0;
              0, 0, 0, 0, 0, 0, 0;
              0, 0, 0, 0, 1, 1, 1;
              0, 0, 0, 0, R, -R, 0;
              0, 0, 0, 0, 0, 0, R;
              k_p, -k_p, k_p, -k_p, 0, 0, 0]; % 6x7 矩阵 7个推进器
end