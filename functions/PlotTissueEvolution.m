%% Plotting evolution of tissue

nFrames = 50;
mov(1:nFrames) = struct('cdata',[], 'colormap',[]);
k = 1;

writerObj = VideoWriter(param.case);
open(writerObj)


for tstep = 1:param.Nsteps
    % Applying stretch for plotting (does nothing when not wanted)
    applyStretchX;

    % Plotting every nVisualisation steps
    if mod(tstep,ceil(param.Nsteps/nFrames)) == 0
        figure(4)
        hold on
        fprintf(1,'Plotting time step %d\n',tstep);
        plotTissue(celldata.nCells,Coordinates(:,2*tstep-1:2*tstep),Connectivity(:,tstep),param);
        rectangle('Position',[0 0 param.Lx param.Ly]);
        mov(k) = getframe(gcf);
        drawnow;
        writeVideo(writerObj,mov(k));
        hold off
        close(4)
        k = k + 1;
    end
end
close(writerObj)
