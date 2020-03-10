# vce-container

Singularity container definition for the Virtual Cycling Environment (VCE).

This container contains SUMO and a compatible Python version for running the Virtual Cycling Environment (VCE).
For more information on the VCE, visit https://www.ccs-labs.org/software/vce/.

## Usage

To use a pre-built image, first pull it from Singularity Hub:

```bash
singularity pull shub://lumpiluk/vce-container
```

Afterwards, you can open a subshell using the image by running

```bash
./vce-container_latest.sif
```

From there, all prerequisites for running the VCE should be available.
