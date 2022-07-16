Feature: Verify Users

  Background: Get url and specify user test data
    * url baseUrl
    * def pageNumber = '2'
    * def userId = '11'
    * def email = "george.edwards@reqres.in"
    * def firstName = "George"
    * def lastName = "Edwards"

  Scenario: Get all users and then extract a user with the specific id
    * string schema = read('../schemas/users-schema.json')
    * def SchemaUtils = Java.type('utils.SchemaUtils')
    Given path 'users'
    And param page = pageNumber
    When method get
    Then status 200
    * assert SchemaUtils.isValid(response, schema)
    * def fn = function(x){ return x.id == userId }
    * def user = karate.filter(response.data, fn)[0]
    Then match user.email == email
    Then match user.first_name == firstName
    Then match user.last_name == lastName

  Scenario: Get Single User
    Given path 'users', userId
    When method get
    Then status 200
    Then match response.data.email == email
    Then match response.data.first_name == firstName
    Then match response.data.last_name == lastName

  Scenario: Create a new User
    * def name = 'Peter'
    * def job = 'Sales'
    Given path 'users'
    And request
      """
      {
        "name": "#(name)",
        "job": "#(job)"
      }
      """
    When method POST
    Then status 201
    Then match response.name == name
    Then match response.job == job

  Scenario: Create a new User (Negative)
    * def email = 'sydney@fife'
    * def errorMessage = 'Missing password'
    Given path 'register'
    And request
      """
      {
        "email": "#(email)"
      }
      """
    When method POST
    Then status 400
    Then match response.error == errorMessage