*** Settings ***
Library   Collections
Library   String
Library   SeleniumLibrary
Library   ExcelLibrary
Library   AutoItLibrary
Library   OperatingSystem
Resource        C:/development/robot-scripts/DSA-USA/Resources/TestData/TestData.robot


*** Variables ***
${index} =    Set Variable    -1

*** Keywords ***

begin test
    Open browser   about:blank      ${Browser}
    maximize browser window
    Go to   ${URL}
      Sleep  5s

End test
    sleep  5s
    ${Title}=   get title
    close browser

Is Driver Tab Auto Focused
    wait until element is visible      ${DriverTab_xpath}
    ${CheckDriverTabClassHasOpen}=   get element attribute    ${DriverTab_xpath}@class
    log    ${CheckDriverTabClassHasOpen}

Verify Driver Search Header
    page should contain element     ${DriverSearchHeader_Xpath}
    ${RuntimeDriverSearchHeaderTitle}=   get text    ${DriverSearchHeader_Xpath}

    run keyword if    '${RuntimeDriverSearchHeaderTitle}' == '${DriverSearchHeaderTitle}'    StartDriverSearch

Test_Search_Functionality
    Is Driver Tab Auto Focused
    Verify Driver Search Header
    Search With One field
    #Apply Filters
    Click Search Button
    No Results Found


Start Driver Search
  log   executing driver search


Search With One field
    input text   ${Employee_Id_Xpath}     54576
#    input text             ${Social_Security_Xpath}
#    input text            ${First_Name_Xpath}     Shawn
#    input text            ${last_Name_Xpath}      Mittchel
#    set focus           ${Job_Code_Xpath}
#    input text         ${Employee_Id_Xpath}
#    input text         ${Division_Id_Xpath}
#    input text        ${Company_Name_Xpath}



Search With Multiple Fields


Search With All Fields
    input text             ${Social_Security_Xpath}     9191-919-2345
    input text            ${First_Name_Xpath}     Shawn
    input text            ${last_Name_Xpath}      Mittchel
    #set focus           ${Job_Code_Xpath}
    input text         ${Employee_Id_Xpath}
    input text         ${Division_Id_Xpath}
    input text        ${Company_Name_Xpath}

Search With No Field Filled In

Apply Filters
    select checkbox         ${Switchers_Check_Box_Xpath}
    select checkbox         ${Supervisor_Check_box_Xpath}
    select checkbox         ${Terminate_or_Pending_Check_box_Xpath}
    sleep  3s
    #select checkbox         ${Only_DSA_Drivers_Check_box_Xpath}

Apply HREmployee Filter
   select checkbox         ${All_HR_Employees_Check_box_Xpath}


Click Search Button
    click button  ${Search_Button_Xpath}

No Results Found
    sleep    5s
    #PAGE SHOULD CONTAIN       ${NoSearchResultsErrorMessage}
    ${NoSearchResultFoundTextMessage}=   get text    ${NoSearchResultsErrorMessage}

Click on Upload Module
    click element   ${App_Modules_list_Xpath}


Click on each tab in uploads screen
   sleep  4s
   ${list_of_tabs}=   create list   ${Driver_Upload_Tab_Xpath}  ${Violations_Upload_Tab_Xpath}  ${BaseRecords_Upload_Tab_Xpath}  ${SafetyMiles_Upload_Tab_Xpath}  ${MVRData_Upload_Tab_Xpath}  ${LicenseDetails_Upload_Tab_Xpath}
   : FOR  ${tab}  in  @{list_of_tabs}
   \  click element   ${tab}
   \  sleep  3s

Upload All Driver Files
    click element    ${Driver_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Drivers
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \  Log  Th
    \  choose file   ${Driver_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Drivers\\${file}
    \  click button    ${Driver_Upload_Button_Xpath}
    \  sleep  15s
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \  ${UploadFileStatusMessage}   get text    ${Driver_Upload_Status_Message_Xpath}

Upload All Violations Files
    click element    ${Violations_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Violations
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \  choose file   ${Violation_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Violations\\${file}
    \   sleep  3s
    \  click button    ${Violations_Upload_Button_Xpath}
    \  sleep  10s
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \  ${UploadFileStatusMessage}   get text    ${Violations_Upload_Status_Message_Xpath}

Upload All MVRData Files
    click element    ${MVRData_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\MVRData
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \   choose file   ${mvR_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\MVRData\\${file}
    \   sleep   10s
    \  click button    ${MVRData_Upload_Button_Xpath}
    \  sleep  10s
    \  ${UploadFileStatusMessage}   get text    ${MVRData_Upload_Status_Message_Xpath}






Upload All Safety Files
    click element    ${SafetyMiles_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\SafetyMiles
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \  choose file   ${safeMiles_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\SafetyMiles\\${file}
    \   sleep  3s
    \  click button    ${SafetyMiles_Upload_Button_Xpath}
    \  sleep  10s
    \  ${UploadFileStatusMessage}   get text    ${SafetyMiles_Upload_Status_Message_Xpath}


Upload All baseRecord Files
    click element    ${BaseRecords_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\BaseRecords
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \  choose file   ${baseRecords_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\BaseRecords\\${file}
    \   sleep  3s
    \  click button    ${BaseRecords_Upload_Button_Xpath}
    \  sleep  10s
    \  ${UploadFileStatusMessage}   get text    ${BaseRecords_Upload_Status_Message_Xpath}


Upload All License Details Files
    click element    ${LicenseDetails_Upload_Tab_Xpath}
    Sleep  15s
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\LicenseDetails
    :FOR   ${index}   ${file}  IN ENUMERATE    @{Files}
    \   Log    "The file at" "${index}" is "${file}"
    \  ${FileUploadProgressMessage}   get text    ${Driver_Upload_Progress_Message_Xpath}
    \   Log    "The previous file upload status is" ${FileUploadProgressMessage}
    \  choose file   ${license_input_file}   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\LicenseDetails\\${file}
    \   sleep  3s
    \  click button    ${LicenseDetails_Upload_Button_Xpath}
    \  sleep  10s
    \  ${UploadFileStatusMessage}   get text    ${LicenseDetails_Upload_Status_Message_Xpath}




Files Processing
    ${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\MVRData
    #${index}=  set variable  1

     :FOR    ${index}    ${item}    IN ENUMERATE    @{Files}
     \    Log    "The file at" "${index}" is "${item}"


Add Violattions
