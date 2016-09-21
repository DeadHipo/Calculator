//
//  Equation.swift
//  calculator
//
//  Created by  NearlyDeadHipo on 20.09.16.
//  Copyright © 2016  NearlyDeadHipo. All rights reserved.
//

import Foundation


class Equation {
    
    var expression: NSExpression? = nil
    
    var result: Double = 0.0
    var equation: String = ""
    
    typealias ResultHandle = (_ result: Double) -> Void
    var resultHandle: ResultHandle?

    fileprivate func calculate() {

        expression = NSExpression(format: "( 2 + 2 ) ** ", argumentArray: [])
        
        if let a = expression?.expressionValue(with: nil, context: nil) {
            print(a)
        }
        //resultHandle?(result)
    }
    
    public func append(lexem: String) {
        
        
        calculate()
    }
}
