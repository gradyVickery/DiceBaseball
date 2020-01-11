//
//  Team.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/10/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import Foundation

struct Team {
   
    var name: String
    var players: [Player]

    init(name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
}
