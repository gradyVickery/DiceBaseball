//
//  League.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/10/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import Foundation

public struct League {
    
    let teams = [
        Team(name: "Braves", players: [
            Player(firstName: "John", lastName: "Smith", number: 10, position: .centerfield, hitterType: .Average),
            Player(firstName: "Bob", lastName: "Todd", number: 3, position: .secondbase, hitterType: .Average),
            Player(firstName: "Ted", lastName: "Rodgers", number: 24, position: .shortstop, hitterType: .Average),
            Player(firstName: "Zork", lastName: "Zoren", number: 7, position: .rightfield, hitterType: .Average),
            Player(firstName: "Ronny", lastName: "Donny", number: 9, position: .firstbase, hitterType: .Average),
            Player(firstName: "Ricky", lastName: "Rey", number: 11, position: .leftfield, hitterType: .Average),
            Player(firstName: "Chad", lastName: "Barn", number: 8, position: .thirdbase, hitterType: .Average),
            Player(firstName: "Dave", lastName: "Lake", number: 31, position: .catcher, hitterType: .Average),
            Player(firstName: "Benny", lastName: "Davis", number: 43, position: .pitcher, hitterType: .Average),
        ]),
        
        
        Team(name: "Tigers", players: [
            Player(firstName: "Kurt", lastName: "Switzer", number: 19, position: .centerfield, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 17, position: .secondbase, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 19, position: .rightfield, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 10, position: .firstbase, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 53, position: .shortstop, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 5, position: .thirdbase, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 33, position: .leftfield, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 29, position: .catcher, hitterType: .Average),
            Player(firstName: "Kurt", lastName: "Switzer", number: 1, position: .pitcher, hitterType: .Average),
        ])
    ]

}

