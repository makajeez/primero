# JIRA PRIMERO-294
# JIRA PRIMERO-736
# TODO Write test for filters

@javascript @primero @search
Feature: Record Owner
  As a Social worker, I want to enter information related to the record owner

Background:
  Given I am logged in as an admin with username "primero_cp" and password "primero"
  When I access "cases page"
  And I press the "New Case" button

Scenario: As a logged in user, I create a case by entering something in the record owner form
And I press the "Record Owner" button
And I fill in the following:
  | Location Address  | Kenya              |
  | Previous Owner    | admin              |
  | Previous Agency   | Test Agency        |
And I press "Save"
Then I should see a success message for new Case
And I should see a value for "Location Address" on the show page with the value of "Kenya"
And I should see a value for "Previous Agency" on the show page with the value of "Test Agency"
And I should see a value for "Record created by" on the show page with the value of "primero_cp"
And I should see "Record State: Valid record" on the page

Scenario: As a logged in user, When I am on the case index page only valid recrods should be displayed
And I fill in the following:
  | Name              | Daenerys Targaryen |
  | Age               | 24                 |
  | Other Agency Name | Test Agency        |
  | UNHCR ID          | AAA000             |
  | Nickname          | Khaleesi           |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I access "cases page"
And I press the "New Case" button
And I fill in the following:
  | Name              | John Snow   |
  | Age               | 24          |
  | Other Agency ID   | ABC12345    |
  | Other Agency Name | Test Agency |
  | ICRC Ref No.      | 131313      |
  | RC ID No.         | 141414      |
  | Nickname          | Lord Snow   |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I access "cases page"
And I press the "New Case" button
And I fill in the following:
  | Name              | Eddard Stark   |
  | Age               | 45             |
  | Other Agency ID   | ABC12345       |
  | Other Agency Name | Test Agency    |
  | UNHCR ID          | AAA001         |
  | Nickname          | Lord Stark     |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I press the "Actions" button
And I press the "Disable" button
And I should see "Clicking OK will change the state of this record to 'Invalid record'" on the page
And I press the "OK" button
And I should see "Record State: Invalid record" on the page
And I access "cases page"
Then I should see "John Snow" on the page
And I should see "Daenerys Targaryen" on the page

Scenario: As a Social Worker I want to be able to view a case record that I have marked as Invalid
And I fill in the following:
  | Name              | Daenerys Targaryen |
  | Age               | 24                 |
  | Other Agency Name | Test Agency        |
  | UNHCR ID          | AAA000             |
  | Nickname          | Khaleesi           |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I access "cases page"
And I press the "New Case" button
And I fill in the following:
  | Name              | John Snow   |
  | Age               | 24          |
  | Other Agency ID   | ABC12345    |
  | Other Agency Name | Test Agency |
  | ICRC Ref No.      | 131313      |
  | RC ID No.         | 141414      |
  | Nickname          | Lord Snow   |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I access "cases page"
And I press the "New Case" button
And I fill in the following:
  | Name              | Eddard Stark   |
  | Age               | 45             |
  | Other Agency ID   | ABC12345       |
  | Other Agency Name | Test Agency    |
  | UNHCR ID          | AAA001         |
  | Nickname          | Lord Stark     |
And I press "Save"
And I should see "Record State: Valid record" on the page
And I press the "Actions" button
And I press the "Disable" button
And I should see "Clicking OK will change the state of this record to 'Invalid record'" on the page
And I press the "OK" button
And I should see "Record State: Invalid record" on the page
And I access "cases page"
Then I should see "John Snow" on the page
And I should see "Daenerys Targaryen" on the page