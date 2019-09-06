@ignore
Feature: Database cleaning

Scenario: clean the database
       #Create JDBC connection with DbUtils java class
  * def config = { username: 'root', password: 'root', url: 'jdbc:mysql://localhost:3306/sample_db', driverClassName: 'com.mysql.jdbc.Driver' }
  * def DbUtils = Java.type('util.DbUtils')
  * def db = new DbUtils(config)

  * db.cleanDatatable("TRUNCATE sample_db.vehicles;")