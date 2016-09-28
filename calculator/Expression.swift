//
//  Expression.swift
//  calculator
//
//  Created by  NearlyDeadHipo on 28.09.16.
//  Copyright © 2016  NearlyDeadHipo. All rights reserved.
//

import Foundation

enum CalculateError: Error {
    case DevisionByZero
    case ParseError
}

protocol Operator {
    var priority: Int { get }
    func value(numbers: [Double]) -> Double
}

class Expression {
    
    typealias ResultHandle = (_ result: Double?, _ error: CalculateError?) -> Void
    var resultHandle: ResultHandle?
    
    let possibleOperators: [Character: Operator] =
    [
            "^": Power(),
            "×": Multiplication(),
            "÷": Devision(),
            "+": Plus(),
            "-": Minus()
    ]
    
    var expression: String = ""
    
    init(from: String) {
        self.expression = from
    }
    
    public func append(lexem: String) {
        expression += lexem
        evaluate()
    }
    
    public func removeLast() {
        expression = expression.substring(to: expression.index(expression.endIndex, offsetBy: -1))
        evaluate()
    }
    
    public func clear() {
        expression = ""
        evaluate()
    }
    
    fileprivate func evaluate() {
        do {
            let parseResult = try parse(expression: self.expression)
            let result = try calculateWith(operators: parseResult.operators, nubmers: parseResult.numbers)
            resultHandle?(result, nil)
        } catch _{
            resultHandle?(nil, CalculateError.ParseError)
        }
    }
    
    fileprivate func parse(expression: String) throws -> (operators: [Operator], numbers: [Double]) {
        
        var operators = [Operator]()
        var nubmers = [Double]()
        
        var buffer: String = ""
        var negation: Bool = false
        var lastIsNumber: Bool = false
        
        for index in expression.characters.indices {
            let character = expression[index]
            
            if (index == expression.startIndex && character == "-") {
                negation = true
                continue
            }
            
            
            if (character.isNumber) {
                buffer += String(character)
                lastIsNumber = true
            } else {
                if (lastIsNumber) {
                    guard let number = Double(buffer) else { throw CalculateError.ParseError }
                    nubmers.append((negation) ? number * -1.0 : number)
                    
                    buffer = ""
                    negation = false
                    
                    if let operation = possibleOperators[character] {
                        operators.append(operation)
                        lastIsNumber = false
                    } else {
                        throw CalculateError.ParseError
                    }
                } else {
                    if (character == "-") {
                        guard nubmers.count > 0 else { throw CalculateError.ParseError }
                        lastIsNumber = true
                        negation = true
                    } else {
                        throw CalculateError.ParseError
                    }
                }
            }
        }
        
        if (buffer.isEmpty) { throw CalculateError.ParseError }
        
        guard let number = Double(buffer) else { throw CalculateError.ParseError }
        nubmers.append((negation) ? number * -1.0 : number)
        
        return (operators: operators, numbers: nubmers)
    }
    
    fileprivate func calculateWith(operators op: [Operator], nubmers num: [Double]) throws -> Double {
        var operators = op
        var numbers = num
        
        while operators.count > 0 {
            var maxPriority = 0
            for operation in operators {
                maxPriority = (maxPriority < operation.priority) ? operation.priority : maxPriority
            }
            
            main: for index in 0...operators.count {
                if (operators[index].priority == maxPriority) {
                    if (operators[index].priority == Devision().priority) {
                        if (numbers[index + 1] == 0.0) { throw CalculateError.DevisionByZero }
                    }
                    
                    let value = operators[index].value(numbers: [numbers[index], numbers[index + 1]])
                    numbers[index] = value
                    numbers.remove(at: index + 1)
                    operators.remove(at: index)
                    break main
                }
            }
        }
        
        return numbers[0]
    }
}

// MARK: - Operators define
extension Expression {
    
    struct Power: Operator {
        var priority: Int = 2
        func value(numbers: [Double]) -> Double {
            return pow(numbers[0], numbers[1])
        }
    }
    
    struct Multiplication: Operator {
        var priority: Int = 1
        func value(numbers: [Double]) -> Double {
            return numbers[0] * numbers[1]
        }
    }
    
    struct Devision: Operator {
        var priority: Int = 1
        func value(numbers: [Double]) -> Double {
            return numbers[0] / numbers[1]
        }
    }
    
    struct Plus: Operator {
        var priority: Int = 0
        func value(numbers: [Double]) -> Double {
            return numbers[0] + numbers[1]
        }
    }
    
    struct Minus: Operator {
        var priority: Int = 0
        func value(numbers: [Double]) -> Double {
            return numbers[0] - numbers[1]
        }
    }
    
}
