/*!
    Library: JSON, v0.0.1
        JSON library for AutoHotkey
    Author: ^x3ro (Björn Richter) <mail [at] x3ro [dot] net>
    License:
*/
class JSON {

    ; Define regexps for token symbols
    static _regexps := {
        (LTrim Join
            "{" : "(\{)",
            "}" : "(\})",
            "[" : "(\[)",
            "]" : "(\])",
            "S" : """(.*?)""",
            "," : "(,)"
        )}

    ; Define which tokens (symbols) may appear after the ones before
    static _tokenRules := {
        (LTrim Join Comments
            "^$"         : "{[",     ; If symbol stack is empty
            "\{$"        : "}",      ; For now, only allow an empty object
            "\[$"        : "S]",     ; First element in array
            "\[(S,)*?S$" : ",]",     ; In array, after a string
            "\[(S,)*?$"  : "S"       ; In array, after a comma
        )}

    /*
        Function: __NEew()
            (Constructor) Prevents the class from being initialized by throwing an error

        Throws:
            Exception message
    */
    __New() {
        ; Prevent from being initialized
        throw "Class JSON cannot be initialized"
    }

    /*!
        Function: parse(jsonString)
            Parses a JSON string to an object.

        Parameters:
            jsonString  - The JSON string to parse

        Returns:
            Object

        Throws:
            Exception on unexcepted token
    */
    parse(jsonString) {
        ret := Object()
        len := StrLen(jsonString)
        pos := 1

        while (pos <= len) {
            allowedTokens := this._getNextAllowedTokens(symbolStack)

            match := false

            Loop parse, allowedTokens
            {
                symbol := A_LoopField
                regex  := this._regexps[symbol]

                RegExMatch(jsonString, "OSi)(" . regex . ")", match, pos)

                if (match.Pos(1) == pos) {
                    if (RegExMatch(match.Value(1), "OSi)""(.*?)""", strMatch)) {
                        ret.insert(strMatch.Value(1))
                    }

                    symbolStack .= symbol
                    pos += match.Len(1)

                    break
                } else {
                    match := false
                }
            }

            if (!match) {
                char := SubStr(jsonString, pos, 1)
                this._error("SyntaxError: Unexpected token '" . char . "'", jsonString, pos)
            }
        }
        
        return ret
    }

    /*
        Function: _getNextAllowedTokens(symbolStack)
            Determines which are the next allowed tokens based on the given
            symbol stack.

        Parameters:
            symbilStack  - The symbol stack that determines the next tokens

        Returns:
            String tokens
    */
    _getNextAllowedTokens(symbolStack) {
        for regex,tokens in this._tokenRules {
            if (RegExMatch(symbolStack, "Si)" . regex)) {
                return tokens
            }
        }
    }

    /*
        Function: _error(msg [, jsonString, pos])
            Generate exception base on message, json string and position

        Parameters:
            msg         - The error message to display
            jsonString  - (optional) The JSON string. This must be passed along
                            with `pos` to have an effect.
            pos         - (optional) The position where the error occured. This
                            must be passed along with `jsonString` to have an
                            effect.

        Throws:
            Exception message
    */
    _error(msg, jsonString="", pos="") {
        if (jsonString != "" && pos != "") {
            start    := pos -5
            length   := 15
            msg .= "`n`n"
            msg .= "Position: " . pos . "`n"
            msg .= "Near: '" . SubStr(jsonString, start, length) . "'"
        }

        throw msg
    }

}
