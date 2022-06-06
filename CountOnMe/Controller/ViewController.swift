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
        arithmetic.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        arithmetic.clearCalculation()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        arithmetic.addNumberTyped(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let titleButton = sender.title(for: .normal) else { return }
        arithmetic.addOperandTyped(titleButton)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        arithmetic.displayResult()
    }
    
    @IBAction func tappedPercentButton(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedRelativeNumber(_ sender: UIButton) {
    }
}
// MARK: - Extension

extension ViewController: ArithmeticDelegate {
    func throwAlert(message: String) {
        showAlert(message: message)
    }
    
    func updateScreen(calculText: String) {
        calculationTextView.text = calculText
    }
}

