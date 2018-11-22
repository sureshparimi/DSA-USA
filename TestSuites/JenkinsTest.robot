*** Settings ***
Library    JenkinsLibrary

*** Test Cases ***
Jenkins Create And Run Job
    [Setup]    Set Jenkins Server    url=http://localhost:8080/    username=sparimi    password=Suresh@25
    Create Jenkins Job    test_job
    Start Jenkins Job    test_job