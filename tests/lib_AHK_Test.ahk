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
    assertTrue(isObject(result))
} success++


{ Test := "Parse most simple json array"
    jsonString := "[]"
    result := JSON.parse(jsonString)
    assertTrue(isObject(result))
} success++


{ Test := "Parse json array with one string elem"
    jsonString := "[""elem1""]"
    result := JSON.parse(jsonString)
    assertEquals("elem1", result[1])
} success++