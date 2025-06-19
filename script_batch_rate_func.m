t0 = 0; % Initial time [s]
tfinal = 300*60; % Final time [s]
tspan = [t0,tfinal]; % Reaction duration [s]
Ca0 = 0.04; % Initial concentraton of A [M]
Cb0 = 0.04; % Initial concentration of B [M]
Cc0 = 0; % Initial concentration of C [M]
C0 = [Ca0; Cb0; Cc0]; % Initial concentrations of A, B & C

% Solving for concentration of A, B & C over time
[t,C] = ode45(@batch_rate_func,tspan,C0);


% Unpack concentrations of A, B & C
Ca = C(:,1);
Cb = C(:,2);
Cc = C(:,3);

V = 2; % Volume of reactor [L]

% Convert concentrations to moles of A, B and C
Na = Ca*V; % Moles of A [mol]
Nb = Cb*V; % Moles of B [mol]
Nc = Cc*V; % Moles of C [mol]


% Plot concentrations of A, B & C
figure(1)
subplot(3,1,1)
plot(t./60,Ca,'k-')
grid on
xlabel('t [min]')
ylabel('C_A [M]')
title('Plot of concentration of A against time')

subplot(3,1,2)
plot(t./60,Cb,'k-')
grid on
xlabel('t [min]')
ylabel('C_B [M]')
title('Plot of concentration of B against time')

subplot(3,1,3)
plot(t./60,Cc,'k-')
grid on
xlabel('t [min]')
ylabel('C_C [M]')
title('Plot of concentration of C against time')

figure(2)
grid on
plot(t./60,Na,'-*k')
hold on
plot(t./60,Nb,'-og')
plot(t./60,Nc,'-r')
xlabel('t [min]')
ylabel('N [mol]')
legend('A','B','C')