% function dCdt = semi_batch_feed_rate_func(t,CV)
%
% Generic code for feeding 2 L of A to tank with 2 L of A over time
% Over time concentration of B should reduce due to dilution
%


function ddt = semi_batch_feed_rate_func(t,CV)


  % Unpack input vector (CV)
  Ca = CV(1); % Molar concentration of A [M]
  Cb = CV(2); % Molar concentration of B [M]
  V = CV(3); % Solution volume [L]


  % Reactant A feed parameters
  qa_in = 4/3600; % Feed: Volumetric flow rate of A [L/s]
  Ca_in = 0.04; % Feed: Concentration of A [M]
  fa_in = qa_in*Ca_in; % Feed: Molar flow rate of A [mol/s]
  Vadd = 2; % Feed: Volume addition [L]
  tadd = Vadd/qa_in; % Feed: Addition time [s]
  
  % Volume rate expression
  if t < tadd
      dVdt = qa_in;
      fa_in = qa_in*Ca_in;

  else 
      dVdt = 0;
      fa_in = 0;
  end

  % Mass balances for A & B
  dCadt = fa_in./V - (Ca./V).*dVdt; 
  dCbdt = - (Cb./V).*dVdt;


  % Pack up rates
  ddt = [dCadt; dCbdt; dVdt];

end

  