<a href="https://github.com/camaraproject/PopulationDensityData/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/PopulationDensityData/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/PopulationDensityData?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Incubating API Repository"><img src="https://img.shields.io/badge/Incubating%20API%20Repository-green?style=plastic"></a>

# PopulationDensityData

Incubating API Repository to evolve and maintain the definitions and documentation of PopulationDensityData Service API(s) within the Sub Project [Population Density Data](https://lf-camaraproject.atlassian.net/wiki/x/LwAwC) 

* API Repository [wiki page](https://lf-camaraproject.atlassian.net/wiki/x/3DXe)

## Scope
* Service APIs for “Population Density Data” (see APIBacklog.md)  
* It provides the API consumer with the ability to:  
  * The service enables developers with the capability to get dynamic population density data in a specific area for a specified date&time, considering anonymized information of the network connected devices in the requested area at the flight time.
    * Use Case (1): Providing BVLOS flight the data to meet SORA 2.5 requirements in terms of intrinsic Ground Risk Class (iGRC).
    * Use Case (2): Providing data to identify if the ground risk class for a given drone flight is acceptable for the time of the flight, or an alternative time should be considered to lower the risk.
  * Service Inputs: Area of the interest. Date & time range.
  * Service Outputs: maximum, average and minimum population density value for the given area, and interval corresponding to the valid range of that value. (space and time maps).
  * NOTE: The scope of these APIs should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: December 2023
* Incubating stage since: June 2025

## Status and released versions

* Note: Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.
* `NEW`: Pre-release r3.1 with version 0.3.0-rc.1 of the Population Density Data API is available in [r3.1](https://github.com/camaraproject/PopulationDensityData/tree/r3.1).
* 0.3.0-rc.1 Population Density Data API definition **with inline documentation**:
  - OpenAPI [YAML spec file](https://github.com/camaraproject/PopulationDensityData/blob/r3.1/code/API_definitions/population-density-data.yaml)
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.1/code/API_definitions/population-density-data.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/PopulationDensityData/r3.1/code/API_definitions/population-density-data.yaml)
* The latest public release is available here: https://github.com/camaraproject/PopulationDensityData/releases/latest
* Other releases of this sub project are available in https://github.com/camaraproject/PopulationDensityData/releases
* For changes see [CHANGELOG.md](https://github.com/camaraproject/PopulationDensityData/blob/main/CHANGELOG.md)

## Contributing

* Meetings are held virtually 
  * Schedule: bi-weekly, Wednesday, 14:00 Europe/Amsterdam (CET) (13:00 UTC, 12:00 UTC during European DST).
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/95956472717?password=e4e7e889-ffb8-4fac-9e9d-d9adcaf2e711)
  * For date/time of next meeting see previous [ meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/HwPe)
* Mailing List
  * Subscribe / Unsubscribe to the mailing list <https://lists.camaraproject.org/g/sp-pdd>.
  * A message to the community of this Sub Project can be sent using <sp-pdd@lists.camaraproject.org>.
