@ignore @mock
Feature: Rent-a-cycle API service mock
     This file is a mocked version of the API being called.
     Using Karate's Standalone JAR, you can start it as a standalone process with the following command:

  java -jar karate.jar -p 8089 -m products-mock.feature

  Background:
    * configure cors = true
    * def rentacycles =
    """
    [
      {id: 'A001', rent: false},
      {id: 'A002', rent: false},
      {id: 'A003', rent: false},
      {id: 'A004', rent: true},
      {id: 'A005', rent: true}
    ]
    """

# -----------------------------------------------
# Get a list of available vehicles
# GET:/rentacycles?available=true
# -----------------------------------------------
  Scenario: methodIs('get') && pathMatches('/rentacycles') && paramValue('available') == 'true'
    * def availables = karate.jsonPath(rentacycles, "$[?(@.rent==false)]")
    * def response = availables


# -----------------------------------------------
# Vehicle list acquisition
# GET:/rentacycles
# -----------------------------------------------
  Scenario: methodIs('get') && pathMatches('/rentacycles')
    * def response = rentacycles


# -----------------------------------------------
# Rental processing
# POST:/rentacycles/rent
# -----------------------------------------------
  Scenario: methodIs('post') && pathMatches('/rentacycles/rent')
    * def requestBody = request
    * def id = requestBody.id
    * def target = karate.jsonPath(rentacycles, "$[?(@.id=='" + id + "')]")[0]
    * print 'rental target : ', target
    * eval if (target == null) karate.abort()

     # If already rented, return 409 and exit
    * eval if (target.rent == true) karate.set('responseStatus', 409)
    * eval if (responseStatus == 409) karate.abort()

     # If you can rent, change the status and return 200
    * set target.rent = true
    * def response = {result : true}


# -----------------------------------------------
# Return processing
# POST:/rentacycles/return
# -----------------------------------------------
  Scenario: methodIs('post') && pathMatches('/rentacycles/return')
    * def requestBody = request
    * def id = requestBody.id
    * def target = karate.jsonPath(rentacycles, "$[?(@.id=='" + id + "')]")[0]
    * print 'rental target : ', target
    * eval if (target == null) karate.abort()

     # Change state and return 200
    * set target.rent = false
    * def response = {result : true}


# -----------------------------------------------
# API Does not match
# -----------------------------------------------
  Scenario:
    * def responseStatus = 404