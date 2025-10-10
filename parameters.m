%% Simulation parameters

% T1 transition parameters
param.maxT1relaxsteps = 30;
param.T1_TOL   = 0.01;      % tolerance to perform a T1 swap
param.nT1      = 0;         % to store the number of T1 transitions occured

% simulation time parameters
param.deltat   = 0.001;      % initial timestep
param.Tsim     = 0;         % simulation time
param.Nsteps   = 10;       % simulation time
param.isBoundaryFixed = 0;  % fixed boundary doesn't allow for periodic jumps

% cells parameters
param.rstiff   = 0.5;              % stiffness factor
param.ka       = 1.0;             % area term premultiplier
param.eta      = 0.1;               % vertex viscosity

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
if strcmp(Case,'propulsion')
    param.SelfPropellingCellIDs = 24;
    param.vel0     = 0.0;               % velocity of self-propulsion
    param.meanPropulsionAngle = [pi/2,3*pi/2];
elseif strcmp(Case,'contraction')
    param.cellIDtoContract = [67 66 50 122 79 17 35 20 102 33 31 144 ...
        57 59 63 26 104 123 94 64 24 77 32 59 ...
        57 63 24 81 130 99 37 90 128];   % change specific cell property at a givent time point
    param.multFactorForContraction = 1; % 0.25
elseif strcmp(Case,'stretching')
    param.StretchAtStep = floor(param.Nsteps/5);
    param.StretchRatio  = 2;
    param.ApplyStretchX = true;             % apply stretch in the x direction
    param.cellIDstoTrack = [13,33,12,28];   % red coloring cells
else
    error('Please choose a given scenario : "propulsion" or "contraction" or "stretching".')
end

%% Target shape index
% threhsold between solid and fluid phase is at ~ 3.8 (Bi et al. 2015)
if strcmp(Tissue_fluidity,'fluid')
    fprintf(1,'Tissue is now %s\n',Case);
    param.p0 = 3.9; % below 4 for cleaner simulation results
    parm.multFactorForContraction = min(param.multFactorForContraction,1.5);
elseif strcmp(Tissue_fluidity,'solid')
    param.p0 = 3;
    parm.multFactorForContraction = min(param.multFactorForContraction,2.5);
    fprintf(1,'Tissue is now %s\n',Case);
else
    error('Please choose a given tissue fluidity case : "fluid" or "solid".')
end
