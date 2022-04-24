
# This feature has following functionality:
# user can enter daily status or weekly
# user allowed to enter maximum 25hr/week 
# Its also provide total hours entered by passing start date, end date and employeeid
# User not allowed to enter past week timesheet.
@work
Feature: This feature is about test employee total Sick Leave
Background:
    * def url ="http://localhost:337"
# This scenario to check the sick leave count return by api.
# Assum 1 : this api is calculating leaves for 1 month
# Assum 2 : there are 20 working days
# 1) employee a1 sick leave apply =0,
# 2) employee a2 sick leave apply =19,
# 3) employee a3 sick leave apply =20,
# 4) employee a4 sick leave apply =21,
# Expected result are a1,a2 and a3 should be there in the list of response.
# also a4 should not be in the response.

Scenario Outline: Get Employee list having taken sick leave :<type>
    Given path 'createSickLeave'
    And request {"emloyee_id":"a1", fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == 200

    Given path 'createSickLeave'
    And request {"emloyee_id":"a2", fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == 200
    Given path 'createSickLeave'
    And request {"emloyee_id":"a3", fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == 200
    Given path 'createSickLeave'
    And request {"emloyee_id":"a4",fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == 200
    Given path 'createSickLeave'
    And request {"emloyee_id":"a5", fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == 401

    Given path 'getAllEmployeeSickLeave'
    And request = {week:1}
    When method post
    Then status == 200
    And response.list contains ['a1',a2,a3,a5,] 
    And response not contains ['a4']