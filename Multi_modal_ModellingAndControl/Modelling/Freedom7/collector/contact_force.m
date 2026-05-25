function tau_contact = contact_force(nu_k, Z_depth)
    tau_contact = zeros(6, 1); % 驱动杆在内部，所以才采集接触力基本不会影响采集器的开合，主要是接触的反作用力会作用到机器人本体上
    u_body = nu_k(1);
    %% 补充宾汉姆体模型参数 (基于文献实验数据)
    % 文献来源：Study of the resistance on the side surface of the underwater vehicle's soil base % (Ananiev, 2023)
    % --- 土壤参数 (使用 Model No. 1 的规范值作为保守假设) ---
    tau_l = 0.4 * 1000;              % 极限剪切应力 tau_l1 = 0.4 kPa，转换为 Pa (N/m^2) [cite: 179]
    eta_viscosity = 1.20e-3 * 1000;  % 黏度系数 eta_1 = 1.20e-3 kPa·s，转换为 Pa·s [cite: 128]
    delta_shear_layer = 0.02;        % 剪切边界层厚度 delta = 20 mm，转换为米 [cite: 77]
    Z_contact_threshold = 0.25;   % 接触深度阈值 m  
    A_MV = 0.02; % 假设采集工具的侧表面积 A_MV 等于 MV 模型 No. 1 的侧面积 0.02 m^2 [cite: 84]
    Z_CONTACT_OFFSET = -0.8;    % 接触点到CG的垂直距离 (m)。
    %% --- 随机扰动范围 ---
    % 引入随机性到黏度系数，模拟土壤不确定性
    eta_rand_factor = [0.8, 1.5]; % 假设黏度系数在标称值的 80% 到 150% 之间随机变化

    % 检查是否满足采集条件：Z_depth >= 0.25 (接触) 且 u_body (有速度)
    if Z_depth >= Z_contact_threshold && abs(u_body) > 1e-3 

        % 1. 宾汉姆体模型计算 (F_x, 第 1 维):
        % a. 计算剪切变形率 gamma_dot
        % 剪切变形率 gamma_dot = 速度 V / 边界层厚度 delta [cite: 100]
        gamma_dot = abs(u_body) / delta_shear_layer;

        % b. 引入随机黏度系数 (模拟土壤不确定性)
        % rand_eta 介于 0.8*eta_viscosity 和 1.5*eta_viscosity 之间
        rand_factor = eta_rand_factor(1) + (eta_rand_factor(2) - eta_rand_factor(1)) * rand(1);
        eta_k_soil = eta_viscosity * rand_factor;

        % c. 计算剪切应力 tau_i = tau_l + eta * gamma_dot [cite: 93]
        tau_i = tau_l + eta_k_soil * gamma_dot; % 结果单位是 Pa (N/m^2)

        % d. 计算总接触阻力 F_x (力 = 应力 * 面积)
        F_x_contact_mag = A_MV * tau_i; % 接触力大小 (N)

        % 确保接触力方向与运动方向相反
        F_x_contact = -sign(u_body) * F_x_contact_mag; 
        tau_contact(1) = F_x_contact;

        % 2. 俯仰力矩 (M_y, 第 5 维): 力矩耦合到接触力
        % tau_contact(5) = 偏置 Z_CONTACT_OFFSET * 接触力 F_x
        tau_contact(5) = Z_CONTACT_OFFSET * F_x_contact;
    end
end