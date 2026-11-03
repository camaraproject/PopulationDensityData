# Population Density Data API
## Algorithm initial proposal

This document serves as a reference model for the population density calculation algorithm. It provides an illustrative high-level overview of the steps proposed to determine population density. Designed for developers, this guide is created to enhance understanding of, and express expectations on, the implementation of the algorithm. However, it is the responsibility of the developer to create their own algorithm to calculate population density as close as possible to these expectations.

### Terminology
* **Radio cell**: a cell of the mobile network, served by a base station, in a given technology and frequency band.
* **Grid cell**: a cell of the regular geographical grid (geohash cells at the requested precision) into which the requested area is subdivided. A grid cell is a geographical area and is independent of the mobile network: no relation between grid cells and radio cells is assumed.
* **Collection interval**: the 15-minute interval at which device connection records are collected and attributed to a radio cell (step 2).
* **Request interval**: the time frame between `startTime` and `endTime` in the API request, split into full-hour slots. The prediction (step 6) is produced for each of these slots.

### Inputs for the algorithm:
* Device connection records, received pseudonymized or hashed. They are collected per collection interval (every 15 minutes).
* The requested area, received in the API request (`area`).
* The request interval (`startTime` / `endTime`), received in the API request.
* The precision (`precision`), received in the API request. It determines the size of the grid cells for polygon areas; for geohash lists, the length of each geohash determines its own grid cell size.

### Process is as follows:
<ol>
<li><strong>Cleanup</strong>: Considering one year of historical information, repeated records are deleted and records of IoT lines (non-personal devices) are filtered, as they do not contribute to the process of estimating future population density.<br>
<strong>Output 1 </strong>&rarr; Cleaned list of device connection records</li><br>
<li><strong>Attribution:</strong> A radio cell is associated with each user in each collection interval.
<ol><li>For mobile phones with persistent records, the last radio cell to which each user has been connected in each collection interval (intervals of 15 minutes) is associated.</li>
<li>It is common to have collection intervals for which a user does not show activity. For them it is assumed that the user remains in the same radio cell in which they were last seen active.</li></ol>
<strong>Output 2</strong> &rarr; Valid users per radio cell in each collection interval</li><br>
<li><strong>Counting and Aggregation:</strong> A count of users is performed per radio cell and collection interval. On this count, a statistical analysis is performed with the elimination of outliers. Records associated with radio cells with fewer than K users in a collection interval (k-anonymity) are discarded (K to be evaluated according to local regulations).<br>
<strong>Output 3</strong> &rarr; Total number of users connected per radio cell in each collection interval, considering privacy.</li><br>
<li><strong>Mapping radio cell coverage to geographical area (no personal data is processed):</strong> the requested area is expected to be mapped into grid cells, at the precision given in the API request, and each grid cell is associated with the radio cells whose coverage overlaps it.<br>
<strong>Output 4</strong> &rarr; Regular grid of grid cells covering the requested area, each associated with the radio cells that cover it.</li><br>
<li><strong>Distribution and aggregation:</strong> The users of each radio cell are expected to be distributed homogeneously among the grid cells associated with that radio cell, taking into account the size of the grid cells, and the process is repeated for all radio cells. Assuming a uniform distribution of users within each radio cell introduces an error/noise in the distribution of users by collection interval. This error is carried over to the population density predictions and contributes to reducing the risk of user reidentification. A grid cell can typically be served by several radio cells of different technologies and frequency bands. To obtain the number of users per grid cell and collection interval, the contributions of all radio cells serving the grid cell are aggregated.<br>
<strong>Output 5</strong> &rarr; Number of users per grid cell, based on the distribution of the radio cells covering that area.</li><br>
<li><strong>Prediction:</strong> Based on the historical information of users per grid cell and interval, the prediction of users per grid cell is made for each full-hour slot of the request interval. The algorithm identifies the day of the week and time frame for which the prediction is requested. Then, it reads the records associated with the same weekday and time frame for the previous 4 weeks.
The population density forecast for next Tuesday should be similar to the one observed in the last four Tuesdays. The forecast, then, is the average of the records of the previous 4 Tuesdays at the same time frame.<br>
<strong>Output 6</strong> &rarr; Users per grid cell, considering historical and calendar data</li><br>
<li><strong>Extrapolation:</strong> Finally, the users of the operator's mobile network are extrapolated, taking into account the operator's market share, to obtain the total number of people (users or not of the mobile network of any operator).<br>
<strong>Output 7</strong> &rarr; Total population per grid cell, considering extrapolation by the operator's market share. From step 3 onwards, this is aggregated data that does not contain personal information (this is anonymous data).
</ol>
