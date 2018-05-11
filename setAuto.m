function y = setAuto(u)
global robot;
global auto;
if(u~=auto)
    robot.setAuto(u);
    auto = u;
end
y = u;
end