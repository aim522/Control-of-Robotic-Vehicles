function [ctrl] = optMPC_d(Q,R,Qs,N,Ts)
% MPC decentral
%% sys info
A   =  [0, 0; 1, 0]; B   =  [0; -1]; C   =  [0, 1]; D   =  0;
sys =  ss(A, B, C, D); ssd =  c2d(sys,Ts);
Ad  =  ssd.A; Bd  =  ssd.B; Cd  =  ssd.C; Dd  =  ssd.D;
Cdis = 1;
%% MPC
% R = 1; Q = 1e3; Qs = 1e5; N = 5; %pred. horizont
nx = size(Ad,2); nu = size(Bd,2);ny = size(Cd,1);
u = sdpvar(nu, N, 'full'); x = sdpvar(nx, N+1, 'full');
y = sdpvar(ny, N, 'full'); w = sdpvar(ny, 1, 'full');
u_prew = sdpvar(nu, 1, 'full'); s = sdpvar(ny, 1, 'full');
d0 = sdpvar(ny, 1, 'full');
u_min = 0*ones(1,1); u_max = 127*ones(1,1); 
y_min = 5*ones(1,1); y_max = 20*ones(1,1);
J = 0; F = [];
for k = 1 : N
    J = J +(y(:,k)-w(:))'*Q*(y(:,k)-w(:));
    if k == 1
        du(:,k) = u(:,k)-u_prew(:);    
    else
        du(:,k) = u(:,k)-u(:,k-1);
    end
    J = J + du(k)'*R*du(k)+s*Qs*s;
    F = F + [u_min(:) <= u(k) <= u_max(:)];
    F = F + [y_min(:) - s(:) <= y(k) <= y_max(:) + s(:)];
    F = F + [x(:,k+1) == Ad*x(:,k)+ Bd*u(k)];
    F = F + [y(k) == Cd*x(:,k) + Dd*u(k) + Cdis*d0(:)];
    F = F + [s(:) >= 0];
end
opt = sdpsettings('solver','gurobi');
ctrl = optimizer(F,J,opt,[x(:,1)',d0,u_prew,w],u(:,1));
end