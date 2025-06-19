% function dCdt = batch_rate_func(t,C)
%
% Generic code for solving batch reaction va*A + vb*B -> vc*C
%
%


function dCdt = batch_rate_func(t,C)

  % Pack input vector (C)
  Ca = C(1); % Molar concentration of A [M]
  Cb = C(2); % Molar concentration of B [M]
  Cc = C(3); % Molar concentration of C [M]

  % Parameters
  k = 0.1; % Rate constant for A + B -> C [L/mol.s]
  va = -1; % Stoichiometric coefficient of A
  vb = -1; % Stoichiometric coefficient of B
  vc =  1; % Stoichiometric coefficient of C

  % Reaction orders (assumed equal to stoichiometric coefficients here)
  a = abs(va); % Order of reaction with respect to reactant A
  b = abs(vb); % Order of reaction with respect to reactant B

  % Rate expression for batch process: Accumulation = Generation - Consumption
  r = k*Ca^(a).*Cb^(b);

  % Mass balances for reactants A & B as well as product C
  dCadt = va*r; 
  dCbdt = vb*r;
  dCcdt = vc*r;

  % Pack up rates
  dCdt = [dCadt; dCbdt; dCcdt];

end


  