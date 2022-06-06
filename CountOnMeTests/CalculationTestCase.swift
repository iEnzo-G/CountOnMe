//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Enzo Gammino on 02/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationTestCase: XCTestCase {
    
    // MARK: - Methods
    
    func setCalculation(_ first: String, _ operand: String, _ second: String, result: String) {
        let sut = Arithmetic()
        sut.addNumberTyped(first)
        sut.addOperandTyped(operand)
        sut.addNumberTyped(second)
        sut.displayResult()
        XCTAssertEqual(sut.calculText, result)
    }
    
    func tappedOperandFirst(_ firstOperand: String, _ firstNumber: String, _ secondOperand: String, _ secondNumber: String, _ result: String) {
        let sut = Arithmetic()
        sut.addOperandTyped(firstOperand)
        sut.addNumberTyped(firstNumber)
        sut.addOperandTyped(secondOperand)
        sut.addNumberTyped(secondNumber)
        sut.displayResult()
        XCTAssertEqual(sut.calculText, result)
    }

    // MARK: - Tests functions
    
    func test_GivenAddtition_WhenTappedOnEqualButton_ThenResultIsCorrect(){
        setCalculation("6", "+", "2", result: "8")
    }
    
    func test_GivenTappedOperandPlusFirst_WhenTappedOnEqualButton_ThenResultIsCorrect() {
        tappedOperandFirst("+", "6", "-", "2", "4")
    }
    
    func test_GivenTappedOperandMinusFirst_WhenTappedOnEqualButton_ThenResultIsCorrect() {
        tappedOperandFirst("-", "6", "+", "10", "4")
    }
    
    func test_GivenSubstraction_WhenTappedOnEqualButton_ThenResultIsCorrect(){
        setCalculation("6", "-", "2", result: "4")
    }
    
    func test_GivenCalculation_WhenTappedOnEqualButton_ThenResultIsNegative() {
        setCalculation("3", "-", "10", result: "-7")
    }

    func test_GivenIncompleteAddition_WhenTappedOnEqualButton_ThenShowAlert(){
        let sut = Arithmetic()
        sut.addNumberTyped("6")
        sut.displayResult()
        XCTAssert(sut.delegate?.throwAlert(message: "Incomplete calculation."))
    }

    func test_GivenIncorrectExpression_WhenTappedOnEqualButton_ThenShowAlert(){
        let sut = Arithmetic()
        sut.addNumberTyped("6")
        sut.addOperandTyped("+")
        sut.displayResult()
        XCTAssert(sut.delegate?.throwAlert(message: "Please enter a correct expression."))
    }

    func test_GivenExpression_WhenTappedSuccesivelyTwoOperand_ThenShowAlert(){
        let sut = Arithmetic()
        sut.addNumberTyped("6")
        sut.addOperandTyped("+")
        sut.addOperandTyped("x")
        XCTAssert(sut.delegate?.throwAlert(message: "Operator already set."))
    }

    
    
    func test_GivenMultiplication_WhenTappedOnEqualButton_ThenResultIsCorrect(){
        setCalculation("6", "x", "2", result: "12")
    }
    
    func test_GivenDivision_WhenTappedOnEqualButton_ThenResultIsCorrect(){
        setCalculation("6", "÷", "2", result: "3")
    }
    
    func test_GivenDivision_WhenTryToDivideByZero_ThenShowErrorMessage() {
        setCalculation("6", "÷", "0", result: "Error")
    }
    
    func test_GivenCalculationAreaIsNotEmpty_WhenTappedOnAllClearButton_ThenCalculIsEqualToZero() {
        let sut = Arithmetic()
        sut.addNumberTyped("6")
        sut.addOperandTyped("x")
        sut.addNumberTyped("2")
        sut.clearCalculation()
        XCTAssertEqual(sut.calculText, "0")
    }
}
