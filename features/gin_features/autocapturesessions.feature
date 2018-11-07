Feature: Configure auto capture sessions

Background:
  Given I set environment variable "API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I set environment variable "SERVER_PORT" to "4511"

Scenario Outline: A session is not sent if auto capture sessions is off
  Given I set environment variable "GIN_VERSION" to "<gin version>"
  And I set environment variable "AUTO_CAPTURE_SESSIONS" to "false"
  When I start the service "gin"
  And I wait for the app to open port "4511"
  And I wait for 2 seconds
  And I open the URL "http://localhost:4511/session"
  And I wait for 2 seconds
  Then I should receive no requests

  Examples:
  | gin version |
  | v1.3.0      |
  | v1.2        |
  | v1.1        |
  | v1.0        |

Scenario Outline: A session is sent if auto capture sessions is on
  Given I set environment variable "GIN_VERSION" to "<gin version>"
  And I set environment variable "AUTO_CAPTURE_SESSIONS" to "true"
  When I start the service "gin"
  And I wait for the app to open port "4511"
  And I wait for 2 seconds
  And I open the URL "http://localhost:4511/session"
  Then I wait to receive a request
  And the request is a valid session report with api key "a35a2a72bd230ac0aa0f52715bbdc6aa"

  Examples:
  | gin version |
  | v1.3.0      |
  | v1.2        |
  | v1.1        |
  | v1.0        |