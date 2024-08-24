# Changelog PopulationDensityData

## Table of Contents

- **[r1.2](#r12)**
- [r1.1](#r11)
- [v0.1.0](#v010)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

# r1.2
## Release Notes

This release contains the definition and documentation of
* population-density-data v0.1.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0


## population-density-data v0.1.1

**population-density-data v0.1.1 is the public release of the version 0.1.1**

v0.1.1 is a patch release of v0.1.0 which includes only changes of the info object in alignment with Commonalities 0.4.0, completing the alignment with Commonalities v0.4.0 and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release. Test cases are included for API validation. No new features were included.

- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r1.2/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.2/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.2/code/API_definitions/population-density-data.yaml)

### Added
* Include testing definitions in .feature file for Fall24 meta-release by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/44

### Changed
* N/A

### Fixed
* N/A

### Removed
* N/A


# r1.1
## Release Notes

This release contains the definition and documentation of
* population-density-data v0.1.1-rc.1

The API definition(s) are based on
* Commonalities v0.4.0-rc.1
* Identity and Consent Management v0.2.0-rc.1


## population-density-data v0.1.1-rc.1

**population-density-data v0.1.1-rc.1 is the 1st release candidate of the version 0.1.1**

v0.1.1 will be a patch release of v0.1.0 which includes only changes of the info object in alignment with Commonalities 0.4.0.
- API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r1.1/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.1/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.1/code/API_definitions/population-density-data.yaml)

### Added
* Include  `x-camara-commonalities` by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41

### Changed
* Updated Authorization and authentication section according to I&CM last release (v0.2.0-rc1) by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41
* Updated API and error descriptions by @gregory1g in https://github.com/camaraproject/PopulationDensityData/pull/42

### Fixed

### Removed
* Remove `terms of service` and `contact` by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41


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
