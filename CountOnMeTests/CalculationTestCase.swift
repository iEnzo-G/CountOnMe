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
    
    var sut: Arithmetic!
    
    override func setUp() {
        super.setUp()
        sut = Arithmetic()
    }
    
    func setCalculation(calculation: String, result: String) {
        sut.calculationDisplayArea = calculation
        let result = sut.displayResult()
        XCTAssertEqual(result, result)
    }
    
    func test_GivenAddition_WhenCorrectCalculIsPassed(){
        setCalculation(calculation: "6 + 2", result: "8")
    }
    
    func test_GivenSubstraction_WhenCorrectCalculIsPassed(){
        setCalculation(calculation: "6 - 2", result: "4")
    }
    
    func test_GivenMultiplication_WhenCorrectCalculIsPassed(){
        setCalculation(calculation: "6 x 2", result: "12")
    }
    
    func test_GivenDivision_WhenCorrectCalculIsPassed(){
        setCalculation(calculation: "6 ÷ 2", result: "3")
    }
    
    func test_GivenDivision_WhenTryToDivideByZero_ThenShowErrorMessage() {
        setCalculation(calculation: "6 + 0", result: "Error")
    }
    
    func test_GivenCalculationAreaIsNotEmpty_WhenTappedOnAllClearButton_ThenCalculIsEqualToZero() {
        sut.calculationDisplayArea = "6 x 2"
        sut.clearCalculation()
        XCTAssertEqual(sut.calculationDisplayArea, "0")
    }
}
