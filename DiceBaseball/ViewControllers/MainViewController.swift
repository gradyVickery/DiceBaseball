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
    
    
    var awayBatterIndex = 0
    var homeBatterIndex = 0
    
    var awayTeamScore = 0
    var homeTeamScore = 0
    var inningHalf = "Top"
    var inning = 1
    var outs = 0
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var atBatLabel: UILabel!
    @IBOutlet weak var outsLabel: UILabel!
    @IBOutlet weak var playResultLabel: UILabel!
    @IBOutlet weak var secondaryPlayLabel: UILabel!
    @IBOutlet weak var leftDiceImage: UIImageView!
    @IBOutlet weak var rightDiceImage: UIImageView!
    @IBOutlet weak var fieldImage: UIImageView!
    
    required init?(coder: NSCoder) {
        self.awayTeam = league.teams[0]
        self.homeTeam = league.teams[1]
        self.currentBatter = awayTeam.players[awayBatterIndex]
        super.init(coder: coder)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        league.assignTeamNames()
        leftDiceImage.alpha = 0
        rightDiceImage.alpha = 0
        
        inningLabel.text = inningHalf + " " + String(inning)
        playResultLabel.text = ""
        secondaryPlayLabel.text = ""
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
    }
    
    
    // MARK:- Gameplay
    @IBAction func rollTapped(_ sender: Any) {
 
        playResultLabel.alpha = 1
        secondaryPlayLabel.alpha = 1
        
        let rollArray = rollDice()
        leftDiceImage.image = UIImage(named: "Dice\(rollArray[0])")
        rightDiceImage.image = UIImage(named: "Dice\(rollArray[1])")
        animateDice()
    
        playResultLabel.text = currentBatter.getDiceResults(dice1: rollArray[0], dice2: rollArray[1]).rawValue
        secondaryPlayLabel.text = "Ready for next batter"
        animatePlayLabelsIn()
        
        // TODO:- handle after at bat
        // will need to check outs, inning, team, score before call
        delay(6.0) {
            self.nextBatter()
            self.animatePlayLabelsOut() // Fading out currently
        }
    }
    
    func nextBatter() {
        // *** WIll need to determine home or away roster
        // *** Need to check inning state: Outs, top/bottom, etc..
        // change to incorporate 3 outs and change to opponent roster
        if awayBatterIndex < awayTeam.players.count {
            awayBatterIndex += 1
        } else {
            awayBatterIndex = 0
        }
   
        currentBatter = awayTeam.players[awayBatterIndex]
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
    }

    // MARK:- Animations
    func animatePlayLabelsIn() {
        playResultLabel.center.x -= view.bounds.width
        secondaryPlayLabel.center.x += view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations:  {
            self.playResultLabel.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 3, options: [], animations: {
            self.secondaryPlayLabel.center.x -= self.view.bounds.width
        }, completion: nil)
        
        
    }
    func animatePlayLabelsOut() {
        
        // Fades labels off screen
        UIView.animate(withDuration: 0.6, animations: {
            self.playResultLabel.alpha = 0
        })
        UIView.animate(withDuration: 1.1, animations: {
            self.secondaryPlayLabel.alpha = 0
        })
    }
    
    func animateDice() {
        // Before dice animation setup
        leftDiceImage.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        rightDiceImage.transform = CGAffineTransform(rotationAngle: .pi + .pi / 2)
        leftDiceImage.center.x -= 50
        rightDiceImage.center.x += 50
        leftDiceImage.center.y += 300
        rightDiceImage.center.y += 300
        leftDiceImage.alpha = 1
        rightDiceImage.alpha = 1
        
        //animate dice in
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.8, options: [], animations: {
            self.leftDiceImage.center.x += 50
            self.leftDiceImage.center.y -= 300
            self.leftDiceImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
            self.rightDiceImage.center.x -= 50
            self.rightDiceImage.center.y -= 300
            self.rightDiceImage.transform = CGAffineTransform(rotationAngle: -.pi - .pi / 2)
        }, completion: nil)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowPlayer" {
            let controller = segue.destination as! BaseballCardViewController
            controller.currentBatter = currentBatter
         }
     }
    
   
}

