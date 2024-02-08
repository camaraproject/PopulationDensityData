# CAMARA Population Density Data API - Follow-up meeting #1 - 2024-02-07

*February 07th, 2024*

## Attendees

||
| --- |
|Sachin Kumar (Vodafone)|
|Thomas Neubauer (Dimetor)|
|Violeta Gonzalez Fernandez (Telefonica)|
|Jorge Garcia Hospital (Telefonica)|



Population Density Data API minutes: [https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/MeetingMinutes](https://github.com/camaraproject/PopulationDensityData/tree/main/documentation/MeetingMinutes)

## Agenda

* Approval of previous meeting minutes #1 and meeting agenda
	* Confluence adoption 
* Open issues and PRs
	* Issues: #4
	* PRs: #3 #5
* Timeline and next steps
* AoB
  

## Open Issues & PRs</br>


Item | Who | Description
---- | ---- | ----
[PR#1](https://github.com/camaraproject/PopulationDensityData/pull/1) | Telefonica | Previous meeting material and minutes
[PR#2](https://github.com/camaraproject/PopulationDensityData/pull/2) | Telefonica | Readme update
[PR#3](https://github.com/camaraproject/PopulationDensityData/pull/3) | Verizon | Including new subgroup maintainer
[Issue#4](https://github.com/camaraproject/PopulationDensityData/issues/4) | Telefonica | Innitial scope agreement
[PR#5](https://github.com/camaraproject/PopulationDensityData/pull/5) | Telefonica | Innitial PopulationDensityData API spec proposal

## Approval of previous meeting minutes & documentation (#1)

[KO Meeting Minutes](https://github.com/camaraproject/PopulationDensityData/blob/main/documentation/MeetingMinutes/PopulationDensityDataAPI-KOmeeting_2024-01-24.md)

### Readme modifications (#2)

Including the description of the group, link to minutes and schedule of the following meetings (also meeting link)

### Confluence - to be agreed

CAMARA is moving  the documentation (meeting minutes mainly) to the [wiki.camaraproject.org](https://wiki.camaraproject.org/) Confluence webpage. Proposal to be agreed on moving meeting minutes for following meetings in that format from now on.

Agreement: To be used from next meeting, minutes and agenda will be placed there.

### New Maintainer (#3)

Verizon proposed as new maintainer of the API subgroup.

### API proposal review (#5)

Different discussions raised during the API review:
* **Information in water zones**: Operators and therefore API can only provide data of those zones where it is operating. Water zones are not considered and current implementation will provive an error in case the requested zone includes a water zone. Dimetor proposes to only provide "nonData" or null response for those specific cells, but not a complete error, concious of the multiple cases where flights will indeed consider wateer zones due to the expected low population density.

* Open discussion on **default and limit values** for the API characteristics: 
	* **Minimum and maximum date** minimum and maximum date allowed as requested time range. Currently, 15 minutes is set as the minimum (soonest time target the request can consider), and 1 year for maximum (longer date with information to extrapolate). TBD

	* **Time interval** in the request: Maximum (and minimum) lenght of the time range requested in the API. TBD

	* **Time granularity** in the response: Lenght of the information pieces in which the time interval is subdivided in the response. Default value is proposed in 1hour, so the response will include density information of each 1hour range that can be included in the requested interval. E.g. If request interval is 15minutes to 1 hour, 1 only result will be provided, if 3 hours and 45 minutes are requested, 4 results will be provided (from 0-1, 1-2, 2-3, 3-3:45). TBD
	* **Cell size/granularity** in the response: Currently both cell definition systems allow to implement different size of cells.  TBD

* Cell's format in the response: Currently, API support two different formats of defining the cells in which the requested area is divided for providing the information in the response:
	* **Boundary Cells**: The cell is defined by a polygon, composed by the internal area bounded by 4 geo positions. *Same solution as in Location Retrieval API

	* **Geohash Cells**: The Coordinates of the cell are representad as a string using the [Geohash system](https://en.wikipedia.org/wiki/Geohash). The value length, and thus the cell granularity, is determined by the implementation.

	Discussion on which mechanisms to restrict, or how to allow developers to select one of them if multiple are supported.\

	*(Note that optionality in  one side implies obligatory for the other, in this case forcing developers to support both options)*

## Discussion

Item | Discussion
---- | ---- 
[PR#1](https://github.com/camaraproject/PopulationDensityData/pull/1) | Approval of previous meetinge minutes &rarr; Approved
[PR#2](https://github.com/camaraproject/PopulationDensityData/pull/2) | Confirmation of subgroup readme information &rarr; Noted
[PR#3](https://github.com/camaraproject/PopulationDensityData/pull/3) | Confirm Verizon as new maintainer &rarr; Noted
[Issue#4](https://github.com/camaraproject/PopulationDensityData/issues/4) | Close scope of the innitial API &rarr; Approved
[PR#5](https://github.com/camaraproject/PopulationDensityData/pull/5) | Review proposal of innitial API code &rarr; [Issue#6](https://github.com/camaraproject/PopulationDensityData/issues/6) [Issue#7](https://github.com/camaraproject/PopulationDensityData/issues/7) [Issue#8](https://github.com/camaraproject/PopulationDensityData/issues/8)  Oppened for offline  Oppened for offline discussion.
AoB | -

## Next steps
1. Review and close open points PDD &rarr; Follow-up meeting #2
2. Propose innitial draft of algorithm &rarr; Follow-up meeting #2
3. Draft API spec agreement &rarr; Follow-up meeting #3


- Next call will be **February 21th, 2024**

<p>