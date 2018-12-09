*** Settings ***
Documentation     DSA-USA:Operations on Driver Score card bonus screen in admin module
Library   Collections
Library   String
Library   SeleniumLibrary
Library   ExcelLibrary
Library   ExcelRobot
Library   OperatingSystem
Library   Process
Resource         C:/development/robot-scripts/DSA-USA/Resources/PO/CommonKeywords.robot
Test Setup      begin test
Test Teardown   End test

###########################################
# robot -d Results TestSuites/Admin/Admin_ScoreCardConfiguration.robot
############################################
*** Test Cases ***

Operations on Driver Score Card Bonus tab under Admin Module
       Go to Driver Score Card tab in Admin
       Check If no configurations are set or equal to zero
       Add Driver Score Ranges from spread sheet
       Writing Added configurations to spreadsheets


*** Variables ***
${Existing_Configurations}=    create dictionary
${excelName}=   C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
${ActiveWorksheet}=  ScoreCardRangesToBeAdded


*** Keywords ***

#begin test
    Open browser   about:blank      ${Browser}
    maximize browser window
    Go to   ${URL}    #https://vs83t:Suresh@16@mysit.gfs.com/driverSafety/#/
      Sleep  5s

#Is Driver Tab Auto Focused
    wait until element is visible      ${DriverTab_xpath}
    ${CheckDriverTabClassHasOpen}=   get element attribute    ${DriverTab_xpath}@class
    log    ${CheckDriverTabClassHasOpen}
Go to Driver Score Card tab in Admin
    sleep   5s
    click element  //a[contains(text(),'Admin')]
    sleep  5s
    Click element  //a[contains(text(),'Driver Scorecard Bonus')]
    sleep  10s
    page should contain element   //legend[contains(text(),'Driver Scorecard Rates')]
Check If no configurations are set or equal to zero

    ${No_Of_Remove_buttons} =  get matching xpath count  (//button[@id='remove'])
     RUN KEYWORD IF   ${No_Of_Remove_buttons} >= 0     Cleanup existing configuratins in Driver Score Card Bonus tab in admin module

Cleanup existing configuratins in Driver Score Card Bonus tab in admin module

        ${No_Of_Remove_buttons} =  get matching xpath count  (//button[@id='remove'])
        ${No_Of_Remove_buttons}=  evaluate  ${No_Of_Remove_buttons} +1
    :FOR   ${i}   IN RANGE   ${No_Of_Remove_buttons}
    \  sleep  2s
    \   ${No_Of_Remove_buttons}=    Evaluate   ${No_Of_Remove_buttons} - 1
    \   exit for loop if   ${No_Of_Remove_buttons} == 0
    \   click button    (//button[@id='remove'])[${No_Of_Remove_buttons}]


Add Driver Score Ranges from spread sheet
      Open Excel	${excelName}
      ${NumberOfExcelSheets}=  get sheet names
      ${nRowCount}=   get row count     @{NumberOfExcelSheets}[1]
      ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]
      : FOR    ${row}    IN RANGE   1    ${nRowCount}
      \     Reading data from spreadsheet    ${row}
      \     sleep  2 s
    \   Click Button   //button[@id='add']
    \   sleep  2s
    \   page should contain textfield   //input[@data-ng-model='range.minimumScoreNbrInput']
    \   element should be disabled    //button[@id='save']
    \   element should be enabled     //button[@id='cancel']
    \    input text    //input[@data-ng-model='range.minimumScoreNbrInput']   ${MinScoreInput}
    \    sleep   1s
    \   input text    //input[@name='amountInput']     ${IncentiveAmount}
    \   Sleep   2s
    \   element should be enabled     //button[@id='save']
    \   click element    //button[@id='save']
    \   sleep  3s

Reading data from spreadsheet
    [Arguments]    ${row}
    #Log    this row number is ${row}
      Open Excel	${excelName}
      ${NumberOfExcelSheets}=  get sheet names
      ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]
    :FOR   ${col}    IN RANGE    0    1
    \   ${CelData}=    read cell data      @{NumberOfExcelSheets}[1]    ${col}      ${row}
    \    Set Suite Variable    ${MinScoreInput}     ${CelData}
    \    ${col1} =    evaluate   ${col}+1
    \    ${CelData2}=   read cell data     @{NumberOfExcelSheets}[1]    ${col1}      ${row}
    \    Set Suite Variable    ${IncentiveAmount}      ${CelData2}



Writing Added configurations to spreadsheets
  open excel to write      C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
  run keyword      Handling columns to write data to sheet
  ${get_Existing_Configurations_Count}    get element count       (//span[@id='base-range'])
  :FOR  ${row}  IN RANGE     1     ${get_Existing_Configurations_Count}+1
   \  ${Added_Range_Start}   get text    (//span[@id='base-range'])[ ${row}]
   \  ${Added_Range_end}   get text    (//div[@id='range-end'])[ ${row}]/span
   \   ${Added_Incentive}=   get text   (//span[@id='base-amount'])[ ${row}]
  \    write to cell     ${ActiveWorksheet}       ${Added_Range_StartColumn}            ${row}     ${Added_Range_Start}
  \    write to cell     ${ActiveWorksheet}       ${Added_Range_endColumn}        ${row}     ${Added_Range_end}
  \    write to cell     ${ActiveWorksheet}       ${Added_IncentiveColumn}     ${row}     ${Added_Incentive}
  save excel




Handling columns to write data to sheet

    Open Excel	C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
#    ${SheetNames}=  get sheet names
#    ${SheetChk} =  Evaluate    ${ActiveWorksheet}   in    @{sheetNames}
#    Run keyword If  "${SheetChk}" == "False"  create sheet    ${ActiveWorksheet}
     ${NumberOfExcelSheets}=  get sheet names
    ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]
     :FOR   ${col}    IN RANGE    3    5
     \  sleep  2s
     \  ${Added_Range_StartColumn}=   evaluate    ${col}-1
     \  ${Added_Range_endColumn}=      evaluate    ${col}+0
     \  ${Added_IncentiveColumn}=    evaluate   ${Added_Range_endColumn}+1
     \  Set Suite Variable   ${Added_IncentiveColumn}    ${Added_IncentiveColumn}
     \  Set Suite Variable  ${Added_Range_endColumn}     ${col}
     \  Set Suite Variable     ${Added_Range_StartColumn}      ${Added_Range_StartColumn}

Compare inputs from excel and added values from app and mark the status
     open excel to write    C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\



