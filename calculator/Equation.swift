//
//  Equation.swift
//  calculator
//
//  Created by  NearlyDeadHipo on 20.09.16.
//  Copyright © 2016  NearlyDeadHipo. All rights reserved.
//

import Foundation


class Equation {
    var lastResult: Double = 0
    
    typealias ResultHandle = (_ result: Double) -> Void
    var resultHandle: ResultHandle?

    public func calculate(expression: String) {

        let result = evaluateExpression(expression: expression, angleUnit: MathParserAngleUnit.Degrees)
        if let unwrapedResult = result {
            if unwrapedResult == Double.infinity {
                resultHandle?(-unwrapedResult)
                lastResult = 0
            } else if unwrapedResult == -0.0 {
                resultHandle?(-unwrapedResult)
                lastResult = -unwrapedResult
            } else {
                resultHandle?(unwrapedResult)
                lastResult = unwrapedResult
            }
        } else {
            resultHandle?(lastResult)
        }
    }
    
}
