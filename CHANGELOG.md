# Changelog PopulationDensityData

## Table of Contents

- [v0.1.0](#v010)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

# v0.1.0

**This is the first alpha version of the Population Density Data API.** 

- API [definition](https://github.com/camaraproject/PopulationDensityData/tree/release-v0.1.0/code/API_definitions)
- API [documentation](https://github.com/camaraproject/PopulationDensityData/tree/release-v0.1.0/documentation/API_documentation)

## Please note:

- This is an **initial version**.
- There are bug fixes to be expected and incompatible changes in upcoming versions. 

## What's changed

* New API `Population Density Data`, v0.1.0, with a single operation for retrieving population density information in the specified area:
    - Given a specific area as a polygon shape, a precision level and a time interval in which the service provider wants to obtain the population density, the API will return the data set of time ranges and equal sized cells containing the estimated population densitity of each time slot and cell.
