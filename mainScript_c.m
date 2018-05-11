%% CENTRAL
clear; close all;
w1 = 10;
w2 = 15;
w3 = 10;
v1 = 50;
Ts = 0.25;
t = timer;                     
t.Period = Ts;               
t.ExecutionMode = 'fixedRate';
t.TasksToExecute = 180;

A = [0 0 0; 1 0 0; 0 0 0]; B = [0 0; -1 0; 1 -1];
C = [0 1 0; 0 0 1]; D = [0 0;0 0];
sys =  ss(A, B, C, D); ssd =  c2d(sys,Ts);
Ad  =  ssd.A; Bd  =  ssd.B; Cd  =  ssd.C; Dd  =  ssd.D;

N5 = RoboBug('192.168.1.205'); N5.connect; N5.setAuto(1); N5.setStopDist(1);
N7 = RoboBug('192.168.1.207'); N7.connect; N7.setAuto(1); N7.setStopDist(1);   
N9 = RoboBug('192.168.1.209'); N9.connect; N9.setAuto(1); N9.setStopDist(1);   
R = 1e-2; Q = 1e3;Qs = 1e5; N = 5; 
[ctrl] = optMPC(Ad,Bd,Cd,Q,R,Qs,N,Ts); 
N5.setSpeed(v1);
t.StartFcn = @(~,~)initTimer_c(t,No7,No9,r1,v1);
t.TimerFcn = @(~,~)loopScript_c(t,ctrl,N5,N7,N9,r2,r3,v1)

t.StopFcn = @(~,~)StopTimer_c(t,N7,N5,N9);
start(t)
disp('Done')
disp('Plot_c')
