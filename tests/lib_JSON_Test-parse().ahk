#Include ../lib_JSON.ahk


; ===== Tests ===============

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


{ Test := "Parse json array with multiple strings"
    jsonString := "[""elem1"",""elem2"",""elem3""]"
    result := JSON.parse(jsonString)
    expected := Array("elem1", "elem2", "elem3")
    assertEquals(expected, result)
} success++

{ Test := "Parser throws exception on unexpected token"
    try {
        jsonString := "[-]"
        JSON.parse(jsonString)
        fail("No exception thrown.")
    } catch e {
        expected := "Unexpected token '-'"
        actual   := SubStr(e, 1, StrLen(expected))
        assertEquals(expected, actual)
    }
} success++
