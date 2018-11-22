*** Settings ***
Resource         C:/development/robot-scripts/DSA-USA/Resources/CommonResources/CommonKeywords/CommonKeywords.robot
Resource       C:/development/robot-scripts/DSA-USA/Resources/AppDependent/TestData/TestData.robot
Variables         C:/development/robot-scripts/DSA-USA/Resources/AppDependent/Locators/DriverTabLocators.py
Resource         C:/development/robot-scripts/DSA-USA/Resources/PO/dataManager.robot


#Test Setup      begin test

#Test Teardown   End test

# robot -d Results TestSuites/DriverTabTests/SearchDrivers.robot


*** Test Cases ***
#01_Open Driver Safety Application and check if Driver tab is auto focused
#      [Documentation]    This test case checks if DSA is opened and driver tab is auto focused
#      [Tags]   smoke
#      log     "This is part of smoke test to verify if DSA app is up and running
#      Test_Search_Functionality
#
#
#Conduct Search with Multiple data sets of fields
#    ${FilestoBeUploaded}=  get files from dir  ${current_dir_path}


FilesTesting
