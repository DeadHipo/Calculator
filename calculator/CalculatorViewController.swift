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
        buttonClickWithTag(tag: sender.tag)
    }
    
    fileprivate var operations: String = ""
    fileprivate var expression: Equation = Equation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.operationsLabel.text = ""
        self.resultLabel.text = ""
        
        for calculatorButton in self.calculatorButtonsCollection {
            calculatorButton.setBackgroundColor(color: UIColor.white, forState: .highlighted)
        }
        
        expression.resultHandle = { (result: Double) -> Void in
            self.resultLabel.text = String(result)
        }
    }
    
    fileprivate func buttonClickWithTag(tag: Int) {
        switch tag {
        case 0...9:
            operations += String(tag)
        case 10:
            operations += "."
        case 11:
            operations += " + "
        case 12:
            operations += " - "
        case 13:
            operations += " x "
        case 14:
            operations += " ÷ "
        case 15:
            operations += "^"
        case 16:
            operations += "("
        case 17:
            operations += ")"
        case 18:
            operations = operations.substring(to: operations.index(operations.endIndex, offsetBy: -1))
        case 19:
            operations = ""
        default:
            operations += ""
        }
        operationsLabel.text = operations
        expression.calculate(expression: operations.replacingOccurrences(of: " ", with: ""))
    }
    
}

