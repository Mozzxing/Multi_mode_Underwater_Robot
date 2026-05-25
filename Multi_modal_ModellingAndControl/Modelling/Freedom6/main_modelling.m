%% 6自由度无载具类拉格朗日建模
clear;
clc;
close all;
syms t real
syms m real
syms ix iy iz ixy ixz iyz real
syms xG yG zG real %重心位置
syms xB yB zB real %浮心位置
syms W B real %重力和浮力
syms q1(t) q2(t) q3(t) q4(t) q5(t) q6(t)
syms u(t) v(t) w(t) p(t) q(t) r(t) 
syms u_d(t) v_d(t) w_d(t) p_d(t) q_d(t) r_d(t) 
% 
Rx = [1, 0, 0; 
      0, cos(q4(t)), -sin(q4(t)); 
      0, sin(q4(t)), cos(q4(t))];
Ry = [cos(q5(t)), 0, sin(q5(t));
      0, 1, 0;
      -sin(q5(t)), 0, cos(q5(t))];
Rz = [cos(q6(t)), -sin(q6(t)), 0;
      sin(q6(t)), cos(q6(t)), 0;
      0, 0, 1];

J1 = Rz*Ry*Rx;
J2 = [1, sin(q4(t))*tan(q5(t)), cos(q4(t))*tan(q5(t));
      0, cos(q4(t)), -sin(q4(t));
      0, sin(q4(t))/cos(q5(t)), cos(q4(t))/cos(q5(t))];

%% 定义惯性矩阵
M_RB = [m, 0, 0, 0, m*zG, -m*yG;
        0, m, 0, -m*zG, 0, m*xG;
        0, 0, m, m*yG, -m*xG, 0;
        0, -m*zG, m*yG, ix, -ixy, -ixz;
        m*zG, 0, -m*xG, -ixy, iy, -iyz;
        -m*yG, m*xG, 0, -ixz, -iyz, iz];
%% 构造总的雅可比矩阵J
J = blkdiag(J1, J2); % 使用 blkdiag 构建 J 矩阵
%% 计算 J 的逆和转置矩阵 A
AT = simplify(inv(J));
A = transpose(AT);
%% 定义速度向量
% 定义广义坐标向量
q_vec = [q1(t); q2(t); q3(t); q4(t); q5(t); q6(t)];
nu = [u(t); v(t); w(t); p(t); q(t); r(t)]; 
nu_v = v(1:3);
nu_omega = v(4:6);
% v_dot是一个6x1的列向量，包含了所有广义速度的导数。
nu_dot =[diff(u(t),t);
        diff(v(t),t);
        diff(w(t),t);
        diff(p(t),t);
        diff(q(t),t);
        diff(r(t),t)];
%% 计算动能
T = 0.5 * nu.' * M_RB * nu;
%% 求解gama-1
% 初始化三维数组来存储结果
AQVector = sym(zeros(6, 6, 6));
% 遍历矩阵 A 的每个元素并求偏导数
for i = 1:6
    for j = 1:6
        % 获取矩阵 A 的 (i, j) 元素
        A_ij = A(i, j);
        % 遍历广义坐标向量 q_vec 的每个元素，并求偏导数
        for k = 1:6
            AQVector(i, j, k) = diff(A_ij, q_vec(k));
        end
    end
end
gama1 = sym(zeros(6,6)); %建立gama1空矩阵，方便后续存放gama1
for i = 1:6
    for j = 1:6
        % 获取 AQVector 的切片，即 A(i,j) 对所有广义坐标的偏导数组成的列向量。
        % 在 MATLAB 中，这对应于 AQVector(i, j, :)。
        AQ_slice = squeeze(AQVector(i, j, :));
        % x1 的每个元素都是一个向量-矩阵-向量乘积。
        % 注意：W 是 1x6，Transpose(A) 是 6x6，AQ_slice 是6x1。
        % 这三者相乘的结果是一个标量。
        gama1(i, j) = nu.' * J.' * AQ_slice;
    end
end
% disp(gama1)
%% 求解gama-2
DAq1 = diff(A,q1(t));
DAq2 = diff(A,q2(t));
DAq3 = diff(A,q3(t));
DAq4 = diff(A,q4(t));
DAq5 = diff(A,q5(t));
DAq6 = diff(A,q6(t));

DAq_eta = cat(3,DAq1,DAq2,DAq3,DAq4,DAq5,DAq6); %沿着三维进行拼接，这一句只是用来示意的，不写也行。 仅用于示意的d(A/eta)的形式

gama2_l1 = nu.' * J.' * DAq1;
gama2_l2 = nu.' * J.' * DAq2;
gama2_l3 = nu.' * J.' * DAq3;
gama2_l4 = nu.' * J.' * DAq4;
gama2_l5 = nu.' * J.' * DAq5;
gama2_l6 = nu.' * J.' * DAq6;
gama2 = [gama2_l1;
        gama2_l2;
        gama2_l3;
        gama2_l4;
        gama2_l5;
        gama2_l6;];
%% 求gamma
gama = gama1 - gama2;
disp('gama is:')
disp(gama);
%%
% H1 的计算
H1_temp = expand(diff(diff(T, u(t)), t));

H1 = simplify(jacobian(H1_temp,nu_dot));

H1_rest = simplify(H1_temp - H1*nu_dot);%H1_rest表示 拉格朗日法动力学建模求解的中间项， 其实也就是惯性力和科氏力矩阵C的一部分
% H2 的计算
H2_temp = expand(diff(diff(T, v(t)), t));

H2 = simplify(jacobian(H2_temp,nu_dot));

H2_rest = simplify(H2_temp - H2*nu_dot);

% H3 的计算
H3_temp = expand(diff(diff(T, w(t)), t));

H3 = simplify(jacobian(H3_temp,nu_dot));

H3_rest = simplify(H3_temp - H3*nu_dot);

% H4 的计算
H4_temp = expand(diff(diff(T, p(t)), t));

H4 = simplify(jacobian(H4_temp,nu_dot));

H4_rest = simplify(H4_temp - H4*nu_dot);

% H5 的计算
H5_temp = expand(diff(diff(T, q(t)), t));

H5 = simplify(jacobian(H5_temp,nu_dot));

H5_rest = simplify(H5_temp - H5*nu_dot);

% H6 的计算
H6_temp = expand(diff(diff(T, r(t)), t));

H6 = simplify(jacobian(H6_temp,nu_dot));

H6_rest = simplify(H6_temp - H6*nu_dot);

H = [H1;H2;H3;H4;H5;H6];

disp('H:')
disp(H)
H_rest_total = [H1_rest;
                H2_rest;
                H3_rest;
                H4_rest;
                H5_rest;
                H6_rest;];
test_sum = H - H.';
disp('test_sum：')
disp(test_sum)
%% 求矩阵C(v,v_dot)
% 计算动能对类速度向量偏导
dTdVv = jacobian(T,nu);
JTgama = J.'*gama;
dTdeta = jacobian(T,q_vec);
% 第一C_nu分量
C_RB_1 = simplify(H_rest_total);
% 第二C_nu分量
C_RB_2 = simplify(JTgama * dTdVv.');
% 第三C_nu分量
C_RB_3 = simplify(J.' * dTdeta.') ;


C_nu = simplify(C_RB_1 + C_RB_2 + C_RB_3);
C = sixdof_C_decouple(C_nu); %
C = simplify(C);
disp(C)
%验证部分，不等于0，说明用简单的jacobian偏微分起不到等同的效果
C_test = simplify(jacobian(C_nu,nu));
C_sum_test = simplify(C_test - C*nu);
disp(C_sum_test);

%% 重力项
Position_G = [xG,yG,zG];
Position_B = [xB,yB,zB];
G = gravity_6dof(q4(t),q5(t),W,B,Position_G,Position_B);
%% 水阻力项目，通过水动力参数识别获得。直接写数值
DL = diag([12,23,157,0.016,0.78,0.78]); %线性阻尼
DV = diag([100,240,100,0.87,2.16,2.16]); %二次阻尼
D = (DL + DV)*nu; %体坐标系
D_eta = ((J.')\D)./J; %惯性坐标系