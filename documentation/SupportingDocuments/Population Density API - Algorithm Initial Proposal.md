# Population Density Data API
## Algorithm initial proposal
### Inputs for the algorithm:
* UEs connection records data is received pseudonymized or hashed.
* Requested Space is received in the API customers’ request.
### Process is as follows:
<ol>
<li><strong>Cleanup</strong>: Repeated records will be deleted and traffic events associated with M2M lines are filtered due to they do not contribute to the process of estimating future population density.<br>
<strong>Output 1 </strong>&rarr; Cleaned list of UEs connection records</li><br>
<li><strong>Attribution:</strong> A cell is associated with each user in each time interval.
<ol><li>For mobile lines with persistent records, the last cell in which each user has been connected in each interval (considering intervals of 15 minutes) will be associated.</li>
<li>It is common to have intervals for which a user does not show activity, for
them it will be assumed that the user remains in the same cell in which he was last seen active.</li></ol>
<strong>Output 2</strong> &rarr; Valid UEs per cell in each time interval</li><br><br>
<li><strong>Counting and Aggregation:</strong> A count of users is performed per cell and interval.
On this count, a statistical analysis is performed with the elimination of outliers.
Records associated with cells with less than K users in each time interval (k –
anonymity) are discarded.<br>
<strong>Output 3</strong> &rarr;  Total number of UEs connected per cell in each time interval,
considering privacy.</li><br>
<li><strong>Spatial indexing (no personal data is processed):</strong> the space will be divided into units (grids), and associating the grids that overlap with its coverage area to each cell.<br>
<strong>Output 4</strong> &rarr; Regular grid covering the required area, over the cells coverage
areas.</li><br>
<li><strong>Distribution and aggregation:</strong> Taking into account the coverage area of the cell, users are going to be distributed, homogeneously among the grids (currently 150m x 150m or larger) associated with the cell, and the process is repeated for all cells. As we are assuming that the distribution of users in the coverage area
of each cell is uniform, we are introducing an error/noise in the distribution of users by time interval, which will be transferred to population density predictions that contribute to reducing the risk of user reidentification. Each grid on the map can typically be served by several cells of different technologies and frequency bands. To obtain the number of users per grid and time interval, an aggregation is performed.<br>
<strong>Output 5</strong> &rarr; Number of UEs per grid, based on distribution in the cells covering that area</li><br>
<li><strong>Prediction:</strong> Based on the historical information of users by grid and interval, the prediction of users by grid and interval is made for each time interval of the future. For example, the population density forecast for next Tuesday should be similar to the one observed last Tuesday. As the data becomes available, improvements
to this process will be proposed to consider seasonality, holidays/working days and also to be able to make revisions for short-term predictions. For example, on a typical Tuesday we observe a population density of X, but today Tuesday at 10 o'clock we are already 25% above that level, so it is foreseeable that at 11 or 12 o'clock we will also continue above that level.<br>
<strong>Output 6</strong> &rarr; Users per grid, considering historical and calendar data</li><br>
<li><strong>Extrapolation:</strong> Finally, the users of the MNO mobile network are extrapolated
taking into account the market shares by geographical area to obtain the total number of people (users or not of the mobile network with any operator).<br> 
<strong>Output 7</strong> &rarr; Total population per grid, considering extrapolation towards MNO market share From step 2 onwards, this is aggregated data that does not contain personal information (this is anonymous data).
</ol>
