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
        leftDiceImage.alpha = 0
        rightDiceImage.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Prep for dice animation

    }
    

    @IBAction func rollTapped(_ sender: Any) {
        let rollArray = rollDice()
        
        leftDiceImage.image = UIImage(named: "Dice\(rollArray[0])")
        rightDiceImage.image = UIImage(named: "Dice\(rollArray[1])")
        
        leftDiceImage.center.x -= 50
        rightDiceImage.center.x += 50
        leftDiceImage.center.y += 300
        rightDiceImage.center.y += 300
        leftDiceImage.alpha = 1
        rightDiceImage.alpha = 1
        
        
        //animate dice in
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.leftDiceImage.center.x += 50
            self.rightDiceImage.center.x -= 50
            self.leftDiceImage.center.y -= 300
            self.rightDiceImage.center.y -= 300
        }, completion: nil)
        
    }
    
    // segue to player card
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowPlayer" {
            let controller = segue.destination as! BaseballCardViewController
            controller.currentBatter = currentBatter
         }
     }
    
   
}

