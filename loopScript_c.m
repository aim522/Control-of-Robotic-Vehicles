function loopScript_c(t,ctrl,N5,N7,N9,r2,r3,v1)
    AA = get(t, 'UserData');
    var = AA(1,1);
    f(1:3) = AA(2:4,var);
    x_sim = f';
    g(1:2) = AA(5:6,var);
    y_sim = g';
    h(1:2) = AA(7:8,var);
    u_sim = h';
    j(1:2) = AA(9:10,var);
    r_sim = j';    

    var = var + 1;
    if var >= 60 && var < 120
        r_sim(1) = r2;
        r_sim(2) = r2;
    elseif var >= 120
        r_sim(1) = r3;
        r_sim(2) = r3;
    end

    x_sim(1) = v1;
    N9.getDistance;
    N7.getDistance;
    x_sim(2) = N9.getDistance;
    x_sim(3) = N7.getDistance;
    
    theta = [x_sim',u_sim',r_sim'];
    u_sim(:) = ctrl(theta)
    N9.setSpeed(round(u_sim(1)));
    N7.setSpeed(round(u_sim(2)));

    %% Cleaning up the variables
    AA(1,1) = var;
    AA(2:4,var) = x_sim(1:3);
    AA(5:6,var) = y_sim(1:2);
    AA(7:8,var) = u_sim(1:2);
    AA(9:10,var) = w_sim(1:2);
    set(t, 'UserData', AA);
end