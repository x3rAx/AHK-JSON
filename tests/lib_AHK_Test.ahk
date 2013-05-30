#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "Clas JSON cannot be initialized"
    try {
        ; call constructor
        JSON.__New()
        fail()
    } catch e {
        assertEquals("Class JSON cannot be initialized", e)
    }
} success++


{ Test := "Parse most simple json object"
    jsonString := "{}"
    result := JSON.parse(jsonString)
    assertEquals(true, isObject(result))
} success++


{ Test := "Parse most simple json array"
    jsonString := "[]"
    result := JSON.parse(jsonString)
    assertEquals(true, isObject(result))
} success++
