#Include ./[AHKUnit]/AHKUnit.ahk

try {

    ; ===== Tests ===============
    #Include ./lib_JSON_Test-__New().ahk
    #Include ./lib_JSON_Test-_error().ahk
    #Include ./lib_JSON_Test-_getNextAllowedTokens().ahk
    #Include ./lib_JSON_Test-parse().ahk

} catch e {
    MsgBox Exception at test '%Test%'`nwith message:`n`n%e%
    ExitApp
}


; --- Display test results ---------
testResults()
return

; --- Template ---------
{ Test := ""
    ; Testcode here
} success++
