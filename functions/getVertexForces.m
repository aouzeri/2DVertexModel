function f = getVertexForces(celldata,param,tstep)
% GETVERTEXFORCES Computes the nodal force vectors from the gradient of the
% mechanical energy functional  of the form E = (a_i - 1) + (p_i - p_0)^2/r
% following Staple et al. 2010 and Bi et al. 2015

% Initialize forces on each vertex
f = zeros(size(celldata.f));

% Looping over each cell
for cellID = 1:celldata.nCells
    
    Acell          = celldata.A(cellID);
    Pcell          = celldata.P(cellID);
    A0             = param.A0;
    p0             = param.p0;
    rstiff         = param.rstiff;
    vertexcoordsold   = celldata.r;
    Lx                = param.Lx;
    Ly                = param.Ly;
    vertices       = celldata.connec{cellID};
    fcell          = zeros(size(celldata.f));

    if ismember(cellID,param.cellIDstoTrack) && tstep > 70
        A0 = A0*param.multFactorForContraction;
    end
    
    % Modifying vertex coordinates acocuntin for peridicity
    vertexcoords = modifyVerticesForPeriodicity(vertexcoordsold,vertices,Lx,Ly);
    
    
    for j = 1:length(vertices) % In anticlockwise order
        currVert = vertices(j);
        
        if j == length(vertices)
            nextVert = vertices(1);
        else
            nextVert = vertices(j+1);
        end
        
        if j == 1
            prevVert = vertices(end);
        else
            prevVert = vertices(j-1);
        end
        
        % Derivative of the cell perimeter with respect to the vertices (2 by 1)
        dPeri = getPerimeterDerivative(vertexcoords,currVert,nextVert,prevVert);
        
        % Derivative of the area with next vertex and the pericenter (2 by 1)
        dA    = getAreaDerivative(vertexcoords,vertices,currVert,nextVert,prevVert);
        
        [LiA, LiB] = ismember(cellID,param.cellIDstoTrack);
        if LiA && strcmp("propulsion",param.case)
            Theta =  param.meanPropulsionAngle(1) + randn(1);
            polarityVector = [cos(Theta),sin(Theta)];
            % distribute the force among all vertices (the greater the
            % number of vertices, the lower the force per vertices)
            selfPropulsionForce = param.vel0(LiB) * polarityVector/length(celldata.connec{cellID});
        else
            selfPropulsionForce = [0, 0];
        end
        
        % Adding contributions from a cell to its vertices
        fcell(currVert,:) = fcell(currVert,:) - ...
            2.0 * (Acell/A0 - 1) * dA/A0 - 2.0/rstiff * (Pcell/sqrt(A0) - p0) * dPeri /sqrt(A0) + selfPropulsionForce;        
    end
    
    % Implementing fixed boundary
    if param.isBoundaryFixed == 1
       fcell(celldata.boundaryNodes,:) = 0; 
    end
    
    % Summing over all cells
    f = f + fcell;
end
