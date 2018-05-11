function [ctrl] = optMPC_c(Ad,Bd,Cd,Q,R,Qs,N,Ts)

nx = size(Ad,2); nu = size(Bd,2);ny = size(Cd,1);
u = sdpvar(nu, N, 'full'); x = sdpvar(nx, N+1, 'full');
y = sdpvar(ny, N, 'full'); w = sdpvar(ny, 1, 'full');
u_prew = sdpvar(nu, 1, 'full');s = sdpvar(ny, 1, 'full');
u_min = zeros(n-1,1); u_max = 127*ones(n-1,1); 
y_min = zeros(n-1,1); y_max = 50*ones(n-1,1);
J = 0; F = [];

for k = 1 : N 
    J = J +(y(:,k)-w(:))'*Q*(y(:,k)-w(:));
    if k == 1
    du(:,k) = u(:,k)-u_prew;    
    else
    du(:,k) = u(:,k)-u(:,k-1);
    end
    J = J + du(k)'*R*du(k)+s(:)'*Qs*s(:);
    F = F + [u_min<=u(:,k)<=u_max];
    F = F + [y_min(:) - s(:) <= y(k) <= y_max(:) + s(:)];
    F = F + [x(:,k+1)==Ad*x(:,k)+Bd*u(:,k)];
    F = F + [y(:,k) == Cd*x(:,k)];
    F = F + [s(:) >= 0];
end
opt = sdpsettings('solver','gurobi');
ctrl = optimizer(F,J,opt,[x(:,1)',u_prew',w'],u(:,1));
end