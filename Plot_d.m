AA = get(t, 'UserData');
t_p = (1:AA(1,1))*Ts;
y_p1 = AA(9,:);
y_p2 = AA(10,:);
u_p1 = AA(6,:);
u_p2 = AA(7,:);
r_p = AA(8,:);
yob_p1 = AA(11,:);
yob_p2 = AA(14,:);
figure()
subplot(2,1,1)
plot(t_p,u_p1); grid on;
xlabel('Time [s]'); ylabel('Acelerance [-]');title('u = f(t)');
legend('u','Location','NorthEastOutside')
subplot(2,1,2)
plot(t_p,r_p,'r',t_p,y_p1,'b'); grid on; hold on;
xlabel('Time [s]'); ylabel('Distance [cm]');title('y = f(t)');
legend('ref','out','Location','NorthEastOutside')
figure()
subplot(2,1,1)
plot(t_p,u_p2); grid on;
xlabel('Time [s]'); ylabel('Acelerance [-]');title('u = f(t)');
legend('u','Location','NorthEastOutside')
subplot(2,1,2)
plot(t_p,r_p,'r',t_p,y_p2,'b'); grid on; hold on;
xlabel('Time [s]'); ylabel('Distance [cm]');title('y = f(t)');
legend('ref','out','Location','NorthEastOutside')
