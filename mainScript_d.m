%% DECENTRAL
clear, close all
clc
%% meniace sa hodnoty w1,w2,r1
r1 = 10;
r2 = 15;
v1 = 50;
Ts = 0.25;
t = timer;                      
t.Period = Ts;             
t.ExecutionMode = 'fixedRate';
t.TasksToExecute = 180;
A   =  [0, 0; 1, 0]; B   =  [0; -1]; C   =  [0, 1]; D   =  0;
sys =  ss(A, B, C, D); ssd =  c2d(sys,Ts);
Ad  =  ssd.A; Bd  =  ssd.B; Cd  =  ssd.C;
No5 = RoboBug('192.168.1.205'); No5.connect; No5.setAuto(1); No5.setStopDist(1);
No7 = RoboBug('192.168.1.207'); No7.connect; No7.setAuto(1); No7.setStopDist(1);   
No9 = RoboBug('192.168.1.209'); No9.connect; No9.setAuto(1); No9.setStopDist(1);   

Bdis = zeros(2,1); 
Cdist = 1;
Ao = [Ad, Bdis; zeros(1, 2), 1];
Bo = [Bd; 0]; Co = [Cd,Cdist]; 

QQ = diag([1, 100, 1]);
RR = 100;
L = dlqr(Ao',Co',QQ,RR)';
R = 1e-2; Q = 1e3; Qs = 1e5; N = 5;
[ctrl] = optMPC_d(Q,R,Qs,N,Ts); 
No5.setSpeed(v1);
% Start function of timer. 
t.StartFcn = @(~,~)initTimer_d(t,No7,No9,r1,v1);
t.TimerFcn = @(~,~)loopScript_d(t,Ao,Bo,Co,L,ctrl,No7,No9,r2,r1);
t.StopFcn = @(~,~)StopTimer_d(t,No7,No5,No9);
start(t) 
run('Plot_d')