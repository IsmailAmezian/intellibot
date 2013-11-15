*** Settings ***
# fun things going on here
Documentation  Test the account dashboard

Resource  kyle/web/db_advertiser_actions.txt
Resource  kyle/web/db_campaign_actions.txt
Resource  kyle/web/db_staff_actions.txt
Resource  kyle/web/ui_login_page.txt
Resource  kyle/web/ui_manage_accounts_page.txt
Resource  kyle_db_cleanup/kyle_cleanup.txt
Library  Selenium2Library  timeout=${ENV['selenium']['timeout']}  implicit_wait=${ENV['selenium']['implicit_wait']}
Library  db.orm.Orm
Library  OperatingSystem
Library  Collections

Force Tags  Kyle  Advertiser  Dashboard  Component

*** Test Cases ***

Scenario: An admin can see the conversion trend
  [Tags]  Was Flickering
  [Setup]  Prepare advertiser "Robot_Company"
    Given Advertiser has performance data
    And I have an Account Manager  MANAGER
    When I login to Tapmatch as Staff  ${ACCOUNT_MANAGER.user.name}  ${ACCOUNT_MANAGER.user.password}
    Then The 7-day average should be  $0.09
  [Teardown]  Run Keywords  Close All Browsers  Clean Database

*** Keywords ***

Clean Database
  [Documentation]  Cleans the database
    Clean  Kyle
    Clean  Ike
