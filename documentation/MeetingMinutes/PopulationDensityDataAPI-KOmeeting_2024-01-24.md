# CAMARA Population Density Data API - KO meeting - 2024-01-24

*January 24th, 2024*

## Attendees

||
| --- |
|Sachin Kumar (Vodafone)|
|Thomas Wana (Dimetor)|
|Thomas Neubauer (Dimetor)|
|Violeta Gonzalez Fernandez (Telefonica)|
|Jorge Garcia Hospital (Telefonica)|



Population Density Data API minutes: [https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/MeetingMinutes](https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/MeetingMinutes)

## Agenda

* Presentation of the working group
	 * Density Population Data reference use cases
* Schedule and bi-weekly planification
* Timeline and next steps
* AoB
  

## Open Issues & PRs</br>


Item | Who | Description
---- | ---- | ----
N/A | N/A | N/A

## Introduction to the working group

Supporting material: [KO supporting material](https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/SupportingDocuments/KO%20-%20Population%20Density%20Data%20Proposal%20for%20Camara%20Standarizationv3.pptx)

### Scope

**API definition:** The Population Density Data API enables developers with the capability to get population density estimations for a specific area at a future date and time, considering historical anonymized information of the network connected devices in the requested area.

**API inputs (TBC):** Geographical area (2D map) and time range (future)

**API outputs (TBC):** Max, min and average estimated statistics of population density for the required map, divided in uniform cells depending on the accuracy of the data. In a time series, to include information for the complete requested time range


### Density Population Data reference use cases

For the reference use case, the API fills the need of assessing the ground risk to allow safe drone flights by providing estimations of the number of people under a drone flight path. This assessment will be needed every time a drone flight in the specific category need to conduct an operation and will help the operator to identify operational limitations, to develop the appropriate operational procedures and to identify mitigations and safety objectives. More information in [KO supporting material](https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/SupportingDocuments/KO%20-%20Population%20Density%20Data%20Proposal%20for%20Camara%20Standarizationv3.pptx)

## Discussion

Item | Discussion
---- | ---- 
Group Scope | Telefonica shares the proposal to include not only the specification of the API but also the agreement on the required algorithms of prediction and interpolation that are required in the API to provide a homogeneous response among operators. Aggrement reached.
Meeting Schedule | It's agreed to keep KO time schedule to be replicated in the following repetitions of the subgroup meetings. </br>Be-weekly meeting on Wednesday, 14:00 Europe/Amsterdam (CET) (13:00 UTC, 12:00 UTC during European DST), starting February, 7th.
Timeline and next steps | Schedule to close scope, prepare innitial yaml proposal and close RC version is proposed. 
AoB | N/A



- Next call will be **February 7th, 2024**

<p>
