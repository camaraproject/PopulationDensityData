<a href="https://github.com/camaraproject/PopulationDensityData/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/PopulationDensityData?style=plastic"></

# Population Density Data
Repository to describe, develop, document and test the Population Density Data API family

## Scope
* Service APIs for “Population Density Data” (see APIBacklog.md)  
* It provides the customer with the ability to:  
  * The service enables developers with the capability to get dynamic population density data in a specific area for a future date&time, considering anonymized information of the network connected devices in the requested area at the flight time.
    * Use Case (1): Providing BVLOS flight the data to meet SORA 2.5 requirements in terms of intrinsic Ground Risk Class (iGRC).
    * Use Case (2): Providing data to identify if the ground risk class for a given drone flight is acceptable for the time of the flight, or an alternative time should be considered to lower the risk.
  * Service Inputs: Area of the interest. Date & time (future) range.
  * Service Outputs: maximum, average and minimum population density value for the given area, and interval corresponding to the valid range of that value. (space and time maps).
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: December 2023
* Location: virtually  

## Meetings
* Meetings are held virtually [Click here to join (Zoom)](https://zoom-lfx.platform.linuxfoundation.org/meeting/95956472717?password=e4e7e889-ffb8-4fac-9e9d-d9adcaf2e711)
* Schedule: bi-weekly, Wednesday, 14:00 Europe/Amsterdam (CET) (13:00 UTC, 12:00 UTC during European DST).

  For date/time of next meeting see [previous meeting minutes](https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/MeetingMinutes).

## Status and released versions

* Note: Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.
* The release r1.2 contains the version 0.1.1 of the Population Density Data API. It is the release of the patch release v0.1.1. The release tag is [r1.2](https://github.com/camaraproject/PopulationDensityData/tree/r1.2).
- 0.1.1 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r1.2/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.2/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r1.2/code/API_definitions/population-density-data.yaml)
* The latest public release is available here: https://github.com/camaraproject/PopulationDensityData/releases/latest
* Other releases of this sub project are available in https://github.com/camaraproject/PopulationDensityData/releases
* For changes see [CHANGELOG.md](https://github.com/camaraproject/PopulationDensityData/blob/main/CHANGELOG.md)

## Contributorship and mailing list
* To subscribe / unsubscribe to the mailing list of this Sub Project and thus be / resign as Contributor please visit <https://lists.camaraproject.org/g/sp-pdd>.
* A message to all Contributors of this Sub Project can be sent using <sp-pdd@lists.camaraproject.org>.
