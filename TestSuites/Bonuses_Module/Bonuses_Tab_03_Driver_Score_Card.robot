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
Library         C:/development/robot-scripts/DSA-USA/CustomLibs/csvLibrary.py
Library         C:/development/robot-scripts/DSA-USA/CustomLibs/ReadFilesinDir.py
Test Setup      begin test

##############################################
# robot -d Results TestSuites/Bonuses_Module/Bonuses_Tab_03_Driver_Score_Card.robot
##############################################

*** Variables ***



*** Test Cases ***

TC_01_Testing Bonus module - Driver score card web table and export features
        Read incentive Amounts from grid - Driver Score Card tab under Bonuses Module
        Export Driver Score Card in CSV file for all Fiscal Quarters in Bonuses
        Verify CSV File Content verification


*** Keywords ***

Read incentive Amounts from grid - Driver Score Card tab under Bonuses Module
    Click element  //li[@class='dropdown ng-scope']//a[@class='ng-binding'][contains(text(),'Bonuses')]
    sleep  7s
    Click element  //li[@title='Driver Scorecard']//a[@class='ng-binding'][contains(text(),'Driver Scorecard')]
    sleep   2s
    select from list by index     //select[@id='fiscalQuarter']     1
    sleep  15s
    ${NumberOfIncentiveAmountRows}=     get element count     //div[@ng-repeat="row in renderedRows"]//div[contains(@class,'colt9')]
    ${IncentiveAmountList}   create list
    :FOR  ${Index}  IN RANGE   0   ${NumberOfIncentiveAmountRows}
    \   ${Index}=   evaluate  ${Index}+1
    \    ${IncentiveAmount} =    get text     //div/div[4]/div/div[2]/div/div[${Index}]//div[8]//div[2]//span
    \    append to list    ${IncentiveAmountList}    ${IncentiveAmount}
    Log   ${IncentiveAmountList}




Export Driver Score Card in CSV file for all Fiscal Quarters in Bonuses
    # remove Select word from Fiscal Quarter dropdown values
    page should contain element   //label[contains(text(),'Fiscal Quarter')]
    ${FiscalQuarterDropDownValues}=   get list items   //select[@id='fiscalQuarter']
    remove from list    ${FiscalQuarterDropDownValues}    0
    sort list    ${FiscalQuarterDropDownValues}
    Log   ${FiscalQuarterDropDownValues}
    #${NumberOfFiscalQuartersavailable}=    get length    ${FiscalQuarterDropDownValues}
   # Export Driver score card for each Fiscal Quarter after recalucating the score cards
    :FOR    ${FiscalQuarter}  in     @{FiscalQuarterDropDownValues}
    \   Select from FiscalQuarters dropdown by value    //select[@id='fiscalQuarter']     ${FiscalQuarter}
    \   set selenium implicit wait    60s
    \    element should be enabled   //button[contains(text(),'Recalculate')]
    \    click button    //button[contains(text(),'Recalculate')]
    \    sleep   240s
    #\   page should not contain element    //div[@class = 'block-ui-message ng-binding']
    \   element should be enabled      //button[@data-ng-click="exportScores()"]
    \    click button     //button[@data-ng-click="exportScores()"]
    \   sleep   10s



# Not using
Select from FiscalQuarters dropdown by value
    [Arguments]    ${locator}      ${select value}
    Focus   ${locator}
    # Select from list by label
    Select From List By Label   ${locator}  ${select value}
    sleep  20s
    # Get selected value and validate it against passed value as argument
#    ${value} =  Get Selected List Label    ${locator}
#    Should be equal  ${select value}  ${value}

# This keyword can be used to verify if a file contains specific list list of items - Change List of Excluded Values
Verify CSV File Content verification
    ${current_dir_path}=    set variable   'C:\\Users\\BLR153\\Downloads\\'
    ${AllFiles}=        get files from dir      ${current_dir_path}
    :FOR  ${File}   IN    @{AllFiles}
     \   ${data}=       read csv file   C:\\Users\\BLR153\\Downloads\\${File}
     \  ${ListOfExcludedValues}=   create list   0   ${empty}
     \  run keyword and continue on failure    Verify-value exists in List    ${data}    ${ListOfExcludedValues}

# This keyword used to verify if a list contains a value or nt
Verify-value exists in List
   [Arguments]  ${List}   ${ExpectedValuestoCheckinList}
   :For  ${Item}  in  @{ExpectedValuestoCheckinList}
   \  list should not contain value    ${List}   ${Item}




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
    #Create Webdriver    Chrome    chrome_options=${chrome options}
    #Goto    C:\\Users\\BLR153\\Desktop\\Sample CSV Files
    run keyword     Export Driver Score Card in CSV file for all Fiscal Quarters in Bonuses
    # wait for download to finish
    ${file}    Wait Until Keyword Succeeds    1 min    2 sec    Download should be done    ${download directory}

