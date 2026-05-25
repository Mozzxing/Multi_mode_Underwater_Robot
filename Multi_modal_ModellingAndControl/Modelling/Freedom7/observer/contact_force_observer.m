function tau_contact_7 = contact_force_observer(eta_k, nu_k, a_d, a_d_dot)

    %% ===============================
    %  7DOF 抵近观测接触力模型
    %  前6维：艇体 [X Y Z K M N]
    %  第7维：伸缩观测臂 a_d
    % ===============================

    tau_contact_7 = zeros(7, 1);
    %% 1. 参数定义

    % 观测臂参数
    L0 = 0.5;              % 观测臂固定长度 m
    z_offset = 0.0;        % 末端相对艇体质心的Z向偏置 m
    % 圆柱结构物参数
    cyl_center = [3; 5];   % 圆柱中心轴在惯性系XY平面的坐标
    R_cyl = 0.5;           % 圆柱半径 m，可根据实际改
    H_cyl = 10;            % 圆柱高度 m
    z_bottom = H_cyl;          % 圆柱底部z坐标
    z_top = 0;
    % 接触模型参数
    k_contact = 500;       % 接触刚度 N/m
    c_contact = 50;        % 接触阻尼 N/(m/s)
    mu = 0.3;              % 库伦摩擦系数
    eps_v = 1e-6;          % 防止除零

    %% 2. 状态量读取

    pos_i = eta_k(1:3);
    phi   = eta_k(4);
    theta = eta_k(5);
    psi   = eta_k(6);

    v_body = nu_k(1:3);
    omega_body = nu_k(4:6);
    %% 3. body -> inertial 旋转矩阵
    R_bi = eul2rotm_zyx(phi, theta, psi);
    %% 4. 观测臂末端位置
    % 伸缩方向默认沿体坐标系X轴
    e_alpha_b = [1; 0; 0];
    % 末端在体坐标系下的位置
    r_tip_b = [L0 + a_d;
               0;
               z_offset];
    % 末端在惯性坐标系下的位置
    p_tip_i = pos_i + R_bi * r_tip_b;
    %% 5. 圆柱高度判断
        %若是末端的高度不在被测物高度范围内，直接退出
    if p_tip_i(3) < z_bottom || p_tip_i(3) > z_top
        return;
    end
    %% 6. 圆柱侧表面接触判断
    % 末端相对圆柱中心轴的水平向量
    rho_vec = [p_tip_i(1) - cyl_center(1);
               p_tip_i(2) - cyl_center(2)];
    rho = norm(rho_vec);
    % 防止刚好在中心轴导致除零
    if rho < 1e-6
        n_i = [1; 0; 0];
    else
        % 圆柱径向单位法向量，惯性系下
        n_i = [rho_vec(1) / rho;
               rho_vec(2) / rho;
               0];
    end
    % 到圆柱侧表面的法向距离
    % d > 0：在圆柱外部，未接触
    % d = 0：刚好接触
    % d < 0：压入圆柱内部
    d = rho - R_cyl;
    % 接触压缩量
    delta = max(0, -d);
    if delta <= 0
        return;
    end

    %% 7. 观测臂末端速度

    % 伸缩速度，体坐标系下
    v_alpha_b = a_d_dot * e_alpha_b;
    % 末端速度，体坐标系下
    v_tip_b = v_body + cross(omega_body, r_tip_b) + v_alpha_b;
    % 转换到惯性系
    v_tip_i = R_bi * v_tip_b;

    %% 8. 法向接触力 Kelvin-Voigt 模型

    % 法向速度，标量
    v_n = dot(v_tip_i, n_i);

    % 法向力大小
    F_n_mag = k_contact * delta - c_contact * v_n;
    % 结构物只能提供反作用力，不能吸引机器人
    F_n_mag = max(0, F_n_mag);
    % 法向接触力，惯性系
    F_n_i = F_n_mag * n_i;

    %% 9. 切向摩擦力

    % 切向速度
    v_t_i = v_tip_i - v_n * n_i;
    % 库伦摩擦力
    F_t_i = -mu * F_n_mag * v_t_i / (norm(v_t_i) + eps_v);

    %% 10. 总接触力
    F_contact_i = F_n_i + F_t_i;

    %% 11. 转换到体坐标系
    F_contact_b = R_bi' * F_contact_i;
    % 接触力矩，作用点是观测臂末端
    M_contact_b = cross(r_tip_b, F_contact_b);

    %% 12. 组成7DOF广义接触力

    tau_contact_7(1:3) = F_contact_b;
    tau_contact_7(4:6) = M_contact_b;
    % 第7维：沿伸缩方向的接触广义力
    tau_contact_7(7) = dot(F_contact_b, e_alpha_b);
end
function R = eul2rotm_zyx(phi, theta, psi)

    Rz = [cos(psi), -sin(psi), 0;
          sin(psi),  cos(psi), 0;
          0,         0,        1];

    Ry = [cos(theta), 0, sin(theta);
          0,          1, 0;
         -sin(theta), 0, cos(theta)];

    Rx = [1, 0,        0;
          0, cos(phi), -sin(phi);
          0, sin(phi),  cos(phi)];

    R = Rz * Ry * Rx;
end