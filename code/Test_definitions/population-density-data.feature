Feature: CAMARA Population Density Data API, vwip
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * Geohash precisions allowed
  # * Min start and end date-times allowed
  # * Max requested time period allowed
  # * Max size of the response(Combination of area, startTime, endTime and precision requested) supported for a sync response
  # * Max size of the response(Combination of area, startTime, endTime and precision requested) supported for an async response
  # * Limitations about max complexity of requested area allowed
  # * Whether the GEOHASHLIST area type is supported
  # * Whether `PRIVATE_KEY_JWT` is accepted as `sinkCredential.credentialType`
  #
  # Testing assets:
  # * An Area within the supported region
  # * An Area partially within the supported region
  # * An Area outside the supported region
  # * An API consumer with a JWK Set pre-configured for `PRIVATE_KEY_JWT` authentication
  # * An API consumer with no JWK Set configured for `PRIVATE_KEY_JWT` authentication
  #
  # References to OAS spec schemas refer to schemas specified in population-density-data.yaml

  Background: Common retrievePopulationDensity setup
    Given an environment at "apiRoot"
    And the resource "/population-density-data/vwip/retrieve"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "../common/CAMARA_common.yaml#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

  # Happy path scenarios

  @population_density_data_01_polygon_supported_area_success_scenario
  Scenario: Validate success response for a supported area request
    Given the request body property "$.area" is set to a valid testing POLYGON area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.timedPopulationDensityData" intervals fully cover the requested time range from "$.startTime" to "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].geohash" is a valid Geohash inside the request area
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" is equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_02_polygon_partial_area_success_scenario
  Scenario: Validate success response for a partial supported area request
    Given the request body property "$.area" is set to a valid testing POLYGON area partially within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "PART_OF_AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData" intervals fully cover the requested time range from "$.startTime" to "$.endTime"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "NO_DATA"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_03_polygon_not_supported_area_success_scenario
  Scenario: Validate success response for unsupported area request
    Given the request body property "$.area" is set to a valid testing POLYGON area outside supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData" is an empty array

  @population_density_data_04_geohashlist_supported_area_success_scenario
  Scenario: Validate success response for a supported area request defined as a list of geohashes
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" is set to a list of valid geohashes within supported regions, including geohashes of different precisions
    And the request body property "$.precision" is not included
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.timedPopulationDensityData" intervals fully cover the requested time range from "$.startTime" to "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" contains one cell per geohash in the request property "$.area.geohashes"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].geohash" is a valid Geohash present in the request property "$.area.geohashes"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" is equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_05_geohashlist_partial_area_success_scenario
  Scenario: Validate success response for a list of geohashes partially within supported regions
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" is set to a list of valid geohashes partially within supported regions
    And the request body property "$.precision" is not included
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "PART_OF_AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData" intervals fully cover the requested time range from "$.startTime" to "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" contains one cell per geohash in the request property "$.area.geohashes"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "NO_DATA"
    And there is at least one item in response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "maxPplDensity"

  @population_density_data_06_geohashlist_not_supported_area_success_scenario
  Scenario: Validate success response for a list of geohashes entirely outside supported regions
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" is set to a list of valid geohashes outside supported regions
    And the request body property "$.precision" is not included
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "AREA_NOT_SUPPORTED"
    And the response property "$.timedPopulationDensityData" is an empty array

  @population_density_data_07_async_success_scenario
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
    And the request with the response body will be received at the address of the request property "$.sink" with property "$.operationId" equal to response property "$.operationId"
    And the request will have header "Authorization" set to "Bearer " + the value of the request property "$.sinkCredential.accessToken"
    And the request body complies with the OAS schema at "/components/schemas/PopulationDensityAsyncResponse"

  @population_density_data_08_async_operation_not_completed_scenario
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
    And there has been a problem processing the request asynchronously
    And the request with the response body will be received at the address of the request property "$.sink" with property "$.operationId" equal to response property "$.operationId"
    And the request will have header "Authorization" set to "Bearer " + the value of the request property "$.sinkCredential.accessToken"
    And the request body complies with the OAS schema at "/components/schemas/PopulationDensityAsyncResponse"
    And the request body will have property "$.status" equal to "OPERATION_NOT_COMPLETED" and includes property "$.statusInfo"

  @population_density_data_09_custom_precision_success_scenario
  Scenario: Validate success response for a request specifying the precision of the geohashes
    Given the request body property "$.area" is set to a valid testing POLYGON area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    And the request body property "$.precision" is set to a valid precision for the geohash response cells
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"

  @population_density_data_10_supported_area_past_success_scenario
  Scenario: Validate success response for a supported area in a past time period request
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid past date-times, with "$.endTime" later than "$.startTime"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/PopulationDensityResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.timedPopulationDensityData" intervals fully cover the requested time range from "$.startTime" to "$.endTime"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].geohash" is a valid Geohash inside the request area
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*].dataType" is equal to "LOW_DENSITY" or "DENSITY_ESTIMATION"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "minPplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "pplDensity"
    And the response property "$.timedPopulationDensityData[*].cellPopulationDensityData[*]" items with property "dataType" equal to "DENSITY_ESTIMATION" have property "maxPplDensity"

  # The JWT authentication parameters have to be pre-configured out-of-band between the API consumer and the
  # API provider, as no response of this API returns "$.sinkCredential" and therefore the provider's "jwksUri"
  # is never conveyed in-band
  @population_density_data_11_async_private_key_jwt_success_scenario
  Scenario: Validate success async response for a request when sinkCredential uses PRIVATE_KEY_JWT
    # Property "$.sink" is set with a valid public accessible HTTPs endpoint
    Given the API provider has a JWK Set pre-configured for the API consumer used in the test
    And the request body property "$.area" is set to a valid testing area within supported regions
    And the request body properties "$.startTime" and "$.endTime" are valid future date-times, with "$.endTime" later than "$.startTime"
    And the request body property "$.sink" is set to a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "PRIVATE_KEY_JWT"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response includes property "$.operationId"
    And the response does not include property "$.sinkCredential"
    And the request with the response body will be received at the address of the request property "$.sink" with property "$.operationId" equal to response property "$.operationId"
    And the request will have header "Authorization" set to "Bearer " + an access token requested to the request property "$.sinkCredential.tokenUri" with the request property "$.sinkCredential.clientId"
    And the request body complies with the OAS schema at "/components/schemas/PopulationDensityAsyncResponse"

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
      | $.area.areaType   |
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
    Given the request body property "$.area.areaType" is set to "POLYGON"
    And the request body property "$.precision" is not set to a number between 1 and 12
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Only "ACCESSTOKEN" and "PRIVATE_KEY_JWT" are considered in the SinkCredential schema, so a value outside that set
  # may be rejected by the business logic as INVALID_CREDENTIAL or by a generic schema validator as INVALID_ARGUMENT,
  # and both could be accepted
  @population_density_data_400.04_invalid_sink_credential
  Scenario Outline: Invalid credential
    Given the request body property "$.sinkCredential.credentialType" is set to "<unsupported_credential_type>"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | unsupported_credential_type |
      | PLAIN                       |
      | REFRESHTOKEN                |

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
    Given the request body property "$.sink" is not set to a URL
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

  @population_density_data_400.14_precision_with_geohashlist
  Scenario: Error 400 when precision is included together with a GEOHASHLIST area
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" is set to a list of valid geohashes within supported regions
    And the request body property "$.precision" is included
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.15_invalid_geohash_format
  Scenario: Error 400 when a geohash in the list does not comply with the Geohash format
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" contains a value that does not comply with the schema at "/components/schemas/Geohash"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.16_unexpected_property
  Scenario: Error 400 when the request body contains a property not defined in the schema
    Given the request body contains a property not defined in the schema
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.17_schema_not_compliant
  Scenario: Error 400 when the request body does not comply with the schema
    Given the request body is not compliant with the OAS schema at "/components/schemas/PopulationDensityRequest"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.18_no_request_body
  Scenario: Error 400 when the request body is not provided
    Given the request body is not included
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.19_empty_request_body
  Scenario: Error 400 when the request body is an empty object
    Given the request body is set to "{}"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @population_density_data_400.20_empty_area_property
  Scenario: Error 400 when the area property is an empty object
    Given the request body property "$.area" is set to an empty object
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # The x-correlator sent in the request is invalid, so the response is not expected to echo it back
  @population_density_data_400.21_invalid_x_correlator
  Scenario: Error 400 when the x-correlator header does not comply with the schema
    Given the request header "x-correlator" is not compliant with the schema at "../common/CAMARA_common.yaml#/components/schemas/XCorrelator"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
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
    Given the request body property "$.area.areaType" is set to "POLYGON"
    And the request body property "$.precision" is set to a valid but not supported value
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

  @population_density_data_422.04_unsupported_area_type
  #To test this scenario the MNO must not support the GEOHASHLIST area type
  Scenario: Error 422 when the requested areaType is not supported by the MNO
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" is set to a list of valid geohashes within supported regions
    And the request body property "$.precision" is not included
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "POPULATION_DENSITY_DATA.UNSUPPORTED_AREA_TYPE"
    And the response property "$.message" contains a user friendly text

  @population_density_data_422.05_unsupported_geohash_precision
  #To test this scenario at least one geohash must use a precision (length) not supported by the MNO
  Scenario: Error 422 when a geohash in the list uses a precision not supported by the MNO
    Given the request body property "$.area.areaType" is set to "GEOHASHLIST"
    And the request body property "$.area.geohashes" contains a valid geohash whose precision (length) is not supported by the MNO
    And the request body property "$.precision" is not included
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "POPULATION_DENSITY_DATA.UNSUPPORTED_PRECISION"
    And the response property "$.message" contains a user friendly text

   @population_density_data_422.06_private_key_jwt_not_configured
  #To test this scenario the API consumer must not have a JWK Set pre-configured for PRIVATE_KEY_JWT authentication
  Scenario: Error 422 when PRIVATE_KEY_JWT is requested and no JWK Set is configured for the API consumer
    Given the API provider has no JWK Set configured for the API consumer used in the test
    And the request body property "$.sink" is set to a valid HTTPS URL
    And the request body property "$.sinkCredential" is set to a valid credential with property "$.sinkCredential.credentialType" set to "PRIVATE_KEY_JWT"
    When the request "retrievePopulationDensity" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 422
    And the response property "$.code" is "PRIVATE_KEY_JWT_NOT_CONFIGURED"
    And the response property "$.message" contains a user friendly text

  # Error 429 scenarios

  @population_density_data_429.01_too_many_requests
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
