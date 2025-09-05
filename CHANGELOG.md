# Changelog PopulationDensityData

## Table of Contents

- **[r3.2](#r32)**
- [r3.1](#r31)
- [r2.2](#r22)
- [r2.1](#r21)
- [r1.2](#r12)
- [r1.1](#r11)
- [v0.1.0](#v010)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

# r3.2
## Release Notes
This public release contains the definition and documentation of
* population-density-data v0.3.0

The API definition(s) are based on
* Commonalities v0.6.0
* Identity and Consent Management v0.4.0

## population-density-data v0.3.0

This is the public release for the CAMARA Meta Release Fall25 release of the Population Density Data API, version v0.3.0. It contains mainly alignments with the Commonalities v0.6.0.

- 0.3.0 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r3.2/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.2/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.2/code/API_definitions/population-density-data.yaml)

In the following there is the list of the modifications with respect to the previous release.

### Added
* Alignment with Commonalities r3.3 by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/94
* Migrate to centralized linting workflows by @hdamker-bot in https://github.com/camaraproject/PopulationDensityData/pull/95
* Align with commonalities 0.6 (XCorrelator pattern update, error text clarification for generic cases) and include Sink Error by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/91

### Changed
N/A

### Fixed
N/A

### Removed
N/A

### New Contributors
* @eric-murray made their first contribution in https://github.com/camaraproject/PopulationDensityData/pull/92

**Full Changelog**: https://github.com/camaraproject/PopulationDensityData/compare/r2.2...r3.2

# r3.1
## Release Notes

This release contains the definition and documentation of
* population-density-data v0.3.0-rc.1

The API definition(s) are based on
* Commonalities v0.6.0-rc.1
* Identity and Consent Management v0.4.0-rc.1


## population-density-data v0.3.0-rc.1

**population-density-data v0.3.0-rc.1 is the 1st release candidate of the version 0.3.0**

This is a pre-release candidate for the CAMARA Meta Release Fall25 release of the Population Density Data API, version v0.3.0-rc.1. It contains mainly alignments with the Commonalities v0.6.0-rc.1.

- 0.3.0-rc.1 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r3.1/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.1/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.1/code/API_definitions/population-density-data.yaml)

### Added
* Align with commonalities 0.6 (XCorrelator pattern update, error text clarification for generic cases) and include Sink Error by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/91

### Changed
N/A

### Fixed
N/A

### Removed
N/A

**Full Changelog**: https://github.com/camaraproject/PopulationDensityData/compare/r2.2...r3.1

# r2.2
## Release Notes

This release contains the definition and documentation of
* population-density-data v0.2.0

The API definition(s) are based on
* Commonalities v0.5.0
* Identity and Consent Management v0.3.0


## population-density-data v0.2.0

**population-density-data v0.2.0 is the public release of the Population Density Data API**

- 0.2.0 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r2.2/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r2.2/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r2.2/code/API_definitions/population-density-data.yaml)


Changes included in v0.2.0 compared to v0.1.1:
### Added
* Include new description to the sink endpoint and included start/endtime references to align API input and output. by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/57
* Include "OPERATION_NOT_COMPLETED" error for async operation by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/63
* Include operation ID for the async mechanism by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/64
* Add a pattern for x-correlator by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/71
* Support time window in the past in the APIexposure of data in the past is added by @gregory1g in https://github.com/camaraproject/PopulationDensityData/pull/60


### Changed
* Simplify class management and change of density value formats by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/59
* Update error with 422 by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/66
* Align error code & definition as specified in Commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/68
* Align population-density-data API with areaType format by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/69
* Align 429 messages by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/73
* Update API test plan for Population Density Data including new features and alignement with commonalities by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/76

### Fixed
N/A

### Removed
N/A

## New Contributors
* @bigludo7 made their first contribution in https://github.com/camaraproject/PopulationDensityData/pull/68

**Full Changelog**: https://github.com/camaraproject/PopulationDensityData/compare/r1.2...r2.2


# r2.1
## Release Notes

This release contains the definition and documentation of
* population-density-data v0.2.0-rc.1

The API definition(s) are based on
* Commonalities v0.5.0-rc.1
* Identity and Consent Management v0.3.0-rc.1


## population-density-data v0.2.0-rc.1

**population-density-data v0.2.0-rc.1 is the 1st release candidate of the version 0.2.0**

- 0.2.0-rc.1 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r2.1/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r2.1/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r2.1/code/API_definitions/population-density-data.yaml)

### Added
* Include new description to the sink endpoint and included start/endtime references to align API input and output. by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/57
* Include "OPERATION_NOT_COMPLETED" error for async operation by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/63
* Include operation ID for the async mechanism by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/64
* Add a pattern for x-correlator by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/71
* Support time window in the past in the APIexposure of data in the past is added by @gregory1g in https://github.com/camaraproject/PopulationDensityData/pull/60


### Changed
* Simplify class management and change of density value formats by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/59
* Update error with 422 by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/66
* Align error code & definition as specified in Commonalities 0.5 by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/68
* Align population-density-data API with areaType format by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/69
* Align 429 messages by @bigludo7 in https://github.com/camaraproject/PopulationDensityData/pull/73
* Update API test plan for Population Density Data including new features and alignement with commonalities by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/76

### Fixed
N/A

### Removed
N/A

## New Contributors
* @bigludo7 made their first contribution in https://github.com/camaraproject/PopulationDensityData/pull/68

**Full Changelog**: https://github.com/camaraproject/PopulationDensityData/compare/r1.2...r2.1

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
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.2/code/API_definitions/population-density-data.yaml)

### Added
* Include  `x-camara-commonalities` by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41
* Include testing definitions in .feature file for Fall24 meta-release by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/44
* Included documentation for the initial posible implementation algorithm by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/25
* Included API test plan for Population Density Data by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/44

### Changed
* Updated Authorization and authentication section according to I&CM latest release by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41
* Updated API and error descriptions by @gregory1g in https://github.com/camaraproject/PopulationDensityData/pull/42

### Fixed
* Align with Commonalities subscription-model by using sink and sinkCredentials by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/47

### Removed
* Remove `terms of service` and `contact` by @jgarciahospital in https://github.com/camaraproject/PopulationDensityData/pull/41


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
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.1/code/API_definitions/population-density-data.yaml)

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
