//
//  Batter.swift
//  BaseballGame
//
//  Created by Grady Vickery on 3/27/18.
//  Copyright © 2018 Grady Vickery. All rights reserved.
//

import Foundation

public class Player {

    enum HitterType: String {
        case Average = "Average"
        case Power 
        case Contact
        case Strikeout
    }
    enum Position: String {
        case firstbase
        case secondbase
        case thirdbase
        case shortstop
        case pitcher
        case catcher = "Catcher"
        case leftfield
        case rightfield
        case centerfield
    }
    
    let firstName: String
    let lastName: String
    let number: Int
    let position: Position
    let hitterType: HitterType
    
    init(firstName: String, lastName: String, number: Int, position: Position, hitterType: HitterType) {
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.position = position
        self.hitterType = hitterType
    }
    
}

