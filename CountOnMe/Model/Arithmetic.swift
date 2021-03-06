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
    
    weak var delegate: UpdateDelegate?
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
    
    private var expressionHaveResult: Bool = false
    
    // MARK: - Calculation functions
    
    private func initCalculText() {
        if calculText == "" {
            calculText = "0"
        }
    }
    
    private func numberFormatter() {
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 2
    }
    
    func clearCalculation() {
        calculText = "0"
    }
    
    func addTappedNumber(_ number: String) {
        if expressionHaveResult {
            expressionHaveResult = false
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
            return
        }
        expressionHaveResult = false
        initCalculText()
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
        initCalculText()
        guard let lastString = elements.last else { return }
        guard !lastString.contains(".") else { return }
        
        calculText.append(".")
    }
    
    /// Function allows user to go back in the calculation.
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
        initCalculText()
    }
    /// The function detect if there are calculation priorities by sending back the operand index.
    private func indexPriority() -> Int? {
        for (index, sign) in elements.enumerated() {
            if sign == "x" || sign == "÷" {
                return index
            }
        }
        return nil
    }
    
    /// If hasCalculPriority is not nil, the function execut calculation priorities at first before the calculation's rest.
    private func calculPriorityOperation() {
        while indexPriority() != nil {
            guard let operandIndex = indexPriority() else { return }
            calculOperation(leftIndex: operandIndex - 1, operandIndex: operandIndex, rightIndex: operandIndex + 1)
        }
    }
    
    /// Function to remove priority calculation from the operation.
    private func replacePriorityOperationByResult(_ indexOperand: Int) {
        for _ in 0 ... 2 {
            operationsToReduce.remove(at: indexOperand)
        }
    }
    
    /// Main function for all calcul.
    private func calculOperation(leftIndex: Int, operandIndex: Int,  rightIndex: Int) {
        
        guard let left = Double(operationsToReduce[leftIndex]) else { return }
        let operand = operationsToReduce[operandIndex]
        guard let right = Double(operationsToReduce[rightIndex]) else { return }
        
        if operand == "÷" && right == 0 {
            operationsToReduce.removeAll()
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
        guard let result = formatter.string(for: calcul) else { return }
        replacePriorityOperationByResult(operandIndex - 1)
        operationsToReduce.insert("\(result)", at: operandIndex - 1)
        calculText = "\(operationsToReduce.first!)"
    }
    
    /// Function start the calcul
    func displayResult() {
        guard expressionIsCorrect else {
            delegate?.throwAlert(message: "Please enter a correct expression.")
            return  }
        guard expressionHaveEnoughElement else {
            delegate?.throwAlert(message: "Incomplete calculation.")
            return  }
        
        operationsToReduce = elements
        calculPriorityOperation()
        while operationsToReduce.count >= 3 {
            calculOperation( leftIndex: 0, operandIndex: 1, rightIndex: 2)
        }
        expressionHaveResult = true
    }
    
    /// Basic function to insert the percentage operations.
    func displayPercent() {
        guard expressionIsCorrect else{
            delegate?.throwAlert(message: "Please enter a correct expression.")
            return  }
        guard elements.count <= 3 else{
            delegate?.throwAlert(message: "Percentage result is only for basic expression.")
            return  }
        var operationsToPercent = elements
        if operationsToPercent.count == 1 {
            guard let number = Double(operationsToPercent[0]) else { return }
            calculText = "\(number * 0.01)"
            return
        }
        
        guard let left = Double(operationsToPercent[operationsToPercent.count - 3]) else { return }
        let operand = operationsToPercent[operationsToPercent.count - 2]
        guard let right = Double(operationsToPercent[operationsToPercent.count - 1]) else { return }
        
        if operand == "÷" && right == 0 {
            operationsToPercent.removeAll()
            calculText = "Error"
            return
        }
        
        var calcul: Double = left / 100 * right
        if operand == "x" || operand == "÷" {
            calcul = right / 100
        }
        numberFormatter()
        guard let result = formatter.string(for: calcul) else { return }
        guard let sizeString = elements.last?.count else { return }
        for _ in 0 ..< sizeString {
            calculText.removeLast()
        }
        calculText.append(result)
        if expressionHaveEnoughElement {
            displayResult()
        }
    }
}
