%% Simulation parameters

% T1 transition parameters
param.maxT1relaxsteps = 20;
param.T1_TOL   = 0.05;      % tolerance to perform a T1 swap
param.nT1      = 0;         % to store the number of T1 transitions occured

% simulation time parameters
param.deltat   = 0.01;     % initial timestep
param.Tsim     = 0;         % simulation time
param.Nsteps   = 10000;       % simulation time
param.isBoundaryFixed = 0;  % fixed boundary doesn't allow for periodic jumps

% cells parameters
param.rstiff   = 1.0;             % stiffness factor
param.eta      = 1.0;             % vertex viscosity

% stretchting parameters
param.StretchAtStep = 100000;
param.StretchRatio  = 1;
param.ApplyStretchX = false;            % apply stretch in the x direction
param.BoxIncompressibility = true;      % conserve area when applying stretch
param.Lx0 = param.Lx;
param.Ly0 = param.Ly;
param.cellIDstoTrack = 0;   % tracking neighbouring cells

% contraction parameters
param.multFactorForContraction = 1;
param.cellIDtoContract = [];

%% Mechanical stimulus
if strcmp(param.case,'propulsion')
    param.cellIDstoTrack = 12;
    param.vel0     = 5.0;               % velocity of self-propulsion
    param.meanPropulsionAngle = [pi/2,3*pi/2];
elseif strcmp(param.case,'contraction')
    param.cellIDstoTrack = [67 66 50 122 79 17 35 20 102 33 31 144 ...
        57 59 63 26 104 123 94 64 24 77 32 59 ...
        57 63 24 81 130 99 37 90 128];   % change specific cell property at a givent time point
    param.multFactorForContraction = 1; % 0.25
elseif strcmp(param.case,'stretching')
    param.StretchAtStep = floor(param.Nsteps/5);
    param.StretchRatio  = 2;
    param.ApplyStretchX = true;             % apply stretch in the x direction
    param.cellIDstoTrack = [13,33,12,28];   % red coloring cells
else
    error('Please choose a given scenario : "propulsion" or "contraction" or "stretching".')
end

%% Target shape index
% threhsold between solid and fluid phase is at ~ 3.8 (Bi et al. 2015)
if strcmp(Tissue_state,'fluid')
    fprintf(1,'Tissue is now %s\n',param.case);
    param.p0 = 3.92; % below 4 for cleaner simulation results
    parm.multFactorForContraction = min(param.multFactorForContraction,1.5);
elseif strcmp(Tissue_state,'solid')
    param.p0 = 3;
    parm.multFactorForContraction = min(param.multFactorForContraction,2.5);
    fprintf(1,'Tissue is now %s\n',param.case);
else
    error('Please choose a given tissue state : "fluid" or "solid".')
end
