Feature: CAMARA Population Density Data API, v0.3.0
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Geohash precisions allowed
  # * Min start and end date-times allowed
  # * Max requested time period allowed
  # * Max size of the response(Combination of area, startTime, endTime and precision requested) supported for a sync response
  # * Max size of the response(Combination of area, startTime, endTime and precision requested) supported for an async response
  # * Limitations about max complexity of requested area allowed
  #
  # Testing assets:
  # * An Area within the supported region
  # * An Area partially within the supported region
  # * An Area outside the supported region

  Background: Common retrievePopulationDensity setup
    Given an environment at "apiRoot"
    And the resource "/population-density-data/v0.3/retrieve"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # Happy path scenarios

  @population_density_data_01_supported_area_success_scenario
  Scenario: Validate success response for a supported area request
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.timedPopulationDensityData[*].startTime" is equal to or later than request body property "$.startTime"
    And the response property "$.timedPopulationDensityData[*].endTime" is equal to or earlier than request body property "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].geohash" is a valid Geohash inside the request area
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" is equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_02_partial_area_success_scenario
  Scenario: Validate success response for a partial supported area request
    Given the request body property "$.area" is set to a valid testing area partially within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "PART_OF_AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData[*].startTime" is equal to or later than request body property "$.startTime"
    And the response property "$.timedPopulationDensityData[*].endTime" is equal to or earlier than request body property "$.endTime"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "NO_DATA"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_03_not_supported_area_success_scenario
  Scenario: Validate success response for unsupported area request
    Given the request body property "$.area" is set to a valid testing area outside supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData" is an empty array

  @population_density_data_04_async_success_scenario
  Scenario: Validate success async response for a request when sink is provided
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    And the request body property "$.sink" is set to a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "ACCESSTOKEN"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response includes property "$.operationId"
    And the request with the response body will be received at the address of the request property "$.sink"
    And the request will have header "Authorization" set to "Bearer " + the value of the request property "$.sinkCredential.accessToken"
    And the request will have property "$.operationId" equal to response property "$.operationId"
    And the request body complies with the OAS schema at "/components/schemas/PopulationDensityAsyncResponse"

  @population_density_data_05_async_operation_not_completed_scenario
  Scenario: Validate async callback when operation fails
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    And the request body property "$.sink" is set to a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "ACCESSTOKEN"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response includes property "$.operationId"
    And there have been some problem processing the request asynchronously
    And the request with the response body will be received at the address of the request property "$.sink"
    And the request will have header "Authorization" set to "Bearer " + the value of the request property "$.sinkCredential.accessToken"
    And the request will have property "$.operationId" equal to response property "$.operationId"
    And the request body complies with the OAS schema at "/components/schemas/PopulationDensityAsyncResponse"
    And the request body will have property "$.status" equal to "OPERATION_NOT_COMPLETED" and includes property "$.statusInfo"

  @population_density_data_06_custom_precision_success_scenario
  Scenario: Validate success response for a request specifying the precision of the geohashes
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    And the request body property "$.precision" is set to a valid precision for the geohash response cells
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"

  @population_density_data_07_supported_area_past_success_scenario
  Scenario: Validate success response for a supported area in a past time period request
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid past date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.timedPopulationDensityData[*].startTime" is equal to or later than request body property "$.startTime"
    And the response property "$.timedPopulationDensityData[*].endTime" is equal to or earlier than request body property "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].geohash" is a valid Geohash inside the request area
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" is equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" == "DENSITY_ESTIMATION" have property "maxPplDensity"

  # Error scenarios

  # Error 400 scenarios

  @population_density_data_400.01_missing_required_property
  Scenario Outline: Error response for missing required property in request body
    Given the request body property "<required_property>" is not included
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | required_property |
      | $.area            |
      | $.startTime       |
      | $.endTime         |

  @population_density_data_400.02_invalid_date_format
  Scenario Outline: Error 400 when the datetime format is not RFC-3339
    Given the request body property "<date_property>" is not set to a valid RFC-3339 date-time
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | date_property |
      | $.startTime   |
      | $.endTime     |

  @population_density_data_400.03_invalid_precision
  Scenario: Error 400 when precision is not a number between 1 and 12
    Given the request body property "$.precision" is not set to a number between 1 and 12
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # PLAIN and REFRESHTOKEN are considered in the schema so INVALID_ARGUMENT is not expected
  @population_density_data_400.04_invalid_sink_credential
  Scenario: Invalid credential
    Given the request body property "$.sinkCredential.credentialType" is not set to "ACCESSTOKEN"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

  # Only "bearer" is considered in the schema so a generic schema validator may fail and generate a 400 INVALID_ARGUMENT without further distinction,
  # and both could be accepted
  @population_density_data_400.05_sink_credential_invalid_token
  Scenario: Invalid token
    Given the request body property "$.sinkCredential.accessTokenType" is set to a value other than "bearer"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.06_invalid_url
  Scenario: Invalid sink
    Given the request body property "$.sink" is not set to an url
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_SINK"
    And the response property "$.message" contains a user friendly text

  # An area that does not form a polygon is a straight line or a set of points with same coordinates.
  @population_density_data_400.07_non_polygonal_area
  Scenario: Error 400 when the requested area is not a polygon
    Given the request body property "$.area.boundary" is set to an array of coordinates that does not form a polygon
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.INVALID_AREA"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.08_too_complex_area
  Scenario: Error 400 when the requested area is too complex
    Given the request body property "$.area.boundary" is set to an array of coordinates that form a too complex area
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.INVALID_AREA"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.09_min_start_time_exceeded
  Scenario: Error 400 when startTime is set to a date-time earlier than the minimum allowed
    Given the request body property "$.startTime" is set to a date-time earlier than the minimum allowed
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.MIN_STARTTIME_EXCEEDED"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.10_max_start_time_exceeded
  Scenario: Error 400 when startTime is set to a date-time later than the maximum allowed
    Given the request body property "$.startTime" is set to a date-time later than the maximum allowed
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.MAX_STARTTIME_EXCEEDED"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.11_invalid_end_time
  Scenario: Error 400 when endTime is set to a date-time earlier than startTime
    Given the request body property "$.endTime" is set to a date-time earlier than request body property "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.INVALID_END_TIME"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.12_max_time_period_exceeded
  Scenario: Error 400 when indicated date-time period is greater than the maximum allowed
    Given the request body property "$.startTime" is set to a valid testing future date-time
    And the request body property "$.endTime" is set to a future date-time that exceeds the supported duration from the start time.
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.MAX_TIME_PERIOD_EXCEEDED"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.13_timeframe_crosses_request_time
  Scenario: Error 400 when startTime is set to a date-time in the past and the endTime is set to a date-time in the future
    Given the request body property "$.startTime" is set to a date-time in the past
    And the request body property "$.endTime" is set to a date-time in the future
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "POPULATION_DENSITY_DATA.INVALID_TIME_PERIOD"
    And the response property "$.message" contains a user friendly text

  # Error 401 scenarios

  @population_density_data_401.01_expired_access_token
  Scenario: Error response for expired access token
    Given an expired access token
    And the request body is set to a valid request body
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @population_density_data_401.02_invalid_access_token
  Scenario: Error response for invalid access token
    Given an invalid access token
    And the request body is set to a valid request body
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @population_density_data_401.03_missing_authorization_header
  Scenario: Error response for no header "Authorization"
    Given the header "Authorization" is not sent
    And the request body is set to a valid request body
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Error 403 scenarios

  @population_density_data_403.01_invalid_token_permissions
  Scenario: Error response for invalid access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the header "Authorization" is set to an access token without the required scope
    And the request body is set to a valid request body
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Error 422 scenarios

  @population_density_data_422.01_unsupported_precision
  Scenario: Error 422 when precision is set to a valid but not supported value
    Given the request body property "$.precision" is set to a valid but not supported value
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "POPULATION_DENSITY_DATA.UNSUPPORTED_PRECISION"
    And the response property "$.message" contains a user friendly text

  @population_density_data_422.02_too_big_synchronous_response
  #To test this scenario provided values for "$.area.boundary", "$.startTime", "$.endTime" and "$.precision" MUST generate a response too big for a synchronous response
  Scenario: Error 422 when the response is too big for a sync response
    Given the request body properties "$.area.boundary", "$.startTime", "$.endTime" and "$.precision" are set to valid values
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "POPULATION_DENSITY_DATA.UNSUPPORTED_SYNC_RESPONSE"
    And the response property "$.message" contains a user friendly text

  @population_density_data_422.03_too_big_request
  #To test this scenario provided values for "$.area.boundary", "$.startTime", "$.endTime" and "$.precision" MUST generate a too big response in both sync and async scenarios
  Scenario: Error 422 when the response is too big for a sync and async response
    Given the request body properties "$.area.boundary", "$.startTime", "$.endTime" and "$.precision" are set to valid values
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "POPULATION_DENSITY_DATA.UNSUPPORTED_REQUEST"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @population_density_data_429.01_too_Many_Requests
  #To test this scenario environment has to be configured to reject requests reaching the limit settled. N is a value defined by the Telco Operator
  Scenario: Request is rejected due to threshold policy
    Given that the environment is configured with a threshold policy of N transactions per second
    And the request body is set to a valid request body
    And the header "Authorization" is set to a valid access token
    And the threshold of requests has been reached
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 429
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text
