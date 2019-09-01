Feature:  Karate test Double API tested with basic karate steps
# -----------------------------------------------
# KARATE Double is used to mock the expected API behavior and responses
# -----------------------------------------------
  Background:
    * url 'http://localhost:8089'

  Scenario: Get all rentacycles

    Given path '/rentacycles'
    When method get
    Then status 200
    And assert response.size() === 5

  Scenario: Rent / Return the cycle

    # Get a list of available vehicles
    Given path '/rentacycles'
    And param available = true
    When method get
    Then status 200
    * print response.size()
    And assert response.size() === 3
    And match response contains {id: 'A001', rent: false}
    And match response contains {id: 'A002', rent: false}
    And match response contains {id: 'A003', rent: false}
    * def expected =
        """
  [
  {id: 'A001', rent: false},
  {id: 'A002', rent: false},
  {id: 'A003', rent: false}
  ]
  """
    And match response contains expected

#    POST a Rental
    * def rentId = response[0].id
    * print rentId

    Given path '/rentacycles/rent'
    And request {id: #(rentId)}
    When method post
    Then status 200
    And match response ==
        """
        {
            result : true
        }
        """

    # Get a list of available vehicles
    Given path '/rentacycles'
    And param available = true
    When method get
    Then status 200
    And assert response.size() === 2
    And match response !contains {id: 'A001', rent: #boolean}

    # POST cal for Rented vehicle
    Given path '/rentacycles/rent'
    And request {id: #(rentId)}
    When method post
    Then status 409

    # Return processing
    Given path '/rentacycles/return'
    And request {id: #(rentId)}
    When method post
    Then status 200
    And match response ==
        """
        {
            result : true
        }
        """

    # Get a list of available vehicles
    Given path '/rentacycles'
    And param available = true
    When method get
    Then status 200
    And assert response.size() === 3