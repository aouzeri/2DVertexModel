%% Vertex modelling of planar sheets
%
% Authors Adam Ouzeri, Sohan Kale
%
% This script simulates a simple vertex model whose dynamics is governed by
% the minisation of an energy functional and nodal dissipation
% forces. The models allows for tissue fluidization, T1 topological
% transitions, cellular contraction, stretching of the tissue and
% self-propulsion of individual cells. 
% Such script can serve, for example, as a pedagogical tool to understand vertex
% modelling in the context of dynamic packing and rearrangment of planar
% epithelia.
%
% The script first generates a tissue as a collection of Voronoi cells from
% randomly generated points in a box.
%
% Self-propulsion : a selected cell migrates in a randomly selected
% direction within a range of angles at each timestep
%
% References :
%   - Farhadifar et al. 2007 (https://doi.org/10.1016/j.cub.2007.11.049)
%   - Staple et al. 2010 (https://doi.org/10.1140/epje/i2010-10677-0)
%   - Bi et al. 2015 (https://doi.org/10.1038/nphys3471)
%   - Fletcher et al. 2014 (http://dx.doi.org/10.1016/j.bpj.2013.11.4498)
%  

addpath('./functions')

close all;
clear;
clc;
rng('default');

%% 1 - Initialising the parameters

%%% Choose tissue size
param.Lx       = 20;                 % box length in x
param.Ly       = 20;                 % box length in y

%%% Choose tissue fluidity (comment unwanted)
Tissue_state = 'fluid';
% Tissue_state = 'solid';

%%% Choose a scenario (comment unwanted)
param.case = "propulsion"; % self-propelled cell
% param.case = "contraction"; % contracting a single cell
%param.case = "stretching"; % stretching tissue

%% 2 - Setting all parameters
parameters;

%% 3 - Generating mesh
celldata = genVoronoiTessellation(param);
param.A0 = mean(celldata.Ainit); % target area took as the average of all cells at the beginning 

% plotting initial state
figure(2)
p = plotTissue(celldata.nCells, celldata.r, celldata.connec,param);
rectangle('Position',[0 0 param.Lx param.Ly]);
pause(0.1)

%% 4 - Computing
totalsimtime = tic;

energymat = zeros(param.Nsteps,1);
timemat   = zeros(param.Nsteps,1);
T1flagVec    = zeros(celldata.nMasterVertices,1);
T1relaxstepcountVec = zeros(size(T1flagVec));

Coordinates = zeros(celldata.nMasterVertices,2*param.Nsteps);
Connectivity = cell(celldata.nCells,param.Nsteps);

%% 5 - Time loop
for tstep = 1:param.Nsteps
    
    %% Applying stretch (does nothing when not wanted)
    applyStretchX;
        
    %% Mechanical energy at previous timestep
    [energymat0] = getTissueEnergy(celldata,param);
    
    %% Get forces based on the current configuration
    celldata.f = getVertexForces(celldata,param,tstep);
    
    %% Update vertex positions while maintaining periodicity
    celldata   = updateVertexPositions(celldata,param);
    
    %% Update cell area and perimeters from new vertex positions
    celldata.A = getCellAreas(celldata,param);
    [celldata.P, celldata.EdgeData] = getCellPerimeters(celldata.nCells,celldata.r,celldata.connec,param);
    
    %% Check for T1 transitions and update
    % After performing the T1-swap, edge is relaxed for maxT1relaxsteps
    % steps while keeping all other potential T1-swaps on hold
    [celldata.r,celldata.connec,celldata.EdgeData,celldata.verttocell, T1flagVec,T1relaxstepcountVec,param.nT1]   = checkT1transitions(celldata.nCells,celldata.r,celldata.connec,celldata.EdgeData,celldata.verttocell,param,T1flagVec,T1relaxstepcountVec);
    
    
    %% Storing current state for plotting purposes
    Coordinates(:,2*tstep - 1:2*tstep) = celldata.r;
    Connectivity(:,tstep)= celldata.connec;
    
    %% Update time if no more T1 possible
    param.Tsim = param.Tsim + param.deltat;
    celldata.r0 = celldata.r;
    
    %% Update status
    energymat(tstep) = getTissueEnergy(celldata,param);
    timemat(tstep)   = param.Tsim;
    if tstep == 1
        relenergychange  = (energymat(tstep) - energymat0)/ energymat0;
    else
        relenergychange  = (energymat(tstep) - energymat(tstep-1))/ energymat(tstep-1);
    end
    
    PrintInformation;
end

%% 6 - Post-Processing
% Plotting time evolution of the energy
figure(3); hold on; plot(timemat, energymat, 'LineWidth', 3.0); title('Energy vs time')

% Plotting time evolution of the tissue
PlotTissueEvolution;


