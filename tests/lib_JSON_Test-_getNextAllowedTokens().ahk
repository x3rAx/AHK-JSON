#Include ../lib_JSON.ahk


; ===== Tests ===============

{ Test := "Return allowed tokens for empty token stack"
    symbolStack := ""
    result := JSON._getNextAllowedTokens(symbolStack)
    expected := "{["
    assertEquals(expected, result)
} success++


{ Test := "Return allowed tokens for open array"
    symbolStack := "["
    result := JSON._getNextAllowedTokens(symbolStack)
    expected := "S]"
    assertEquals(expected, result)
} success++


{ Test := "Return allowed tokens for open array after string"
    symbolStack := "[S"
    result := JSON._getNextAllowedTokens(symbolStack)
    expected := ",]"
    assertEquals(expected, result)
} success++


{ Test := "Return allowed tokens for comma"
    symbolStack := "[S,"
    result := JSON._getNextAllowedTokens(symbolStack)
    expected := "S"
    assertEquals(expected, result)
} success++

