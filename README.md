# 2D vertex model with stretch, propulsion and contraction

This MATLAB script simulates a simple vertex model for describing the mechanics of epithelial tissues embedded in a viscous medium. The dynamics of each vertex is governed by the gradient of an energy function and nodal dissipation forces. The models allows for tissue fluidization, T1 topological transitions, cellular contraction, tissue stretching and self-propulsion of individual cells. Such script can serve as an entry point and a pedagogical tool to understand vertex modelling in the context of dynamic packing and rearrangement of planar epithelia. The model is described in [[1,2,3,4](#References)].

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
├── AUTHORS.md           # <--- For citation purposes 
└── .gitignore           # <--- Contains files to be ignored by git 
```

## Running a simulation

To run a simulation, open and the "vertexmodel.m" file in Matlab.

There are four scenarios available :
* a default state to visualise tissue fluidity
* cells individually moving through the tissue ("propulsion")
* cells individually contracting ("contraction")
* tissue stretching ("stretching").

For each scenario, the user can choose between a "fluid" tissue or a "rigid" tissue, which depends on the target shape index [[3](#References)].

Simulations parameters can be modified in the "parameters.m" file.

## Outputs and data visualisation

At each timestep, the code saves a frame in a video object to create a movie at the end. The title of the video file corresponds to the scenario.


## Cite 

You can acknowledge this package in any publication or pedagogical session that relies on it by citing the following link https://github.com/aouzeri/2DVertexModel.

## References

[1] Farhadifar et al. 2007 (https://doi.org/10.1016/j.cub.2007.11.049) \
[2] Staple et al. 2010 (https://doi.org/10.1140/epje/i2010-10677-0) \
[3] Bi et al. 2015 (https://doi.org/10.1038/nphys3471) \
[4] Fletcher et al. 2014 (http://dx.doi.org/10.1016/j.bpj.2013.11.4498)