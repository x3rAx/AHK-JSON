#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "Clas JSON cannot be initialized"
    try {
        ; call constructor
        JSON.__New()
        fail("No exception thrown.")
    } catch e {
        expected := "Class JSON cannot be initialized"
        assertEquals(expected, e)
    }
} success++
