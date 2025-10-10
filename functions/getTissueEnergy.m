function totalenergy = getTissueEnergy(celldata,param)
%% GETTİSSUEENERGY: returns total energy of the collection of cells

totalenergy = 0;
for cellID = 1:celldata.nCells
    
    Acell  = celldata.A(cellID);
    Pcell  = celldata.P(cellID);
    p0     = param.p0;
    rstiff = param.rstiff;
    ka     = param.ka;
    
    if cellID == param.cellIDtoContract
        rstiff = rstiff/param.multFactorForContraction;
    end
    
    % Energy functional
    energycell = ka*(Acell - 1.0)^2 + 1/rstiff * (Pcell - p0)^2; % Bi et al. 2015
    
    % Summing over all cells
    totalenergy = totalenergy + energycell;
end
