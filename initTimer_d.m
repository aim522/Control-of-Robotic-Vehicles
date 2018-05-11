function initTimer_d(t,No7,No9,r1,v1)
   AA = [1,Inf*ones(1,t.TasksToExecute);zeros(15,t.TasksToExecute+1)];
   x0 = [v1;No7.getDistance];xobs =[x0;0];u_p = 0;
   omega = [x0',v1,No9.getDistance,u_p,u_p,No7.getDistance,No9.getDistance,r1,xobs',v1,No9.getDistance,0];
   AA(2:end,1) = omega;
   t.UserData = AA;   
   disp('Timer has been initialised');
end