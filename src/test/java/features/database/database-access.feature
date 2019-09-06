Feature: Database testing

  Background:
    # Create JDBC connection with DbUtils java class
    * def config = { username: 'root', password: 'root', url: 'jdbc:mysql://localhost:3306/sample_db', driverClassName: 'com.mysql.jdbc.Driver' }
    * def DbUtils = Java.type('util.DbUtils')
    * def db = new DbUtils(config)

    # insert test data into database
    * def query = read('insert_query.txt')
    * db.insertRows(query)

    * configure afterFeature = function(){ karate.call('after-feature.feature'); }

    * configure afterScenario = function(){ karate.call('after-feature.feature'); }

  Scenario: Validate Database assertion

   # since the DbUtils returns a Java Map, it becomes a JSON, which means that you can use Karate's 'match' syntax
    * def vehicles = db.readRows('SELECT * FROM vehicles')

    * match vehicles contains {vehicle_id:1, availability:'true', type:#ignore }

    * def vehicle = db.readRow('SELECT * FROM vehicles D WHERE D.vehicle_id = 2;')

    * match vehicle.availability == 'false'

