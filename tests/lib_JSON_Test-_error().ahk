#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "JSON._error() throws exception with message"
    message := "Exception message"

    try {
        JSON._error(message)
        fail("No exception thrown.")
    } catch e {
        assertEquals(message, e)
    }
} success++


{ Test := "JSON._error() throws exception with details"
    message   := "Exception message"
    pos       := 2
    shortJSON := "[-]"

    try {
        JSON._error(message, shortJSON, pos)
        fail("No exception thrown.")
    } catch e {
        expected := message . "`n`nPosition: " . pos . "`nNear: '" shortJSON . "'"
        assertEquals(expected, e)
    }
} success++


{ Test := "JSON._error() throws exception with details and cut JSON"
    message  := "Exception message"
    pos      := 11
    longJSON := "[""abcdefg""-""1234567890""]"
    cutJSON  := SubStr(longJSON, pos -5, 15)

    try {
        JSON._error(message, longJSON, pos)
        fail("No exception thrown.")
    } catch e {
        expected := message . "`n`nPosition: " . pos . "`nNear: '" cutJSON . "'"
        assertEquals(expected, e)
    }
} success++