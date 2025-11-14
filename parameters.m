%% Simulation parameters

% T1 transition parameters
param.maxT1relaxsteps = 20;
param.T1_TOL   = 0.05;      % tolerance to perform a T1 swap
param.nT1      = 0;         % to store the number of T1 transitions occured

% simulation time parameters
param.deltat   = 0.01;      % initial timestep
param.Tsim     = 0;         % simulation time
param.Nsteps   = 10000;     % simulation time
param.isBoundaryFixed = 0;  % fixed boundary doesn't allow for periodic jumps
param.nFrames = 300;        % number of frames for movie 

% cells parameters
param.rstiff   = 0.1;             % stiffness factor
param.eta      = 0.5;             % vertex viscosity

% stretchting parameters
param.StretchAtStep = param.Nsteps + 1; % not stretching by default
param.StretchRatio  = 1;
param.ApplyStretchX = false;            % apply stretch in the x direction
param.BoxIncompressibility = true;      % conserve area when applying stretch
param.Lx0 = param.Lx;
param.Ly0 = param.Ly;
param.cellIstoTrack = 0;   % tracking neighbouring cells

% contraction parameters (no contraction by default)
param.multFactorForContraction = 1;

%% Mechanical stimulus
if strcmp(param.case,'propulsion')
    param.cellIDstoTrack = randperm(celldata.nCells,2);
    param.vel0     = [3.0,-3.0];               % velocity of self-propulsion
    param.meanPropulsionAngle = [pi/2,3*pi/2];
    param.eta      = 0.5;             % vertex viscosity
elseif strcmp(param.case,'contraction')
    param.cellIDstoTrack = randperm(celldata.nCells,ceil(celldata.nCells/10));   % change specific cell property at a givent time point
    param.multFactorForContraction = 0.5; % 0.25
    param.eta      = 0.5;             % vertex viscosity
elseif strcmp(param.case,'stretching')
    param.StretchAtStep = floor(param.Nsteps/5);
    param.StretchRatio  = 3.0;
    param.ApplyStretchX = true;             % apply stretch in the x direction
    param.cellIDstoTrack = randperm(celldata.nCells,celldata.nCells/10);   % red coloring cells
    param.eta      = 1.0;             % vertex viscosity

else
    error('Please choose a given scenario : "propulsion" or "contraction" or "stretching".')
end

%% Target shape index
% threhsold between solid and fluid phase is at ~ 3.8 (Bi et al. 2015)
if strcmp(Tissue_state,'fluid')
    fprintf(1,'Tissue is now %s\n',param.case);
    param.p0 = 3.96; % below 4 for cleaner simulation results
    parm.multFactorForContraction = min(param.multFactorForContraction,1.5);
elseif strcmp(Tissue_state,'solid')
    param.p0 = 3;
    parm.multFactorForContraction = min(param.multFactorForContraction,2.5);
    fprintf(1,'Tissue is now %s\n',param.case);
else
    error('Please choose a given tissue state : "fluid" or "solid".')
end
