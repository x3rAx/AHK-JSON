/*!
    Library: JSON, v0.0.1
        JSON library for AutoHotkey
    Author: ^x3ro (Björn Richter) <mail [at] x3ro [dot] net>
    License:
*/
class JSON {

    /*
        Function: __NEew()
            (Constructor) Prevents the class from being initialized by throwing an error
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
            Object  - The resulting object
    */
    parse(jsonString) {
        ret := Object()
        len := StrLen(jsonString)
        pos := 1

        regexps := Array(""
            . "(\{)"
            , "(\})"
            , "(\[)"
            , "(\])"
            , """(.*?)"""
            , "(,)"
        . "")

        while (pos <= len) {
            posBefore := pos

            for key,regexp in regexps {
                RegExMatch(jsonString, "OSi)(" . regexp . ")", match, pos)

                if (match.Pos(1) == pos) {
                    if (RegExMatch(match.Value(1), "OSi)""(.*?)""", strMatch)) {
                        ret.insert(strMatch.Value(1))
                    }

                    pos += match.Len(1)

                    continue
                }
            }

            if (pos == posBefore) {
                return false
            }
        }
        
        return ret
    }

}
