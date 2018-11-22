###############################
# Header, Page, title etc Locators  #
###############################
App_Modules_list_Xpath = "//ul[@id='app-navbar']/li[5]"

Header_App_Name_Xpath = "//h1[@id='app-name']"


###############################
# Driver Tab Locators  #
###############################
DriverTab_xpath =  "//li[contains(@ng-if,'roleDriverSearch')]"
DriverSearchHeader_Xpath =  "//span[@class='driverSearchHeader ng-binding']"


###############################
# Driver Search screen Locators  #
###############################
Department_Xpath = "//input[@id='Department']"
Social_Security_Xpath = "//input[@id='socialSecurity']"
First_Name_Xpath = "//input[@id='firstName']"
last_Name_Xpath = "//input[@id='lastName']"
Job_Code_Xpath = "//select[@id='jobCode']"
Employee_Id_Xpath = "//input[@id='employeeId']"
Division_Id_Xpath = "//input[@id='division']"
Company_Name_Xpath = "//input[@id='company']"
Switchers_Check_Box_Xpath = "//input[@title='Switchers']"
Supervisor_Check_box_Xpath = "//input[@title='Supervisor'][contains(@class,'form-checkbox ng-pristine ')]"
Only_DSA_Drivers_Check_box_Xpath = "//input[@title='Only DSA Drivers']"
Terminate_or_Pending_Check_box_Xpath = "//input[@title='Terminated/Pending']"
All_HR_Employees_Check_box_Xpath = "//input[@title='All HR Employees']"
Search_Button_Xpath = "//button[@id='driverSearch']"
NoSearchResultsErrorMessage = "//div[@ng-class='searchstatusErrorMsg']"


###############################
# Upload screen Locators  #
###############################

    ###############################
    # Choose file Locators  #
    ###############################
Driver_input_file = "//input[@file-model='driveruploadfile']"
Violation_input_file = "//input[@file-model='violationsuploadfile']"
mvR_input_file = "//input[@file-model='mVRuploadfile']"
safeMiles_input_file = "//input[@file-model='safeMilesuploadfile']"
license_input_file = "//input[@file-model='licenseUploadfile']"
baseRecords_input_file = "//input[@file-model='baseRecordsuploadfile']"

###########################
# Upload tabs  Locators  #
###########################
Driver_Upload_Tab_Xpath = "//tab-heading[@title='Upload Drivers']"
Violations_Upload_Tab_Xpath = "//tab-heading[contains(text(),'Upload Violations')]"
BaseRecords_Upload_Tab_Xpath = "//tab-heading[@title='Upload Base Records']"
SafetyMiles_Upload_Tab_Xpath = "//tab-heading[@title='Upload Safety Miles']"
MVRData_Upload_Tab_Xpath = "//tab-heading[@title='Upload MVR Data']"
LicenseDetails_Upload_Tab_Xpath = "//tab-heading[@title='Upload License Details']"

###########################
# Upload button  Locators  #
###########################
Driver_Upload_Button_Xpath = "//button[@ng-disabled='uploadDriverButton']"
Violations_Upload_Button_Xpath = "//button[@ng-disabled='uploadViolation']"
BaseRecords_Upload_Button_Xpath = "//button[@ng-disabled='uploadBaseRecord']"
SafetyMiles_Upload_Button_Xpath = "//button[@ng-disabled='uploadSafeMile']"
MVRData_Upload_Button_Xpath = "//button[@ng-disabled='uploadMVRButton']"
LicenseDetails_Upload_Button_Xpath = "//button[@ng-disabled='uploadLicenseButton']"



###########################
# Upload status messages Locators
###########################
LicenseDetails_Upload_Status_Message_Xpath = "//div[@ng-class='uploadLicenseRecordStatusStyle']"
Driver_Upload_Status_Message_Xpath = "//div[@ng-class='uploadDriversRecordStatusStyle']"
MVRData_Upload_Status_Message_Xpath = "//div[@class='AdminTabs row-change']//div[@ng-class='uploadMvrRecordStatusStyle']"
BaseRecords_Upload_Status_Message_Xpath = "//div[@ng-class='uploadBaseRowRecordStatusStyle']"
Violations_Upload_Status_Message_Xpath = "//div[@class='ng-binding statuSuccessMsg'][@ng-class='uploadViolationsRecordStatusStyle']"
SafetyMiles_Upload_Status_Message_Xpath = "//div[@ng-class='uploadSafeMilesRecordStatusStyle']"


###########################
# Upload progress status Locators - This message displayed on screen as start date and upload end date with time stamps
###########################
Driver_Upload_Progress_Message_Xpath = "//div[@ng-if='messageDisplayFlag']"


