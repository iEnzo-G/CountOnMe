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
    
    let formatter = NumberFormatter()
    
    var delegate: ArithmeticDelegate?
    var calculText: String = "" {
        didSet {
            delegate?.updateScreen(calculText: calculText)
        }
    }
    private var operationsToReduce: [String] = []
    
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
    
    private func numberFormatter() {
            formatter.numberStyle = .none
            formatter.maximumFractionDigits = 2
    }
    
    func clearCalculation() {
        calculText = "0"
    }
    
    func addTappedNumber(_ number: String) {
        if expressionHaveResult {
            calculText = ""
        }
        if calculText == "0" || calculText == "Error" {
            calculText.removeAll()
        }
        calculText.append(number)
    }
    
    func addTappedOperand(_ operand: String) {
        if calculText == "Error" {
            delegate?.throwAlert(message: "Tap a number at first.")
            clearCalculation()
            return
        }
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
    
    func addDot() {
        if !expressionIsCorrect {
            calculText.append("0")
        }
        if calculText == "" {
            calculText = "0"
        }
        guard let lastString = elements.last else { return }
        guard !lastString.contains(".") else { return }
       
        calculText.append(".")
        }
    
    func removeLastString() {
        if calculText != "0" && calculText != "" {
            if expressionIsCorrect {
                calculText.removeLast()
            } else {
                for _ in 0 ... 2 {
                    calculText.removeLast()
                }
            }
        }
        if calculText == "" {
            calculText = "0"
        }
    }
    /// The function detect if there are calculation priorities by sending back the operand index.
    private func hasCalculPriority() -> Int? {
        for (index, sign) in elements.enumerated() {
            if sign == "x" || sign == "÷" {
                return index
            }
        }
        return nil
    }
    
    /// If hasCalculPriority is not nil, the function execut calculation priorities at first before the calculation's rest.
    private func calculPriorityOperation() {
        while hasCalculPriority() != nil {
            guard let operandIndex = hasCalculPriority() else { return }
            calculOperation(leftIndex: operandIndex - 1, operandIndex: operandIndex, rightIndex: operandIndex + 1)
        }
    }
    
    private func replacePriorityOperationByResult(_ indexOperand: Int) {
        for _ in 0 ... 2 {
            operationsToReduce.remove(at: indexOperand)
        }
    }
    
    private func calculOperation(leftIndex: Int, operandIndex: Int,  rightIndex: Int) {
        
            guard let left = Double(operationsToReduce[leftIndex]) else { return }
            let operand = operationsToReduce[operandIndex]
            guard let right = Double(operationsToReduce[rightIndex]) else { return }
            
            if operand == "÷" && right == 0 {
                calculText = "Error"
                return
            }
            
        var calcul: Double = 0
            switch operand {
            case "+": calcul = left + right
            case "-": calcul = left - right
            case "÷": calcul = left / right
            case "x": calcul = left * right
            default: break
            }
        numberFormatter()
        guard let result = formatter.string(from: NSNumber(value: calcul)) else { return }
            replacePriorityOperationByResult(operandIndex - 1)
            operationsToReduce.insert("\(result)", at: operandIndex - 1)
        calculText = "\(operationsToReduce.first!)"
    }
    
    func displayResult(){
        guard expressionIsCorrect else {
            delegate?.throwAlert(message: "Please enter a correct expression.")
            return  }
        guard expressionHaveEnoughElement else {
            delegate?.throwAlert(message: "Incomplete calculation.")
            return  }
        
        operationsToReduce = elements
        calculPriorityOperation()
        if operationsToReduce.count > 2 {
        calculOperation( leftIndex: 0, operandIndex: 1, rightIndex: 2)
        }
    }
    
    func displayPercent() {
        guard expressionIsCorrect else{
            delegate?.throwAlert(message: "Please enter a correct expression.")
            return  }
        if expressionHaveEnoughElement {
            displayResult()
        }
        var operationsToPercent = elements
        guard let number = Float(operationsToPercent[0]) else { return }
        
        numberFormatter()
        guard let result = formatter.string(from: NSNumber(value: number * 0.01)) else { return }
        
        operationsToPercent = Array(operationsToPercent.dropFirst(3))
        operationsToPercent.insert("\(result)", at: 0)
        calculText = "\(operationsToPercent.first!)"
    }
}
