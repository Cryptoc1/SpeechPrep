//
//  Parser.swift
//  SpeechPrep
//
//  Created by Cryptoc1 on 5/22/15.
//  Copyright (c) 2015 Cryptocosm Developers. All rights reserved.
//
//  This file declares the Parser class. It's used to break done user inputted text into a formatted array that SpeechPrepRecognizer(NSSpeechRecognizer)
//  and SP
//

import Cocoa

class Parser {
    
    let defaultText: String = "Hello World! Welcome to SpeechPrep, an app designed to help you prepare for speeches and presentations. They say that one of the best ways to prepare for presentations is to read/hear them outloud to yourself. That's the idea behind SpeechPrep!"
    var text: Array<String>?
    
    init(text: String?) {
        self.setText(text!)
    }
    
    func makeTextFromString(string: String) -> Array<String> {
        return string.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString("\r", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).componentsSeparatedByString(". ")
    }
    
    func setText(text: String) {
        self.text = self.makeTextFromString(text)
    }
    
    func getText() -> Array<String> {
        return self.text!
    }
    
    func getDefaultText() -> String {
        return self.defaultText
    }
    
    func getDefaultTextAsArray() -> Array<String> {
        return self.makeTextFromString(self.defaultText)
    }
}