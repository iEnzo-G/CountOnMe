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
    
    // MARK: - Properties
    
    let arithmetic: Arithmetic = Arithmetic()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arithmetic.delegate = self
        
        calculationTextView.addGestureRecognizer(swipeGesture(for: .left))
        calculationTextView.addGestureRecognizer(swipeGesture(for: .right))
    }
    
    // MARK: - Actions
    
    /// Use a swipe to remove the last button tapped on the calculation.
    private func swipeGesture(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(removeLastString))
        swipeGesture.direction = direction
        return swipeGesture
    }
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        arithmetic.clearCalculation()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        arithmetic.addTappedNumber(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let titleButton = sender.title(for: .normal) else { return }
        arithmetic.addTappedOperand(titleButton)
    }
    
    @objc func removeLastString() {
        arithmetic.removeLastString()
    }
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        arithmetic.displayResult()
    }
    
    @IBAction func tappedPercentButton(_ sender: UIButton) {
        arithmetic.displayPercent()
    }
    
    @IBAction func tappedDotButton(_ sender: UIButton) {
        arithmetic.addDot()
    }
    
}
// MARK: - Extension

extension ViewController: UpdateDelegate {
    func throwAlert(message: String) {
        showAlert(message: message)
    }
    
    func updateScreen(calculText: String) {
        calculationTextView.text = calculText
    }
}
