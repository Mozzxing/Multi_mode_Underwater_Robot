function C_newmethod = sevendof_C_decouple(C)
CSave = C(1); 
% 1. 定义符号变量
syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)
% 2. 将 CSave 定义为符号表达式（你需要根据实际情况替换为你自己的表达式）
% 举例：CSave = 5*u + 3*u^2 + 7; % 这里的 u 对应 Mathematica 里的 u[t]

% 3. 提取 u 的系数
% 使用 coeffs 函数，它可以返回所有项的系数和对应的变量项
[coeffs_all, terms] = coeffs(CSave, u(t));

% 4. 找到 u 和 u^2 对应的系数
% 遍历 terms 找到 u 和 u^2 对应的位置
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

% 5. 构建 C11 表达式
C11 = u_coeff + u_sq_coeff *  u(t);

% 6. 简化表达式（如果需要）
C11 = simplify(C11);

% 7. 显示结果
disp(C11);


%% C12
CSave = CSave - C11*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C12 = u_coeff + u_sq_coeff *  v(t);
C12 = simplify(C12);
disp(C12);


%% C13
CSave = CSave - C12*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C13 = u_coeff + u_sq_coeff *  w(t);
C13 = simplify(C13);
disp(C13);

%% C14
CSave = CSave - C13*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C14 = u_coeff + u_sq_coeff * p(t);
C14 = simplify(C14);
disp(C14);

%% C15
CSave = CSave - C14*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C15 = u_coeff + u_sq_coeff * q(t);
C15 = simplify(C15);
disp(C15);

%% C16
CSave = CSave - C15*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C16 = u_coeff + u_sq_coeff * r(t);
C16 = simplify(C16);
disp(C16);

%% C17
CSave = CSave - C16*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C17 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C17 = simplify(C17);
disp(C17);

CSvae = simplify(CSave - C17*diff(alpha1(t),t))
%% C21

CSave = C(2); 
% 1. 定义符号变量
syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)
% 2. 将 CSave 定义为符号表达式（你需要根据实际情况替换为你自己的表达式）
% 举例：CSave = 5*u + 3*u^2 + 7; % 这里的 u 对应 Mathematica 里的 u[t]

% 3. 提取 u 的系数
% 使用 coeffs 函数，它可以返回所有项的系数和对应的变量项
[coeffs_all, terms] = coeffs(CSave, u(t));

% 4. 找到 u 和 u^2 对应的系数
% 遍历 terms 找到 u 和 u^2 对应的位置
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

% 5. 构建 C11 表达式
C21 = u_coeff + u_sq_coeff *  u(t);

% 6. 简化表达式（如果需要）
C21 = simplify(C21);

% 7. 显示结果
disp(C21);


%% C22
CSave = CSave - C21*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C22 = u_coeff + u_sq_coeff *  v(t);
C22 = simplify(C22);
disp(C22);


%% C23
CSave = CSave - C22*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C23 = u_coeff + u_sq_coeff *  w(t);
C23 = simplify(C23);
disp(C23);

%% C24
CSave = CSave - C23*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C24 = u_coeff + u_sq_coeff * p(t);
C24 = simplify(C24);
disp(C24);

%% C25
CSave = CSave - C24*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C25 = u_coeff + u_sq_coeff * q(t);
C25 = simplify(C25);
disp(C25);

%% C26
CSave = CSave - C25*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C26 = u_coeff + u_sq_coeff * r(t);
C26 = simplify(C26);
disp(C26);

%% C27
CSave = CSave - C26*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C27 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C27 = simplify(C27);
disp(C27);
CSave = simplify(CSave - C27*diff(alpha1(t),t));
disp(CSave)
%% C31

CSave = C(3); 

syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)

[coeffs_all, terms] = coeffs(CSave, u(t));

u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C31 = u_coeff + u_sq_coeff *  u(t);

C31 = simplify(C31);

disp(C31);


%% C32
CSave = CSave - C31*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C32 = u_coeff + u_sq_coeff *  v(t);
C32 = simplify(C32);
disp(C32);


%% C33
CSave = CSave - C32*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C33 = u_coeff + u_sq_coeff *  w(t);
C33 = simplify(C33);
disp(C33);

%% C34
CSave = CSave - C33*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C34 = u_coeff + u_sq_coeff * p(t);
C34 = simplify(C34);
disp(C34);

%% C35
CSave = CSave - C34*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C35 = u_coeff + u_sq_coeff * q(t);
C35 = simplify(C35);
disp(C35);

%% C36
CSave = CSave - C35*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C36 = u_coeff + u_sq_coeff * r(t);
C36 = simplify(C36);
disp(C36);

%% C37
CSave = CSave - C36*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C37 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C37 = simplify(C37);
disp(C37);
CSave = simplify(CSave - C37*diff(alpha1(t),t));
disp(CSave)
%% C41

CSave = C(4); 

syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)

[coeffs_all, terms] = coeffs(CSave, u(t));

u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C41 = u_coeff + u_sq_coeff *  u(t);

C41 = simplify(C41);

disp(C41);


%% C42
CSave = CSave - C41*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C42 = u_coeff + u_sq_coeff *  v(t);
C42 = simplify(C42);
disp(C42);


%% C43
CSave = CSave - C42*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C43 = u_coeff + u_sq_coeff *  w(t);
C43 = simplify(C43);
disp(C43);

%% C44
CSave = CSave - C43*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C44 = u_coeff + u_sq_coeff * p(t);
C44 = simplify(C44);
disp(C44);

%% C45
CSave = CSave - C44*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C45 = u_coeff + u_sq_coeff * q(t);
C45 = simplify(C45);
disp(C45);

%% C46
CSave = CSave - C45*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C46 = u_coeff + u_sq_coeff * r(t);
C46 = simplify(C46);
disp(C46);

%% C47
CSave = CSave - C46*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C47 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C47 = simplify(C47);
disp(C47);

CSave = simplify(CSave - C47*diff(alpha1(t),t));
disp(CSave)
%% C51

CSave = C(5); 

syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)

[coeffs_all, terms] = coeffs(CSave, u(t));


u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

% 5. 构建 C11 表达式
C51 = u_coeff + u_sq_coeff *  u(t);

% 6. 简化表达式（如果需要）
C51 = simplify(C51);

% 7. 显示结果
disp(C51);

%% C52
CSave = CSave - C51*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C52 = u_coeff + u_sq_coeff *  v(t);
C52 = simplify(C52);
disp(C52);


%% C53
CSave = CSave - C52*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C53 = u_coeff + u_sq_coeff *  w(t);
C53 = simplify(C53);
disp(C53);

%% C54
CSave = CSave - C53*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C54 = u_coeff + u_sq_coeff * p(t);
C54 = simplify(C54);
disp(C54);

%% C55
CSave = CSave - C54*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C55 = u_coeff + u_sq_coeff * q(t);
C55 = simplify(C55);
disp(C55);

%% C56
CSave = CSave - C55*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C56 = u_coeff + u_sq_coeff * r(t);
C56 = simplify(C56);
disp(C56);

%% C57
CSave = CSave - C56*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C57 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C57 = simplify(C57);
disp(C57);

CSave = simplify(CSave - C57*diff(alpha1(t),t));
disp(CSave)
%% C61

CSave = C(6); 

syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)

[coeffs_all, terms] = coeffs(CSave, u(t));

u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end


C61 = u_coeff + u_sq_coeff *  u(t);

C61 = simplify(C61);

disp(C61);


%% C62
CSave = CSave - C61*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C62 = u_coeff + u_sq_coeff *  v(t);
C62 = simplify(C62);
disp(C62);


%% C63
CSave = CSave - C62*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C63 = u_coeff + u_sq_coeff *  w(t);
C63 = simplify(C63);
disp(C63);

%% C64
CSave = CSave - C63*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C64 = u_coeff + u_sq_coeff * p(t);
C64 = simplify(C64);
disp(C64);

%% C65
CSave = CSave - C64*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C65 = u_coeff + u_sq_coeff * q(t);
C65 = simplify(C65);
disp(C65);

%% C66
CSave = CSave - C65*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C66 = u_coeff + u_sq_coeff * r(t);
C66 = simplify(C66);
disp(C66);

%% C67
CSave = CSave - C66*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C67 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C67 = simplify(C67);
disp(C67);
CSave = simplify(CSave - C67*diff(alpha1(t),t));
disp(CSave)

%% C71

CSave = C(7); 

syms u(t) v(t) w(t) p(t) q(t) r(t) alpha1(t)

[coeffs_all, terms] = coeffs(CSave, u(t));

u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), u(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), u(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end


C71 = u_coeff + u_sq_coeff *  u(t);

C71 = simplify(C71);

disp(C71);


%% C72
CSave = CSave - C71*u(t);

[coeffs_all, terms] = coeffs(CSave, v(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), v(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), v(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C72 = u_coeff + u_sq_coeff *  v(t);
C72 = simplify(C72);
disp(C72);


%% C73
CSave = CSave - C72*v(t);

[coeffs_all, terms] = coeffs(CSave, w(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), w(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), w(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C73 = u_coeff + u_sq_coeff *  w(t);
C73 = simplify(C73);
disp(C73);

%% C64
CSave = CSave - C73*w(t);

[coeffs_all, terms] = coeffs(CSave, p(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), p(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), p(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C74 = u_coeff + u_sq_coeff * p(t);
C74 = simplify(C74);
disp(C74);

%% C75
CSave = CSave - C74*p(t);

[coeffs_all, terms] = coeffs(CSave, q(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), q(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), q(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C75 = u_coeff + u_sq_coeff * q(t);
C75 = simplify(C75);
disp(C75);

%% C76
CSave = CSave - C75*q(t);

[coeffs_all, terms] = coeffs(CSave, r(t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), r(t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), r(t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C76 = u_coeff + u_sq_coeff * r(t);
C76 = simplify(C76);
disp(C76);

%% C77
CSave = CSave - C76*r(t);

[coeffs_all, terms] = coeffs(CSave, diff(alpha1(t),t));
u_coeff = 0;
u_sq_coeff = 0;

for i = 1:length(terms)
    if isequal(terms(i), diff(alpha1(t),t))
        u_coeff = coeffs_all(i);
    end
    if isequal(terms(i), diff(alpha1(t),t)^2)
        u_sq_coeff = coeffs_all(i);
    end
end

C77 = u_coeff + u_sq_coeff * diff(alpha1(t),t);
C77 = simplify(C77);
disp(C77);

CSave = simplify(CSave - C77*diff(alpha1(t),t));
disp(CSave)




%%
C_newmethod = [C11, C12, C13, C14, C15, C16, C17;
               C21, C22, C23, C24, C25, C26, C27;
               C31, C32, C33, C34, C35, C36, C37;
               C41, C42, C43, C44, C45, C46, C47;
               C51, C52, C53, C54, C55, C56, C57;
               C61, C62, C63, C64, C65, C66, C67;
               C71, C72, C73, C74, C75, C76, C77;];
v_newmethod = [u(t) ,v(t) ,w(t) ,p(t) ,q(t) ,r(t) ,diff(alpha1(t),t)];
% C_newmethod = jacobian(C_newmethod,v_newmethod);
newmethod_test = simplify(C - C_newmethod*v_newmethod.');
disp(newmethod_test)
end