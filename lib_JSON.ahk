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

    static _reduceRules := [
        (LTrim Join Comments
            { regex : "(\{\})",          sub : "O", fnc : "_reduce_object" },
            { regex : "(\[((S,)*S)*\])", sub : "A", fnc : "_reduce_array"  }
        )]

    /*
        Function: __New()
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
        ret         := Object()
        len         := StrLen(jsonString)
        pos         := 1
        symbolStack := ""

        while (pos <= len) {
            this._next(jsonString, ret, pos, symbolStack)
            this._reduce(ret, symbolStack)
        }

        return ret[""]
    }

    /*
        Function: _next(jsonString, ret, ByRef pos, ByRef symbolStack)
            Find next token and add it to the symbol stack

        Parameters:
            jsonString  - The JSON string
            ret         - The return object
            pos         - (ByRef) The current position
            symbolStack - (ByRef) The symbol stack

        Throws:
            Exception on unexcepted token
    */
    _next(jsonString, ret, ByRef pos, ByRef symbolStack) {
        allowedTokens := this._getNextAllowedTokens(symbolStack)

        match := false

        Loop parse, allowedTokens
        {
            symbol := A_LoopField
            regex  := this._regexps[symbol]

            ; Match 1 is the whole token, match 2 is without quotes
            RegExMatch(jsonString, "OSi)(" . regex . ")", match, pos)

            if (match.Pos(1) == pos) {
                ret.insert(match.Value(2))

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

    _reduce(ret, ByRef symbolStack) {
        for key,rule in this._reduceRules {
            regex     := rule["regex"]
            sub       := rule["sub"]
            reduceFnc := rule["fnc"]
            children  := Object()

            if (RegExMatch(symbolStack, "OSi)(" . regex . ")$", match)) {
                ; Replace matching symbols with %sub%
                symbolStack := RegExReplace(symbolStack, "Si)(" . regex . ")$", sub)

                ; Extract tokens from return stack
                Loop % match.Len(1) {
                    children.insert(ret[ret.MaxIndex()])
                    ret.Remove()
                }

                ; Reverse array to get original order
                children := this._reverseArray(children)

                ; Get new token
                newToken := this[reduceFnc](children)

                if (newToken != "") {
                    ; By using MaxIndex we will get an empty index ("") in the end
                    ret[ret.MaxIndex()+1] := newToken
                }

                break
            }
        }
    }

    _reduce_object(children) {
        ret := Object()
        return ret
    }

    _reduce_array(children) {
        ret := Array()

        if (children.MaxIndex() > 2) {
            for key,value in children {
                if (mod(key, 2) == 0) {
                    ret.insert(value)
                }
            }
        }

        return ret
    }

    _reverseArray(arr) {
        ret      := Array()
        newIndex := arr.MaxIndex()

        for key,value in arr {
            ret[newIndex] := value
            newIndex--
        }

        return ret
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
