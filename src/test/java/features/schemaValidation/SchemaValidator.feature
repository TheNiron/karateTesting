Feature: Schema Validator

  Scenario: using a third-party lib and a schema file
    * string schema = read('products-schema.json')
    * string json = read('products.json')
    * def SchemaUtils = Java.type('util.SchemaUtils')
    * assert SchemaUtils.isValid(json, schema)