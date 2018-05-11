function y = setStopDist(u)
global robot;
global stop_dist;
if(u~=stop_dist)
    robot.setStopDist(u);
    stop_dist = u;
end
y = u;
end