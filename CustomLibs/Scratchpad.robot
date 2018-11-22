*** Settings ***
Library   OperatingSystem

*** Test Cases ***
ListingFilesandDirs
    #${Files}=   List Files In Directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads\\Drivers
    ${Dirs}=    list directories in directory   C:\\Users\\BLR153\\Desktop\\DSAFileUploads
    :FOR  ${Dir}  in  @{Dirs}
    \   run keyword if   '''${Dir}'''== 'BaseRecords'  Log   I am reading ${Dir}



*** Keywords ***
