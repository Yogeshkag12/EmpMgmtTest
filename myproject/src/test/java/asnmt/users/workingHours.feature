
# This feature has following functionality:
# user can enter daily status or weekly
# user allowed to enter maximum 25hr/week 
# Its also provide total hours entered by passing start date, end date and employeeid
# User not allowed to enter past week timesheet.
@work
Feature: This feature is about test current and past working hours
Background:
    * def url ="http://localhost:337"

Scenario Outline: Get Users past and current time for :<type>
    Given path 'timesheet/count'
    And request = { employee_id:,<employee_id>, fromdate:<fromdate>, todate:<todate>}
    When method post
    Then status == <status>
    And response.message == <message>

example:
|type                | employee_id  | fromdate                 |   todate               | status | meessage                                                 |
| "Invalid todate"   | 1            | "2022-03-12 09:55:22"    |  "2022-02-12 09:55:22" |401     | "To date can not be less than from date"                  |   
| "Null empoyeeid"   |              | "2022-03-12 09:55:22"    |  "2022-04-12 09:55:22" |401     | "Employee id can not be null"                  |  
| "Invalid empoyeeid"| 000          | "2022-03-12 09:55:22"    |  "2022-04-12 09:55:22" |401     | "Employee id is not valid"                  |   
| "Invalid fromdate" | 1            | "1400-03-12 09:55:22"    |  "2022-02-12 09:55:22" |401     | "From date can not be past more then 3 years"                  |
| "Null todate"      | 1            | "1400-03-12 09:55:22"    |  "2022-02-12 09:55:22" |401     | "From date can not be past more then 3 years"                  |   
