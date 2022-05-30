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
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    // MARK: - Properties
    
    let arithmetic: Arithmetic = Arithmetic()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allClear()
    }
    
    // MARK: - Actions
    
    private func allClear() {
        calculationTextView.text = "0"
        arithmetic.calculationDisplayArea = "0"
        operatorButtonsDefaultColor()
    }
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        allClear()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        arithmetic.addNumberTyped(numberText)
        calculationTextView.text = arithmetic.calculationDisplayArea
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard arithmetic.canAddOperator else {
            return operandAlreadySetAlert()
        }
        operatorButtonsDefaultColor()
        sender.isSelected = true
        sender.backgroundColor = .white
        sender.setTitleColor(UIColor(named: "Orange"), for: .selected)
        arithmetic.addOperandTyped(sender)
        calculationTextView.text = arithmetic.calculationDisplayArea
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard arithmetic.expressionIsCorrect else {
           return incorrectExpressionAlert()
        }
        guard arithmetic.expressionHaveEnoughElement else {
            return incompleteCalculationAlert()
        }
        operatorButtonsDefaultColor()
        calculationTextView.text = arithmetic.displayResult()
    }
    
    @IBAction func tappedPercentButton(_ sender: UIButton) {
        guard arithmetic.expressionIsCorrect else {
           return incorrectExpressionAlert()
        }
        guard arithmetic.canAddOperator else {
            return operandAlreadySetAlert()
        }
//        calculationTextView.text = arithmetic.displayPercent()
    }
    
    @IBAction func tappedRelativeNumber(_ sender: UIButton) {
    }
    
    // MARK: - AlertController functions
    
    func operandAlreadySetAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Operator already set", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func incorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Incorrect expression", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func incompleteCalculationAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Incomplete calculation !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Other functions
    
    private func operatorButtonsDefaultColor() {
        operatorButtons.forEach { $0.isSelected = false }
        operatorButtons.forEach { $0.backgroundColor = UIColor(named: "Orange")}
        operatorButtons.forEach { $0.setTitleColor(.white, for: .normal)}
    }
    
}

