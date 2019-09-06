@ignore
Feature: Sample on how to use Authorizations
# -----------------------------------------------
# Wiremocks are being used to mock the APIs used
# -----------------------------------------------
  Background:
  * url 'http://localhost:8247'

  Scenario: Basic Authorization
    Given path '/Postemployeedata'
    And header Authorization = call read('basic-auth.js') { username: 'Lakshani', password: 'Password@123' }
    And header department = '"valid_department"'
    And request read ('requestBody.json')
    When method post
    Then status 200
    And match response == {"message": "Post Success"}

  Scenario: Oauth2 Authorization
    Given path 'tokengen'
    And param client_id = 'clientID123'
    And param client_secret = 'clientSecret123'
    And request ''
    When method post
    Then status 200
    * def accessToken = response.access_token
    * print accessToken
