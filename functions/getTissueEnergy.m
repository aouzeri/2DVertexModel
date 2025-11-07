function totalenergy = getTissueEnergy(celldata,param)
%% GETTİSSUEENERGY: returns total energy of the collection of cells

totalenergy = 0;
for cellID = 1:celldata.nCells
    
    Acell  = celldata.A(cellID);
    Pcell  = celldata.P(cellID);
    A0     = param.A0;
    p0     = param.p0;
    rstiff = param.rstiff;
    
    if cellID == param.cellIDtoContract
        rstiff = rstiff/param.multFactorForContraction;
    end
    
    % Energy functional
    energycell = (Acell/A0 - 1.0)^2 + 1/rstiff * (Pcell/sqrt(A0) - p0)^2; % Bi et al. 2015

    % Summing over all cells
    totalenergy = totalenergy + energycell;
end
