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
    
    var calculationDelegate: ArithmeticDelegate?
    var calculationDisplayArea: String = "0"
    
    private var elements: [String] {
        return calculationDisplayArea.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }
    
    private var expressionHaveResult: Bool {
        return calculationDisplayArea.firstIndex(of: "=") != nil
    }
    
    // MARK: - Calculation functions
    
    func clearCalculation() {
        calculationDisplayArea = "0"
    }
    
    func addNumberTyped(_ number: String) {
        if expressionHaveResult {
            calculationDisplayArea = ""
        }
        calculationDisplayArea.append(number)
    }
    
    func addOperandTyped(_ operandButton: String) {
        if canAddOperator {
            calculationDisplayArea.append(operandButton)
        } else {
            
        }
    }
    
    func displayResult() -> String {
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            if operand == "÷" && right == 0 {
                return "Error"
            }
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "÷": result = left / right
            case "x": result = left * right
            default: fatalError("Unknown operator !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        calculationDisplayArea = "\(operationsToReduce.first!)"
        return calculationDisplayArea
    }
    
//    func displayPercent() -> String {
//        var operationsToPercent = elements
//        let number = Float(operationsToPercent[0])!
//
//        let result = number * 0.01
//        operationsToPercent = Array(operationsToPercent.dropFirst(3))
//        operationsToPercent.insert("\(result)", at: 0)
//        calculationDisplayArea = "\(operationsToPercent.first!)"
//        return calculationDisplayArea
//    }
    
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
