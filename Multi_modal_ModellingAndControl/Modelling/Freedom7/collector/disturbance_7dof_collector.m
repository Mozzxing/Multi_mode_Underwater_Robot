function tau_env = disturbance_7dof_collector(t, nu_k, J_inv_k_full, Z_depth, DL_env)
    %% 环境扰动参数
    % 洋流速度，惯性坐标系下
    NU_C_INERTIAL = [1; 0.8; 0.2; 0; 0; 0;0];

    % 波浪力参数
    A_WAVE = 5;          % 波浪力幅值 N
    OMEGA_WAVE = 0.5;    % 波浪频率 rad/s
    K_WAVE_DECAY = 1.0;  % 深度衰减系数

    % 随机噪声参数
    K_NOISE = diag([2, 2, 1, 0.2, 0.2, 0.2]);

    %% 初始化
    tau_env = zeros(7, 1); % 体坐标系下的6DOF环境扰动

    %% 1. 洋流扰动

    % 惯性系洋流速度转换到体坐标系
    nu_c_body = J_inv_k_full(1:6, 1:6) * NU_C_INERTIAL(1:6);

    % 相对速度
    nu_r = nu_k - nu_c_body;

    % 洋流造成的阻力
    tau_current = -DL_env * nu_r;

    tau_env = tau_env + tau_current;

    %% 2. 波浪扰动

    % 深度越深，波浪影响越小
    wave_decay = exp(-K_WAVE_DECAY * abs(Z_depth));

    wave_force_x = A_WAVE * sin(OMEGA_WAVE * t) * wave_decay;
    wave_force_y = A_WAVE * cos(OMEGA_WAVE * t) * wave_decay;

    tau_wave_body = [wave_force_x; wave_force_y; 0; 0; 0; 0];

    tau_env = tau_env(1:6) + tau_wave_body;

    %% 3. 随机噪声

    tau_noise = K_NOISE * randn(6, 1);

    tau_env = tau_env(1:6) + tau_noise;
    tau_env(7)= 0;

end