//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    // MARK: - Properties
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
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
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        textView.text = "0"
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        operatorButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        operatorButtons.forEach { $0.backgroundColor = UIColor(named: "Orange")}
        operatorButtons.forEach { $0.setTitleColor(.white, for: .normal)}
        sender.backgroundColor = .white
        sender.setTitleColor(UIColor(named: "Orange"), for: .selected)
        var addOperator = ""
        switch sender.tag {
        case 0: addOperator = " + "
        case 1: addOperator = " - "
        case 2: addOperator = " ÷ "
        case 3: addOperator = " x "
        default: break
        }
        if canAddOperator {
            textView.text.append(addOperator)
        } else {
            let alertVC = UIAlertController(title: "Error", message: "Operator already set", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Error", message: "Incorrect expression", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Error", message: "Incomplete calculation !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        operatorButtons.forEach { $0.isSelected = false }
        operatorButtons.forEach { $0.backgroundColor = UIColor(named: "Orange")}
        operatorButtons.forEach { $0.setTitleColor(.white, for: .normal)}
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
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
        
        textView.text = "\(operationsToReduce.first!)"
    }

}

