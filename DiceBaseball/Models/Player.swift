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
        case Power = "Power"
        case Contact = "Contact"
        case Strikeout = "Strikeout"
    }
    enum Position: String {
        case firstbase = "1st"
        case secondbase = "2nd"
        case thirdbase = "3rd"
        case shortstop = "SS"
        case pitcher = "P"
        case catcher = "C"
        case leftfield = "LF"
        case rightfield = "RF"
        case centerfield = "CF"
    }
    
    let firstName: String
    let lastName: String
    let number: Int
    let position: Position
    let hitterType: HitterType
    var teamName: String = ""
    
    init(firstName: String, lastName: String, number: Int, position: Position, hitterType: HitterType) {
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.position = position
        self.hitterType = hitterType
    }
    
}


