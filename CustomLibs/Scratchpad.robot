*** Settings ***
Documentation     DSA-USA:Operations on Driver Score card bonus screen in admin module
Library   Collections
Library   String
Library   SeleniumLibrary
Library   ExcelLibrary
Library   ExcelRobot
Library   OperatingSystem
Library   Process
Library   CSV
Resource         C:/development/robot-scripts/DSA-USA/Resources/PO/CommonKeywords.robot
#Test Setup      begin test
#Test Teardown   End test


*** Test Cases ***
##ListingFilesandDirs
#    #${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Drivers
#    ${Dirs}=    list directories in directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads
#    :FOR  ${Dir}  in  @{Dirs}
#    \   run keyword if   '''${Dir}'''== 'BaseRecords'  Log   I am reading ${Dir}

Test Excel
#    Go to Driver Score Card tab in Admin
#    #Writing to spreadsheets
#    Deal with Web Tables
     #Download file to a specific directory




*** Variables ***
${colValues}   ${EMPTY}
${nColCount}   ${EMPTY}
${Existing_Configurations}=    create dictionary
${excelName}=   C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
${ActiveWorksheet}=  ScoreCardRangesToBeAdded
${Added_Range_endColumn}   ${EMPTY}


*** Keywords ***

Go to Driver Score Card tab in Admin

    click element  //a[contains(text(),'Admin')]
    sleep  7s
    Click element  //a[contains(text(),'Driver Scorecard Bonus')]
    sleep  10s
    page should contain element   //legend[contains(text(),'Driver Scorecard Rates')]

Excel operations
  Open Excel	C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
  ${NumberOfExcelSheets}=  get sheet names
  log to console    @{NumberOfExcelSheets}[1]
  ${nRowCount}=   get row count     @{NumberOfExcelSheets}[1]
  ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]

  : FOR  ${colNum}  IN RANGE     0     ${nColCount}
  \   ${colValues}=   get column values    @{NumberOfExcelSheets}[1]    ${colNum}


Nested for loop example
      Open Excel	C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
      ${NumberOfExcelSheets}=  get sheet names
      ${nRowCount}=   get row count     @{NumberOfExcelSheets}[1]
      ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]
      : FOR    ${row}    IN RANGE   0    ${nRowCount}
      \     Reading Cell values    ${row}

Reading Cell values
    [Arguments]    ${row}
    Log    this row number is ${row}
      Open Excel	C:\\Users\\BLR153\\Desktop\\DSA Automation\\DSA-USA-RFW\\ScoreCardCnfigurations.xlsx
      ${NumberOfExcelSheets}=  get sheet names
      ${nColCount}=   get column count   @{NumberOfExcelSheets}[1]
    :FOR   ${col}    IN RANGE    0    ${nColCount}
    \  ${CelData}=    read cell data      @{NumberOfExcelSheets}[1]    ${col}     ${row}+1
    \


Writing to spreadsheets
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



Download should be done
    [Arguments]    ${directory}
    [Documentation]    Verifies that the directory has only one folder and it is not a temp file.
    ...
    ...    Returns path to the file
    ${files}    List Files In Directory    ${directory}
    Length Should Be    ${files}    1    Should be only one file in the download folder
    Should Not Match Regexp    ${files[0]}    (?i).*\\.tmp    Chrome is still downloading a file
    ${file}    Join Path    ${directory}    ${files[0]}
    Log    File was successfully downloaded to ${file}
    [Return]    ${file}


Download File
    # create unique folder
    ${now}    Get Time    epoch
    ${download directory}    Join Path    ${OUTPUT DIR}    downloads_${now}
    Create Directory    ${download directory}
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    # list of plugins to disable. disabling PDF Viewer is necessary so that PDFs are saved rather than displayed
    ${disabled}    Create List    Chrome PDF Viewer
    ${prefs}    Create Dictionary    download.default_directory=${download directory}    plugins.plugins_disabled=${disabled}
    Call Method    ${chrome options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chrome options}
    Goto    C:\\Users\\BLR153\\Desktop\\Sample CSV Files
    Export Driver Score Card in CSV file for all Fiscal Quarters in Bonuses
    # wait for download to finish
    ${file}    Wait Until Keyword Succeeds    1 min    2 sec    Download should be done    ${download directory}



