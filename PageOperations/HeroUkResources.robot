*** Settings ***
Library         SeleniumLibrary

Resource       ../PageObjects/BasePage.robot
Variables        ../PageObjects/Basepage1.py
Resource        ../Utlis/Helper.robot

*** Keywords ***
User Clicks On The Url
    Open Browser           ${BaseUrl}        chrome
    Maximize Browser Window

Changes The Required Input
    Wait For The Element To Load
    Click Element    ${TableDataButtonXpath}
    Wait For The Element To Load
    Input Text    ${TableDataXpath}    ${InputData}
    Click Element    ${RefreshButtonXpath}
    Wait For The Element To Load

Stored Data And Input Data Should Be Same 
   ${tableData1}    Get Text    //table[@id ='dynamictable']//child::tr[2]
   ${tableData2}    Get Text    //table[@id ='dynamictable']//child::tr[3]
   ${tableData3}    Get Text    //table[@id ='dynamictable']//child::tr[4]
   ${tableData4}    Get Text    //table[@id ='dynamictable']//child::tr[5]
   ${tableData5}    Get Text    //table[@id ='dynamictable']//child::tr[6]

    ${tableDataList} =    Create List    ${tableData1}    ${tableData2}    ${tableData3}    ${tableData4}    ${tableData5}
    ${tableDataJSON} =    Convert To JSON    ${tableDataList}

   Log To Console    ${tableDataList}
   Should Be Equal As Strings    ${tableDataJSON}   ${InputData}

Convert To JSON
    [Arguments]    ${list}
    ${json_string} =    Evaluate    json.dumps($list)
    [Return]    ${json_string}    