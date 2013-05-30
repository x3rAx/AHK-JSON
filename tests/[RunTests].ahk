#Include ./AHKUnit/AHKUnit.ahk



; ===== Tests ===============
#Include ./lib_AHK_Test.ahk



; --- Display test results ---------
testResults()
return

; --- Template ---------
{ Test := ""
    try {
        ; Testcode here
    } catch e {
        Throw e
    }
} success++
