% function dCdt = semi_batch_rate_func(t,CV)
%
% Generic code for solving semi-batch reaction va*A + vb*B -> vc*C
%
%

function ddt = semi_batch_rate_func(t,CV)


  % Unpack input vector (CV)
  Ca = CV(1); % Molar concentration of A [M]
  Cb = CV(2); % Molar concentration of B [M]
  Cc = CV(3); % Molar concentration of C [M]
  V = CV(4); % Solution volume [L]

 
  % Reaction kinetic parameters
  k = 2.5; % Rate constant for A + B -> C [L/mol.s]
  va = -1; % Stoichiometric coefficient of A
  vb = -1; % Stoichiometric coefficient of B
  vc =  1; % Stoichiometric coefficient of C
  a = abs(va); % Order of reaction with respect to reactant A
  b = abs(vb); % Order of reaction with respect to reactant B

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


  %Reaction rate expression
   r = k*Ca^(a).*Cb^(b);

  % Mass balances for reactants A & B as well as product C
  dCadt = fa_in/V + va*r - (Ca./V).*dVdt; 
  dCbdt = vb*r - (Cb./V).*dVdt;
  dCcdt = vc*r - (Cc./V).*dVdt;

  % Pack up rates
  ddt = [dCadt; dCbdt; dCcdt; dVdt];

end

  