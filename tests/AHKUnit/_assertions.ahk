assertEquals(expected, actual) {
    if (expected == actual) {
        return true
    } else {
        fail()
    }
}

assertTrue(actual) {
    if (actual == true) {
        return true
    } else {
        fail()
    }
}

assertFalse(actual) {
    if (actual == false) {
        return true
    } else {
        fail()
    }
}
