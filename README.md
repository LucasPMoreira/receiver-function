# Time Domain Receiver Function Deconvolution using Genetic Algorithm

Receiver Function traces are a well-known method for Earth’s crustal modeling using passive teleseismic data. These traces are formed by the deconvolution of three-component seismograms, resulting an impulse train with each peak amplitude and time location representing the depth and gradient of model’s discontinuities. In this project, it is implemented calculation of seismogram deconvolution and build a Receiver Function trace based on Genetic Algorithms, where a collection of time-shifted impulses is set as an individual chromosome and a population of possible solutions evolves using cross-over and mutation operations. The best parameters are then optimized using a gradient descent algorithm. The method is entirely in time-domain. It can be easily automated for large data set processing as it does not require user interaction during parameters optimization. The algorithm was tested with synthetic data as well as with teleseismic signals recorded by a seismic station, showing coherent results.

### Prerequisites

The scripts are all written in Matlab version R2014a. It is expected to work in newer versions. The following toolboxes and scripts are required:

- Signal Processing Toolbox
- Michael Thorne's SACLAB

This version only works with seismic files in SAC format (http://ds.iris.edu/files/sac-manual/)

### Installing

Once installed Matlab R2014a, the scripts provided should be copied to the same folder.

```
SACLAB files can be copied to the same project folder, or included in Matlab's PATH variable
```

## Running the scripts

To run the code to calculate the RF of one seismic event, open the main.m and change the 'dataPath' variable to the full path of SAC seismic files. The resulting RF trace will be saved also in SAC format in the folder defined by the 'resultPath' variable. After changing these variables, run the main.m script.

Some configuration variables are important, and should be set for each application.

Receiver Function variables:
- maxTime => time length in seconds of resulted RF trace
- maxAmp => maximum amplitude of RF peaks

Genetic Algorithm variables:
- maxGen => number of generations of the population evolution
- allelLength => number of RF peaks to be used (number of allels in one individual's chromosome)
- popLength => number of individuals in the population
- matingRate => the population fraction of individuals selected to mate, and used to generate offsprings (float less than 1)
- mutationRate => the population fraction of allels to mutate (float less than 1)

## Built With

* [Matlab R2014a](https://www.mathworks.com/products/matlab.html)
* [SACLAB](http://home.chpc.utah.edu/~thorne/software.html) - SAC file read and write routines

## Authors

* **Lucas Moreira** - [Lucas Moreira](https://github.com/LucasPMoreira)

Citation [Moreira, L.P. 2019](https://doi.org/10.1109/LGRS.2019.2947136)
