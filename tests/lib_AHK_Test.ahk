#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "Clas JSON cannot be initialized"
    try {
        try {
            ; call constructor
            JSON.__New()
            fail()
        } catch e {
            assertEquals("Class JSON cannot be initialized", e)
        }
    } catch e {
        Throw e
    }
} success++


{ Test := "Parse most simple json object"
    try {
        jsonString := "{}"
        result := JSON.parse(jsonString)
        assertEquals(false, isObject(result))
    } catch e {
        Throw e
    }
} success++


{ Test := "Parse most simple json array"
    try {
        jsonString := "[]"
        result := JSON.parse(jsonString)
        assertEquals(true, isObject(result))
    } catch e {
        Throw e 
    }
} success++
