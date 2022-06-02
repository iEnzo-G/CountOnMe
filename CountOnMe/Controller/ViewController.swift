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
    
    @IBOutlet weak var calculationTextView: UITextView!
    @IBOutlet var operatorButtons: [UIButton]!
    
    // MARK: - Properties
    
    let arithmetic: Arithmetic = Arithmetic()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        arithmetic.clearCalculation()
        operatorButtonsDefaultColor()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        arithmetic.addNumberTyped(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        operatorButtonsDefaultColor()
        sender.isSelected = true
        sender.backgroundColor = .white
        sender.setTitleColor(UIColor(named: "Orange"), for: .selected)
        
        var operand: String
        switch sender.tag {
        case 0: operand = " + "
        case 1: operand = " - "
        case 2: operand = " x "
        case 3: operand = " ÷ "
        default: fatalError("Unknow Operator")
        }
        arithmetic.addOperandTyped(operand)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        operatorButtonsDefaultColor()
    }
    
    @IBAction func tappedPercentButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedRelativeNumber(_ sender: UIButton) {
    }
    
    // MARK: - AlertController functions
    
//    func operandAlreadySetAlert() {
//        let alertVC = UIAlertController(title: "Error", message: "Operator already set", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        self.present(alertVC, animated: true, completion: nil)
//    }
//
//    func incorrectExpressionAlert() {
//        let alertVC = UIAlertController(title: "Error", message: "Incorrect expression", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        return self.present(alertVC, animated: true, completion: nil)
//    }
//
//    func incompleteCalculationAlert() {
//        let alertVC = UIAlertController(title: "Error", message: "Incomplete calculation !", preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        return self.present(alertVC, animated: true, completion: nil)
//    }
    
    // MARK: - Other functions
    
    private func operatorButtonsDefaultColor() {
        operatorButtons.forEach { $0.isSelected = false }
        operatorButtons.forEach { $0.backgroundColor = UIColor(named: "Orange")}
        operatorButtons.forEach { $0.setTitleColor(.white, for: .normal)}
    }
    
}
    
    // MARK: - Extension

//extension ViewController: ArithmeticDelegate {
//    func showAlert() {
//        <#code#>
//    }
//    func actualizeCalculationTextView() {
//        <#code#>
//    }
//}
