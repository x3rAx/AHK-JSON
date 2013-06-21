#Include ./[AHKUnit]/AHKUnit.ahk



; ===== Tests ===============
#Include ./lib_JSON_Test-__New().ahk
#Include ./lib_JSON_Test-parse().ahk
#Include ./lib_JSON_Test-_error().ahk



; --- Display test results ---------
testResults()
return

; --- Template ---------
{ Test := ""
    ; Testcode here
} success++
