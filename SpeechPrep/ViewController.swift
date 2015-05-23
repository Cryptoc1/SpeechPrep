//
//  ViewController.swift
//  SpeechPrep
//
//  Created by Cryptoc1 on 5/22/15.
//  Copyright (c) 2015 Cryptocosm Developers. All rights reserved.
//

import Cocoa
import AppKit

var DEVMODE : Bool = false

class ViewController: NSViewController, NSSpeechRecognizerDelegate, NSSpeechSynthesizerDelegate {
    
    let parser: Parser = Parser(text: "")
    let sr: SPRecognizer = SPRecognizer()
    let ss: SPSynthesizer = SPSynthesizer.init()
    var currentCommandIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser.setText(parser.getDefaultText())
        
        sr.delegate = self
        sr.commands = [""]
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startPrep(sender: AnyObject) {
        sr.startListening()
        if SPInputTextField.stringValue != "" {
            parser.setText(SPInputTextField.stringValue)
            if DEVMODE {
                NSLog("setText to: \(parser.getText())")
            }
        } else {
            if DEVMODE {
                NSLog("No text submitted, using the default of: \(parser.getDefaultText())")
            }
        }
        
        self.setCommand(parser.getText(), commandIndex: currentCommandIndex)
        if DEVMODE {
            NSLog("Started sr listener")
            NSLog("parser.getText().count: \(parser.getText().count)")
        }
    }
    
    @IBAction func pausePrep(sender: AnyObject) {
        sr.stopListening()
    }

    @IBOutlet weak var SPInputTextField: NSTextField!
    @IBOutlet weak var SPOutputLabel: NSTextFieldCell!
    
    func speechRecognizer(sender: NSSpeechRecognizer, didRecognizeCommand command: AnyObject?) {
        if (command as! String == parser.getText()[currentCommandIndex - 1]) {
            // Sets the next command to be recognized, then increments currentCommandIndex by 1
            self.setCommand(parser.getText(), commandIndex: currentCommandIndex)
            if DEVMODE {
                NSLog("Correct stanza was inputted")
            }
        }
    }
    
    func setCommand(commands: Array<String>, commandIndex: Int) {
        if commandIndex == parser.getText().count {
            sr.commands = []
            SPOutputLabel.title = "You finished the the speech, congrats!"
            self.pausePrep(self)
        } else {
            sr.commands = [commands[commandIndex]]
            SPOutputLabel.title = commands[commandIndex]
            ss.startSpeakingString(commands[commandIndex])
            currentCommandIndex++
        }
        if DEVMODE {
            NSLog("Updated sr.commands to: \"\(sr.commands!)\"")
            NSLog("currentCommandIndex: \(currentCommandIndex)")
        }
    }
}

