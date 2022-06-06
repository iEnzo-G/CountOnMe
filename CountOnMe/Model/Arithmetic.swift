//
//  Arithmetic.swift
//  CountOnMe
//
//  Created by Enzo Gammino on 26/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Arithmetic {
    
    // MARK: - Properties
    
    var delegate: ArithmeticDelegate?
    var calculText: String = "0" {
        didSet {
            delegate?.updateScreen(calculText: calculText)
        }
    }
    
    private var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    private var expressionHaveResult: Bool {
        return calculText.firstIndex(of: "=") != nil
    }
    
    // MARK: - Calculation functions
    
    func clearCalculation() {
        calculText = "0"
    }
    
    func addNumberTyped(_ number: String) {
        if expressionHaveResult {
            calculText = ""
        }
        if calculText == "0" {
            calculText.removeAll()
        }
        calculText.append(number)
    }
    
    func addOperandTyped(_ operand: String) {
        
        if canAddOperator {
            switch operand {
            case "+": calculText.append(" + ")
            case "-": calculText.append(" - ")
            case "x": calculText.append(" x ")
            case "÷": calculText.append(" ÷ ")
            default: break
            }
        } else {
            delegate?.throwAlert(message: "Operator already set.")
        }
    }
    
    func displayResult() -> ()? {
        guard expressionIsCorrect else {
            return delegate?.throwAlert(message: "Please enter a correct expression.") }
       guard expressionHaveEnoughElement else {
           return delegate?.throwAlert(message: "Incomplete calculation.") }
        
        var operationsToReduce = elements
        
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                calculText = "Error"
                break
            }
            
            var result = 0
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "x": result = left * right
            default: break
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        calculText = "\(operationsToReduce.first!)"
    }
    
    func displayPercent() {
        var operationsToPercent = elements
        let number = Float(operationsToPercent[0])!
        
        let result = number * 0.01
        operationsToPercent = Array(operationsToPercent.dropFirst(3))
        operationsToPercent.insert("\(result)", at: 0)
        calculText = "\(operationsToPercent.first!)"
    }
    
}
