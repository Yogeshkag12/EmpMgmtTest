Feature: sample karate test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'http://localhost:1337'

  @allusers
  Scenario: get all users and then get the first user by id
    Given path 'employees'
    And def mydata =  read("classpath:examples/reusable/user.json")
    And  def Mycode1 = Java.type('javacode.MyCode')
    And def myobj = new Mycode1()
    And def mygreet = myobj.getName("Bhole nath")
    And print mygreet
    When method get
    Then status 200
    And match response[0] contains {id:"#notnull", "name":"Yogesh"}
    And match response[0] contains {age:'#? _ > 30'}
    And match response[0] contains {salary:'#? _ == 100000', "name":"Yogesh"}


 
  @createuser
  Scenario Outline: This scenario is to create new user
    Given path 'employees'
    And request { name: <name>, age:<age>, salary:<salary>}
    And header Accept = 'application/json'
    When method post
    Then status 200
  
    Examples:
      | name  | age  | salary |
      | 'John'  | 10 | 20     |
      | 'Smith' | 20 | 30     |

  @demo
  Scenario: This is for exploration 
    * def keys = []
    * def vals = []
    * def idxs = []
    * def fun = 
    """
    function(x, y, i) { 
      karate.appendTo(keys, x); 
      karate.appendTo(vals, y); 
      karate.appendTo(idxs, i); 
      print(x,y,i)
     
      
    }
   
  @custom
Scenario: set via table, complex paths
    * set expected
    | path            | value   |
    | first           | 'hello' |
    | client.id       | 'goodbye'            |
    | client.foo.bar  | 'world' |
    
    * match expected == { first: 'hello', client: { id: 'goodbye', foo: { bar: 'world' }}}
