Feature: Ejercicios Clase 4

  Scenario: Caso 1
    * def id = 100
    Given url 'https://jsonplaceholder.typicode.com'
    And path '/posts/' + id
    When method get
    Then status 200
    And match responseType == 'json'
    And match $.id == id

  Scenario: Caso 2
    Given url 'https://reqres.in'
    And path '/api/users'
    And param page = 2
    When method get
    Then status 200
    And match responseType == 'json'
    And match response.data[2].id == 9
    And match response.data[2].first_name == 'Tobias'

  Scenario: Caso 3 - Crear un usuario
    Given url 'https://reqres.in'
    And path '/api/users'
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then status 201
    And match response.name == 'morpheus'
    And match response.job == 'leader'

  Scenario: Caso 4 - Crear un usuario con docString en variable
    * def body =
    """
      {
        "name": "morpheus",
        "job": "leader"
      }
    """
    Given url 'https://reqres.in'
    And path '/api/users'
    And request body
    When method post
    Then status 201
    And match response.name == 'morpheus'
    And match response.job == 'leader'

  Scenario: Caso 5 - Crear un usuario con archivo JSON
    Given url 'https://reqres.in'
    And path '/api/users'
    And request read("bodyUser.json")
    When method post
    Then status 201
    And match response.name == 'morpheus'
    And match response.job == 'leader'

  Scenario: Caso 6 - Login
    Given url 'https://reqres.in'
    And path '/api/login'
    And form field email = 'eve.holt@reqres.in'
    And form field password = 'cityslicka'
    When method post
    Then status 200
    And match response.token == "#notnull"

  Scenario: Caso 7 - Actualizar usuario
    * def id = 2
    Given url 'https://reqres.in'
    And path '/api/users/' + id
    And request read("bodyUser.json")
    When method put
    Then status 200
    * print response
    And match response.name == "Francisco"
    And match response.job == "QA Funcional"
    And match response.updatedAt == "#notnull"