#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "Clas JSON cannot be initialized"
    try {
        ; call constructor
        JSON.__New()
        fail()
    } catch e {
        expected := "Class JSON cannot be initialized"
        assertEquals(expected, e)
    }
} success++


{ Test := "Parse most simple json object"
    jsonString := "{}"
    expected := Object()
    result := JSON.parse(jsonString)
    assertEquals(expected, result)
} success++


{ Test := "Parse most simple json array"
    jsonString := "[]"
    expected := Array()
    result := JSON.parse(jsonString)
    assertEquals(expected, result)
} success++


{ Test := "Parse json array with one string elem"
    jsonString := "[""elem1""]"
    expected := Array("elem1")
    result := JSON.parse(jsonString)
    assertEquals(expected, result)
} success++
