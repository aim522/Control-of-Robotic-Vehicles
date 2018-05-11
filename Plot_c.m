AA = get(t, 'UserData');
% i,x_sim(3),y_sim(2),u_sim(2),w_sim(2)
t_p = (1:AA(1,1))*Ts;
y_p1 = AA(5,:);
y_p2 = AA(6,:);
u_p1 = AA(7,:);
u_p2 = AA(8,:);
w_p1 = AA(9,:);
w_p2 = AA(10,:);
figure()
subplot(2,1,1)
plot(t_p,u_p1); grid on;
xlabel('Time [s]'); ylabel('Acelerance [-]');title('u = f(t)');
legend('u','Location','NorthEastOutside')
subplot(2,1,2)
plot(w_p1,'r'); grid on; hold on;plot(y_p1,'b')
xlabel('Time [s]'); ylabel('Distance [cm]');title('y = f(t)');
legend('ref','out','Location','NorthEastOutside')
figure()
subplot(2,1,1)
plot(t_p,u_p2); grid on;
xlabel('Time [s]'); ylabel('Acelerance [-]');title('u = f(t)');
legend('u','Location','NorthEastOutside')
subplot(2,1,2)
plot(t_p,w_p2,'r',t_p,y_p2,'b'); grid on; hold on;
xlabel('Time [s]'); ylabel('Distance [cm]');title('y = f(t)');
legend('ref','out','Location','NorthEastOutside')
