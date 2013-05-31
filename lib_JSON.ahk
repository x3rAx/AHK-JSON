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

        array_regex := "\[""(.*?)""\]"

        if (RegExMatch(jsonString, "Si)" . array_regex, match_)) {
            ret.Insert(match_1)
        }
        
        return ret
    }

}
