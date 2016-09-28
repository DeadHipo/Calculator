//
//  ViewController.swift
//  calculator
//
//  Created by  NearlyDeadHipo on 20.09.16.
//  Copyright © 2016  NearlyDeadHipo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet var calculatorButtonsCollection: [UIButton]!
    
    @IBOutlet weak var operationsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func calculatorButtonTouchInside(_ sender: UIButton) {
        buttonClickWith(tag: sender.tag)
    }
    
    fileprivate var operations: String = ""
    fileprivate var expression: Expression = Expression(from: "")
    fileprivate var lastResult: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operationsLabel.text = ""
        self.resultLabel.text = ""
        
        for calculatorButton in self.calculatorButtonsCollection {
            calculatorButton.setBackgroundColor(color: UIColor.white, forState: .highlighted)
        }
        
        expression.resultHandle = { (result: Double?, error: CalculateError?) -> Void in
            if let result = result {
                self.resultLabel.text = String(result)
            }
        }
    }
    
    fileprivate func buttonClickWith(tag: Int) {
        switch tag {
        case 0...9:
            operations += String(tag)
            expression.append(lexem: String(tag))
        case 10:
            operations += "."
            expression.append(lexem: ".")
        case 11:
            operations += " + "
            expression.append(lexem: "+")
        case 12:
            operations += " - "
            expression.append(lexem: "-")
        case 13:
            operations += " × "
            expression.append(lexem: "×")
        case 14:
            operations += " ÷ "
            expression.append(lexem: "÷")
        case 15:
            operations += "^"
            expression.append(lexem: "^")
        case 16:
            operations += "("
            expression.append(lexem: "(")
        case 17:
            operations += ")"
            expression.append(lexem: ")")
        case 18:
            if (operations == "") { return }
            operations = operations.substring(to: operations.index(operations.endIndex, offsetBy: -1))
            expression.removeLast()
        case 19:
            operations = ""
            expression.clear()
        default:
            operations += ""
        }
        operationsLabel.text = operations
    }
    
}

