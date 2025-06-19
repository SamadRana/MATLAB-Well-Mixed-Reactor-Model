  % Set-up 
  t0 = 0; % Initial time [s]
  tfinal = 140*60; % Final time [s]
  tspan = [t0,tfinal]; % Reaction duration [s]
  Ca0 = 0; % Initial concentraton of A [M]
  Cb0 = 0.04; % Initial concentration of B [M]
  V0 = 2; % Initial Volume [L]
  CV0 = [Ca0; Cb0; V0]; % Initial concentrations of A, B & C [M] & 


  % Solving for concentration of A, B & C over time
  options = odeset('RelTol',1e-10,'AbsTol',1e-10); %'InitialStep',0.01, 'MaxStep',1);
  [t,CV] = ode45(@semi_batch_feed_rate_func,tspan,CV0,options); %Switch to ode15s which is more robust for stiffer systems, i.e., slow feed rate but fast kinetics or vice versa


  % Unpack A, B & C
  Ca = CV(:,1);
  Cb = CV(:,2);
  V = CV(:,3);

  % Check moles
  Na = Ca.*V;
  Nb = Cb.*V;

  % Plot concentrations of A, B and volume V
  figure(1)
  plot(t./60,Ca,'r-',LineWidth=0.1)
  grid on
  hold on
  plot(t./60,Cb,'b--',LineWidth=0.1)
  xlabel('t [min]')
  ylabel('C [M]')
  legend('A','B')
  title('Plot of change in concentration of A and B against time')
  hold off

  figure(2)
  plot(t./60,V,'k-')
  grid on
  xlabel('t [min]')
  ylabel('V [L]')
  title('Plot of change in reactor volume against time')

  figure(3)
  subplot(3,1,1)
  plot(t./60,Ca,'k-')
  grid on
  xlabel('t [min]')
  ylabel('C_A [M]')
  ylim([0 0.04])
  title('Plot of concentration of A against time')

  subplot(3,1,2)
  plot(t./60,Cb,'k-')
  grid on
  xlabel('t [min]')
  ylabel('C_B [M]')
  ylim([0 0.04])
  title('Plot of concentration of B against time')

  subplot(3,1,3)
  plot(t./60,V,'k-')
  grid on
  xlabel('t [min]')
  ylabel('V [L]')
  title('Plot of reactor volume against time')

  figure(4)
  grid on
  hold on
  plot(t./60,Na,'r-',LineWidth=0.1)
  plot(t./60,Nb,'b--',LineWidth=0.1)
  xlabel('t [min]')
  ylabel('n [mol]')
  legend('A', 'B')
  hold off
  title('Plot of change in moles of A & B against time')

  disp(['Molar imbalance of B is ', num2str(Nb(1)-Nb(end))])