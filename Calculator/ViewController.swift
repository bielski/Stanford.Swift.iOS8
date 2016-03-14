//
//  ViewController.swift
//  Calculator
//
//  Created by Ewa Bielska on 11/03/16.
//  Copyright © 2016 Allegro Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTyping = false
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTyping {
            if digit == "." && (display.text!.rangeOfString(digit) != nil) {
                return
            }
            display.text = display.text! + digit

        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }

    @IBAction func appendConstant(sender: AnyObject) {
        display.text = "\(M_PI)"
        enter()
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }

    @IBAction func clear(sender: AnyObject) {
        brain.clearOpStack()
        displayValue = 0
    }

    @IBAction func backspace() {
        if userIsInTheMiddleOfTyping {
            display.text = String(display.text!.characters.dropLast())
        }
    }

    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            enter()
        }

        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
}
