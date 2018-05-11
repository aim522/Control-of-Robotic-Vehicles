function initTimer_c(t,No7,No9,r1,v1)
   AA = [1,Inf*ones(1,t.TasksToExecute);zeros(9,t.TasksToExecute+1)];
   x0 = [v1;No7.getDistance;No9.getDistance];
   w_sim = [w1;w1];u_p = [0;0];
   omega = [x0',x0(2:3)',u_p',w_sim'];
   AA(2:end,1) = omega;
   t.UserData = AA;   
   disp('Timer has been initialised');
end