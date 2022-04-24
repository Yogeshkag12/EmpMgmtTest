
# This feature has following functionality:
# user can enter daily status or weekly
# user allowed to enter maximum 25hr/week 
# Its also provide total hours entered by passing start date, end date and employeeid
# User not allowed to enter past week timesheet.
@work
Feature: This feature is about test employee total working hours in a week
Background:
    * def url ="http://localhost:337"
# This scenario to check the boundary value of time count return by api.
# 1) Enter timer for a1= 40 hrs, 
# 2) Enter timer for a2= 60 hrs,
# 3) Enter timer for a3= 30 hrs,
# 4) Enter timer for a4= 39 hrs,
# 5) Enter timer for a5= 41 hrs,
# Expected result are a3 and a4 should be there in the list of response.
# also a1,a2, ans a5 should not be in the response.

Scenario Outline: Get Employee list having working hours less than 40 hrs in a week :<type>
    Given path 'timesheet'
    And request {"emloyee_id":"a1", time:"40"}
    When method post
    Then status == 200

    Given path 'timesheet'
    And request {"emloyee_id":"a2", time:"60"}
    When method post
    Then status == 200
    Given path 'timesheet'
    And request {"emloyee_id":"a3", time:"30"}
    When method post
    Then status == 200
    Given path 'timesheet'
    And request {"emloyee_id":"a4", time:"39"}
    When method post
    Then status == 200
    Given path 'timesheet'
    And request {"emloyee_id":"a5", time:"41"}
    When method post
    Then status == 200

    Given path 'weeklytimesheet/count'
    And request = {week:1}
    When method post
    Then status == 200
    And response.list contains ['a3','a4']
    And respinse not contains ['a1','a2',a5]