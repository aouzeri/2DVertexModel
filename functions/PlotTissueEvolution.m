%% Plotting evolution of tissue

nFrames = 50;

for tstep = 1:param.Nsteps
    % Applying stretch for plotting (does nothing when not wanted)
    applyStretchX;
    
    % Plotting every nVisualisation steps
    if mod(tstep,ceil(param.Nsteps/nFrames)) == 0
        figure();
        fprintf(1,'Plotting time step %d\n',tstep);
        p1 = plotTissue(celldata.nCells,Coordinates(:,2*tstep-1:2*tstep),Connectivity(:,tstep),param);
        rectangle('Position',[0 0 param.Lx param.Ly]);
        % exportgraphics(gcf,'testAnimated.gif','Append',true);
        % close(f3)
        pause(0.1)
    end
end
