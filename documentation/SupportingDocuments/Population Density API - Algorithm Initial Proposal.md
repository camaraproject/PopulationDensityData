# Population Density Data API
## Algorithm initial proposal

This document serves as a reference model for the population density calculation algorithm. It provides an illustrative high-level overview of the steps proposed to determine population density. Designed for developers, this guide is created to enhance understanding and implementation of the algorithm. While it aims to enhance understanding and implementation, it is the responsibility of the developer to create their own algorithm to calculate population density.

### Inputs for the algorithm:
* Devices connection records data is received pseudonymized or hashed.
* Requested Space is received in the API customers’ request.
### Process is as follows:
<ol>
<li><strong>Cleanup</strong>: Considering one year of historical information, repeated records will be deleted and IOT (non-personal devices) lines records are filtered due to they do not contribute to the process of estimating future population density.<br>
<strong>Output 1 </strong>&rarr; Cleaned list of Devices connection records</li><br>
<li><strong>Attribution:</strong> A cell is associated with each user in each time interval.
<ol><li>For mobile lines with persistent records, the last cell in which each user has been connected in each interval (considering intervals of 15 minutes) will be associated.</li>
<li>It is common to have intervals for which a user does not show activity, for
them it will be assumed that the user remains in the same cell in which he was last seen active.</li></ol>
<strong>Output 2</strong> &rarr; Valid Devices per cell in each time interval</li><br><br>
<li><strong>Counting and Aggregation:</strong> A count of users is performed per cell and interval.
On this count, a statistical analysis is performed with the elimination of outliers.
Records associated with cells with less than K users in each time interval (k –
anonymity) are discarded.<br>
<strong>Output 3</strong> &rarr;  Total number of UEs connected per cell in each time interval,
considering privacy.</li><br>
<li><strong>Spatial indexing (no personal data is processed):</strong> the space will be mapped into units (grids), to associate the grids that overlap with each cell coverage area.<br>
<strong>Output 4</strong> &rarr; Regular grid covering the required area, over the cells coverage
areas.</li><br>
<li><strong>Distribution and aggregation:</strong> Taking into account the coverage area of the cell, users are going to be distributed, homogeneously among the grids (currently 150m x 150m or larger) associated with the cell, and the process is repeated for all cells to estimate the number of devices based on equal users distribution. As we are assuming that the distribution of users in the coverage area of each cell is uniform, we are introducing an error/noise in the distribution of users by time interval, which will be transferred to population density predictions that contribute to reducing the risk of user reidentification. Each grid on the map can typically be served by several cells of different technologies and frequency bands. To obtain the number of users per grid and time interval, an aggregation is performed.<br>
<strong>Output 5</strong> &rarr; Number of Devices per grid, based on distribution in the cells covering that area</li><br>
<li><strong>Prediction:</strong> Based on the historical information of users by grid and interval, the prediction of users by grid and interval is made for each time interval of the future. The algorithm identifies a day of the week and time frame for which the prediction is requested. Then, it will read the records associated for the same weekday and time frame for the previous 4 weeks.
The population density forecast for next Tuesday should be similar to the one observed in the last four Tuesdays. The forecast, then, will be the average of the records of the previous 4 Tuesdays at the same time frame.<br>
<strong>Output 6</strong> &rarr; Users per grid, considering historical and calendar data</li><br>
<li><strong>Extrapolation:</strong> Finally, the users of the MNO mobile network are extrapolated
taking into account the market shares by geographical area (municipality) to obtain the total number of people (users or not of the mobile network with any operator).<br> 
<strong>Output 7</strong> &rarr; Total population per grid, considering extrapolation towards MNO market share From step 2 onwards, this is aggregated data that does not contain personal information (this is anonymous data).
</ol>
