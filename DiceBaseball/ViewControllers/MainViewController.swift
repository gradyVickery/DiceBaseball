//
//  ViewController.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/8/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var league = League()
    let awayTeam: Team
    let homeTeam: Team
    var currentBatter: Player
    var inningHalf = "top"
    
    @IBOutlet weak var leftDiceImage: UIImageView!
    @IBOutlet weak var rightDiceImage: UIImageView!
    
    
    required init?(coder: NSCoder) {
        self.awayTeam = league.teams[0]
        self.homeTeam = league.teams[1]
        self.currentBatter = awayTeam.players[0]
        super.init(coder: coder)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        league.assignTeamNames()
    }

    @IBAction func rollTapped(_ sender: Any) {
        let rollArray = rollDice()
        
        leftDiceImage.image = UIImage(named: "Dice\(rollArray[0])")
        rightDiceImage.image = UIImage(named: "Dice\(rollArray[1])")
    }
    
    // segue to player card
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowPlayer" {
            let controller = segue.destination as! BaseballCardViewController
            controller.currentBatter = currentBatter
         }
     }
    
   
}

