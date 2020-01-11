//
//  DiceResults.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/10/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import Foundation

extension Player {
    enum PlayResults: String {
        case strikeout = "Strikeout"
        case walk = "Walk"
        case single = "Single"
        case double = "Double"
        case triple = "Triple"
        case homerun = "homerun"
    }
    

    
    func getDiceResults(dice1: Int, dice2: Int) -> PlayResults {
        
        switch (dice1, dice2) {
        case (1, 1):
            return .single
        case (1, 2):
            return .single
        case (1, 3):
            return .single
        case (1, 4):
            return .single
        case (1, 5):
            return .single
        case (1, 6):
            return .single
        case (2, 2):
            return .single
        case (2, 3):
            return .single
        case (2, 4):
            return .single
        case (2, 5):
            return .double
        case (2, 6):
            return .single
        case (3, 3):
            return .single
        case (3, 4):
            return .single
        case (3, 5):
            return .single
        case (3, 6):
            return .single
        case (4, 4):
            return .single
        case (4, 5):
            return .single
        case (4, 6):
            return .single
        case (5, 5):
            return .single
        case (5, 6):
            return .triple
        default:
            return .homerun
        }
    }
}
