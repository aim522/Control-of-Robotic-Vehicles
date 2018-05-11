function loopScript_d(t,Ao,Bo,Co,L,ctrl,No7,No9,r2,r1)
    AA = get(t, 'UserData');
    var = AA(1,1);
    f(1:2) = AA(2:3,var);
    x_sim1 = f';
    f2(1:2) = AA(4:5,var);
    x_sim2 = f2';
    u_sim1 = AA(6,var);
    u_sim2 = AA(7,var);
    r_sim = AA(8,var);
    y_sim1 = AA(9,var);
    y_sim2 = AA(10,var);
    g(1:3) = AA(11:13,var);
    xobs1 = g';
    g2(1:3) = AA(14:end,var);
    xobs2 = g2';
    
    var = var + 1;
    if (var >= 60 && var < 120) 
        r_sim = r2;
    elseif (var >= 120 && var < 180) 
        r_sim = r1;
    end

    theta1 = [xobs1',u_sim1,r_sim];
    theta2 = [xobs2',u_sim2,r_sim];
    u_sim1 = ctrl(theta1);
    u_sim2 = ctrl(theta2);

    No7.setSpeed(round(u_sim1));
    No7.getDistance;
    y_sim1 = No7.getDistance;
    obs1 = Ao*xobs1 + Bo*u_sim1 + L*(y_sim1-Co*xobs1);

    No9.setSpeed(round(u_sim2));
    No9.getDistance;
    y_sim2 = No9.getDistance;
    obs2 = Ao*xobs2 + Bo*u_sim2 + L*(y_sim2-Co*xobs2);

    AA(1,1) = var;
    AA(2:3,var) = x_sim1(1:2);
    AA(4:5,var) = x_sim2(1:2);
    AA(6,var) = u_sim1;
    AA(7,var) = u_sim2;
    AA(8,var) = r_sim;
    AA(9,var) = y_sim1;
    AA(10,var) = y_sim2;    
    AA(11:13,var) = obs1(1:3);
    AA(14:end,var) = obs2(1:3);
    set(t, 'UserData', AA);
end