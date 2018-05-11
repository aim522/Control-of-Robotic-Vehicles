function y = setSpeed(u)
global robot;
global speed;
if(u~=speed)
    robot.setSpeed(u);
    speed = u;
end
y = u;
end