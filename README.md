# 2D vertex model with stretch, propulsion and contraction
The purpose of the present Matlab code is to simulate the dynamics of planar cohesive sheets of cells using vertex modelling. The model is described in [[1](#References)].

## License 
Distributed under the GNU GENERAL PUBLIC LICENSE. See [LICENSE](LICENSE) for details.

## Code Organization and Project Setup

The folder is organized as follows :
```bash
.                        # <--- Top-level (or root) directory of the project (called agvm_domes)   
├── parameters.m         # <--- File containing the model parameters
├── vertexmodel.m        # <--- Main executable file to run the vertex model simulation
├── functions            # <--- Folder containing the helper functions
├── README.md            # <--- Project overview and usage instruction
├── AUTHORS.md           # <--- List of project authors and contributors  
└── .gitignore           # <--- Contains files to be ignored by git 
```

## Running a simulation

To run a simulation, open and the "vertexmodel.m" file in Matlab.

There three scenarios available : cells individually moving through the tissue ("propulsion"), cells individually contracting ("contraction"), and the tissue stretching ("stretching").
For each scenario, the 


Simulations parameters can be modified in the "parameters.m" file.


## Data visualisation

At each timestep, the code saves a frame in a video object to create a movie at the end.

## Expected outputs

Here we show snapshots of the results for an inflated and deflating dome. We simulate spherical dome inflation and deflation in a monolayer attached to a substrate by fixing nodes outside a circular basal footprint. Once the dome deflates, nodes in renewed contact with the substrate are fixed.

We first start with a flat monolayer

![plot](post-processing/initial_state.png)

We then inflate and hold the dome over a large periode of time allowing sufficient time for the active gel dynamics to relax. 

![plot](post-processing/inflated_dome.png)

Finaly, we rapidely deflate the dome, causing the tissue to buckle and to form wrinkling patterns upon contact with the substrate. 

![plot](post-processing/deflating_dome_1.png)
![plot](post-processing/deflating_dome_2.png)
![plot](post-processing/deflating_dome_3.png)

Time shown in the snapshots are in turnover timescale. 

Note that the snapshots shown correspond to approximately 0h, 1h35,  2h, 3h15 and 10h of simulation time, respectively, using 8 cores on a Dell Intel® Xeon(R) Silver 4208 CPU @ 2.10GHz × 32. During the deflation phase, the time-step decreases for numerical convergence as the dome buckles and cells come in contact. 

## Cite 

You can acknowledge this package in any publication that relies on it using reference [[2]](#References).

## References

[1] Santos-Oliván, D., Vilanova, G., & Torres-Sánchez, A. (2025). hiperlife. Zenodo. https://doi.org/10.5281/zenodo.14927572

[2] Nimesh Chahare, Adam Ouzeri, Thomas Wilson, Pradeep K. Bal, Tom Golde, Guillermo Vilanova, Pau Pujol-Vives, Pere Roca-Cusachs, Xavier Trepat, Marino Arroyo. Multiscale wrinkling dynamics in epithelial shells. bioRxiv 2025.06.30.662426; doi: https://doi.org/10.1101/2025.06.30.662426

[3] Adam Ouzeri. Theory and computation of multiscale epithelial mechanics : from active gels to vertex models. Doctoral thesis. doi: https://doi.org/10.5821/dissertation-2117-402162

