#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include ../lib_JSON.ahk

success := 0

assertEquals(actual, expected) {
    if (actual == expected) {
        return true
    } else {
        ; let exception bubble to top
        try {
            fail()
        }
        catch e {
            Throw e
        }
    }
}

fail() {
    global Test
    Throw "Test failed: " test
}


; ===== Tests ===============

{ Test := "Clas JSON cannot be initialized"
    try {
        try {
            ; call constructor
            JSON.__New()
            fail()
        } catch e {
            assertEquals(e, "Class JSON cannot be initialized")
        }
    } catch e {
        Throw e
    }
} success++


{ Test := "Parse most simple json object"
    try {
        jsonString := "{}"
        result := JSON.parse(jsonString)
        assertEquals(isObject(result), isObject(Object()))
    } catch e {
        Throw e 
    }
} success++


; --- Test Result
MsgBox %success% Tests successful! :)
ExitApp


; --- Template ---------
{ Test := ""
    try {

    } catch e {
        Throw e
    }
} success++
