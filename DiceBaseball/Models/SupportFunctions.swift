//
//  SupportFunctions.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/10/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import Foundation

    func rollDice() -> [Int] {
        var leftDiceRoll = Int.random(in: 1...6)
        var rightDiceRoll = Int.random(in: 1...6)
               
        // leftDice should be equal or less than right
        if leftDiceRoll > rightDiceRoll {
            let diceTemp = leftDiceRoll
            leftDiceRoll = rightDiceRoll
            rightDiceRoll = diceTemp
        }
        return [leftDiceRoll, rightDiceRoll]
    }

    func delay(_ seconds: Double, completion: @escaping ()->Void) {
           DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
       }

