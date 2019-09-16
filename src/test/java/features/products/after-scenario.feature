@ignore
Feature: After feature

Scenario: Shutting down mock server
  * def mock = Java.type('features.products.mockServer')
  * def mockConfigs = mock.shutdown()

