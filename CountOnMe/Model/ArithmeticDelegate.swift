//
//  ArithmeticDelegate.swift
//  CountOnMe
//
//  Created by Enzo Gammino on 02/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ArithmeticDelegate: Arithmetic {
    func showAlert()
    func actualizeCalculationTextView()
}