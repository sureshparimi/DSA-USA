*** Settings ***
Library   Collections
Library   String
Library   SeleniumLibrary
Library   ExcelLibrary
Library   OperatingSystem
Resource         C:/development/robot-scripts/DSA-USA/Resources/PO/CommonKeywords.robot
Resource       C:/development/robot-scripts/DSA-USA/Resources/TestData/TestData.robot
Variables         C:/development/robot-scripts/DSA-USA/Resources/PO/DSALocators.py
Resource         C:/development/robot-scripts/DSA-USA/Resources/PO/dataManager.robot


# robot -d Results TestSuites/Test_Upload_Files.robot
*** Test Cases ***

Driver Files should be uploaded successfully with valid csv file and data
    begin test
    Click on Upload Module
    Upload All Violations Files
    Upload All Driver Files
    Upload All MVRData Files
    Upload All Safety Files
    Upload All baseRecord Files
    Upload All License Details Files





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

