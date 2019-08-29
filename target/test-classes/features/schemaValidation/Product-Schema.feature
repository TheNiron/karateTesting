Feature: json schema validation

  Scenario: A scenario using karate's simpler alternative to json-schema
    * def warehouseLocation = { latitude: '#number', longitude: '#number' }
    * def productStructure =
    """
    {
      id: '#number',
      name: '#string',
      price: '#number? _ > 0',
      tags: '##[_ > 0] #string',
      dimensions: {
        length: '#number',
        width: '#number',
        height: '#number'
      },
      warehouseLocation: '##(warehouseLocation)'
    }
    """

    * def json = read('sample1.json')
    * match json == '#[] productStructure'


  Scenario: Another scenario using karate's simpler alternative to json-schema



    * def oddSchema = { price: '#string', status: '#? _ < 3', ck: '##number', name: '#regex[0-9X]' }
    * def isValidTime = read('time-validator.js')
    * def productStructure =
"""
{
  id: '#regex[0-9]+',
  count: '#number',
  odd: '#(oddSchema)',
  data: {
    countryId: '#number',
    countryName: '#string',
    leagueName: '##string',
    status: '#number? _ >= 0',
    sportName: '#string',
    time: '#? isValidTime(_)'
  },
  odds: '#[] oddSchema'
}
"""
    * def response = read('sample2.json')
    Then match response == productStructure