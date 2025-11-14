%% Plotting evolution of tissue

mov(1:param.nFrames) = struct('cdata',[], 'colormap',[]);
k = 1;

writerObj = VideoWriter(param.case);
writerObj.FrameRate = 10;
open(writerObj)


for tstep = 1:param.Nsteps
    % Applying stretch for plotting (does nothing when not wanted)
    applyStretchX;

    % Plotting every nVisualisation steps
    if mod(tstep,ceil(param.Nsteps/param.nFrames)) == 0
        f = figure(4);
        set(f,'Visible', 'off')
        xlim([-0.1*param.Lx0 1.1*param.Lx0*param.StretchRatio]);
        ylim([-0.1*param.Ly0 1.1*param.Ly0]);     
        hold on
        fprintf(1,'Saving step %d\n',tstep);
        plotTissue(celldata.nCells,Coordinates(:,2*tstep-1:2*tstep),Connectivity(:,tstep),param);
        rectangle('Position',[0 0 param.Lx param.Ly]);
        mov(k) = getframe(gcf);
        % drawnow;
        writeVideo(writerObj,mov(k));
        hold off
        close(4)
        k = k + 1;
    end
end
close(writerObj)
