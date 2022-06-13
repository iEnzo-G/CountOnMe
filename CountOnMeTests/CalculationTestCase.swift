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
        sut.addTappedNumber(first)
        sut.addTappedOperand(operand)
        sut.addTappedNumber(second)
        sut.displayResult()
        XCTAssertEqual(sut.calculText, result)
    }
    
    func tappedOperandFirst(_ firstOperand: String, _ firstNumber: String, _ secondOperand: String, _ secondNumber: String, _ result: String) {
        let sut = Arithmetic()
        sut.addTappedOperand(firstOperand)
        sut.addTappedNumber(firstNumber)
        sut.addTappedOperand(secondOperand)
        sut.addTappedNumber(secondNumber)
        sut.displayResult()
        XCTAssertEqual(sut.calculText, result)
    }

    // MARK: - Tests functions
    
    func test_GivenCalculation_WhenSwipeGesture_ThenRemoveTheLastButtonTapped() {
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("+")
        sut.removeLastString()
        XCTAssertEqual(sut.calculText, "6")
        
    }
    
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
        sut.addTappedNumber("6")
//        XCTAssertTrue(sut.spyAlert())
    }

    func test_GivenIncorrectExpression_WhenTappedOnEqualButton_ThenShowAlert(){
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("+")
//        XCTAssertTrue(sut.spyAlert())
    }

    func test_GivenExpression_WhenTappedSuccesivelyTwoOperand_ThenShowAlert(){
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("+")
        sut.addTappedOperand("6")
//        XCTAssertFalse(sut.spyAlert())
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
        sut.addTappedNumber("6")
        sut.addTappedOperand("x")
        sut.addTappedNumber("2")
        sut.clearCalculation()
        XCTAssertEqual(sut.calculText, "0")
    }

    func test_GivenCalculationWithCalculPriority_WhenTappedOnDisplayResult_ThenCalculIsCorrect() {
        let sut = Arithmetic()
        sut.addTappedNumber("2")
        sut.addTappedOperand("+")
        sut.addTappedNumber("2")
        sut.addTappedOperand("x")
        sut.addTappedNumber("2")
        sut.displayResult()
        XCTAssertEqual(sut.calculText, "6")
    }
    
    func test_GivenMultiplyThenDivide_WhenTappedOnDisplayResult_ThenCalculIsCorrect() {
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("x")
        sut.addTappedNumber("2")
        sut.addTappedOperand("÷")
        sut.addTappedNumber("3")
        sut.displayResult()
        XCTAssertEqual(sut.calculText, "4")
    }
    
    func test_GivenDivideThenMultiply_WhenTappedOnEqualButton_ThenCalculIsCorrect() {
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("÷")
        sut.addTappedNumber("2")
        sut.addTappedOperand("x")
        sut.addTappedNumber("3")
        sut.displayResult()
        XCTAssertEqual(sut.calculText, "9")
    }
    
    func test_GivenNumber_WhenTappedOnPercentButton_ThenCalculIsCorrect() {
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.displayPercent()
        XCTAssertEqual(sut.calculText, "0.06")
    }
    
    func test_GivenCalculation_WhenTappedOnPercentButton_ThenCalculIsCorrect() {
        let sut = Arithmetic()
        sut.addTappedNumber("6")
        sut.addTappedOperand("x")
        sut.addTappedNumber("3")
        sut.displayPercent()
        XCTAssertEqual(sut.calculText, "0.18")
    }
}
