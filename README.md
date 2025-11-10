# 2D vertex model with stretch, propulsion and contraction
The purpose of the present Matlab code is to simulate the dynamics of planar cohesive sheets of cells using vertex modelling. The model is described in [[1,2,3,4](#References)].

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

There are three scenarios available : cells individually moving through the tissue ("propulsion"), cells individually contracting ("contraction"), and the tissue stretching ("stretching").
For each scenario, the user can choose between a fluid tissue or a solid tissue.
Simulations parameters can be modified in the "parameters.m" file.

## Data visualisation

At each timestep, the code saves a frame in a video object to create a movie at the end. The title of the video file corresponds to the scenario.

## Expected outputs



## Cite 

You can acknowledge this package in any publication or pedagogical session that relies on it using reference [[2]](#References).

## References

[1] Farhadifar et al. 2007 (https://doi.org/10.1016/j.cub.2007.11.049)
[2] Staple et al. 2010 (https://doi.org/10.1140/epje/i2010-10677-0)
[3] Bi et al. 2015 (https://doi.org/10.1038/nphys3471)
[4] Fletcher et al. 2014 (http://dx.doi.org/10.1016/j.bpj.2013.11.4498)