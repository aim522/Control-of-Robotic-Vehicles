function y = setDrvFact(u)
global robot;
global drv_fact;
if(u~=drv_fact)
    robot.setDrvFact(u);
    drv_fact = u;
end
y = u;
end