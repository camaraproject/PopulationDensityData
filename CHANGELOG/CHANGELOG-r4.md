# Changelog PopulationDensityData

<!-- TOC:START -->
## Table of Contents
- [r4.1](#r41)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r4.1

## Release Notes

This release candidate contains the definition and documentation of
* population-density-data 1.0.0-rc.1

The API definition(s) are based on
* Commonalities 0.8.0
* Identity and Consent Management 0.5.0

## population-density-data 1.0.0-rc.1

**population-density-data 1.0.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.3.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r4.1/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r4.1/code/API_definitions/population-density-data.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r4.1/code/API_definitions/population-density-data.yaml)

### Breaking changes

* N/A

### Added

* Add new PopoulationDensityData User Story by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/116
* test(population-density-data): add GEOHASHLIST support and rework time/error model by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/128
* Add new changes for Sync26 (geohashlist+Commonalities & ICM) by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/123

### Changed

* N/A

### Fixed

* fix(openapi): Fix #107 - Class Names are in SNAKE_CASE but should be … by @patrice-conil in https://github.com/camaraproject/PopulationDensityData/pull/108
* Fix incorrect ATP time-range assertions by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/119
* fix: delete additional text for RFC date time format by @albertoramosmonagas in https://github.com/camaraproject/PopulationDensityData/pull/104

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/PopulationDensityData/compare/r3.2...r4.1

