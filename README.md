# vce-container

Apptainer container definition for the Virtual Cycling Environment (VCE).

This container contains SUMO, OMNeT++, and Veins for running the Virtual Cycling Environment (VCE).
For more information on the VCE, visit https://www.ccs-labs.org/software/vce/.


## Usage

You can obtain a prebuilt image from our [VCE page on OSF](https://osf.io/5v47u/).

Afterwards, you can open a subshell using the image by running

```bash
apptainer shell vce-container.sif
```

From there, all prerequisites for installing the Python projects and running the VCE should be available.
