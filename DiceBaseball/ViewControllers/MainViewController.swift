//
//  ViewController.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/8/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var teams = League.createTeams()
    var awayTeam: Team
    var currentBatter: Player
    
    required init?(coder: NSCoder) {
        self.awayTeam = teams[0]
        self.currentBatter = awayTeam.players[0]
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentBatter.firstName + " " + currentBatter.lastName)
    }

    @IBAction func rollTapped(_ sender: Any) {
        print("tapped")
    }
    
    // segue to player card
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowPlayer" {
            let controller = segue.destination as! BaseballCardViewController
            
            controller.currentBatter = currentBatter
         }
     }
}

