
#This feature is to validate employee salary. Here we assume 30% tax on given paycheck.
@work
Feature: This feature to valdiate postive and negative scenarios of employee salary calculation
Background:
    * def url ="http://localhost:337"

Scenario Outline: Create Salary and validate salary:<type>
    Given path 'salary'
    And request = { employee_id:,<employee_id>, paycheck:<paycheck>}
    When method post
    Then status == <status>
    Given path 'getsalary/<employee_id>'
    When method get
    Then status == <status>
    And response.salary == <expected>
example:
|type                     | employee_id  | paycheck  |   expected  | status |
| "Valid Salary amount"   | "a1"         | 1000      | 300         | 200    |    
| "No  Salary amount"     | "a2"         | 0         | 0           | 200    |    
| "No  Salary amount"     | "a2"         | 0         | 0           | 200    | 