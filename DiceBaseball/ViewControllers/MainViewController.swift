//
//  ViewController.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/8/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var dice = Dice()
    var league = League()
    var leftDiceImage = UIImageView()
    var rightDiceImage = UIImageView()
    
    let awayTeam: Team
    let homeTeam: Team
    var currentBatter: Player
    
    var awayBatterIndex = 0
    var homeBatterIndex = 0
    
    // Scoreboard variables
    var awayTeamScore = 0
    var homeTeamScore = 0
    var inningHalf = "Top"
    var inning = 1
    var outs = 0
    
    var rollButtonIsAnimated = false
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var atBatLabel: UILabel!
    @IBOutlet weak var outsLabel: UILabel!
    @IBOutlet weak var playResultLabel: UILabel!
    @IBOutlet weak var secondaryPlayLabel: UILabel!
    
    @IBOutlet weak var fieldImage: UIImageView!
    
    @IBOutlet weak var rollButton: UIButton!
    
    
    required init?(coder: NSCoder) {
        self.awayTeam = league.teams[0]
        self.homeTeam = league.teams[1]
        self.currentBatter = awayTeam.players[awayBatterIndex]
        super.init(coder: coder)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftDiceImage = dice.leftDiceImage
        rightDiceImage = dice.rightDiceImage
        
        view.addSubview(leftDiceImage)
        view.addSubview(rightDiceImage)
        
        rollButton.isEnabled = false
        rollButton.alpha = 0.3
        inningLabel.text = "Warmup"
        playResultLabel.text = ""
        secondaryPlayLabel.text = "Press 'New Game' to start."
        atBatLabel.text = ""
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        secondaryPlayLabel.text = ""
        league.assignTeamNames()
        inningLabel.text = inningHalf + " " + String(inning)
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
        
        delay(1.0) {
            self.playResultLabel.text = "Play Ball!"
            delay(1.0) {
                self.rollButton.alpha = 1.0
                self.startButtonAnimation()
                self.rollButton.isEnabled = true
                UIView.animate(withDuration: 2.0, animations: {
                    self.playResultLabel.alpha = 0.0
                })
            }
        }
    }

    // MARK:- Gameplay
    @IBAction func rollTapped(_ sender: Any) {
        
        leftDiceImage.alpha = 0
        rightDiceImage.alpha = 0
        
        stopButtonAnimation()
        rollButton.alpha = 0.3
        rollButton.isEnabled = false
        playResultLabel.alpha = 1
        secondaryPlayLabel.alpha = 1
        
        let rollTuple = dice.rollDice()
        
        dice.animateDice()
        let rollResult = currentBatter.getDiceResults(dice1: rollTuple.0, dice2: rollTuple.1)
        
        print(rollResult.rawValue)
        
        // *************** //
        // TODO:- handle after at bat
        // will need to check outs, inning, team, score before call
        
        //configurePlayLabels(result: rollResult) // call could handle runs scored/ outs?
        
        animatePlayLabels()
        
        delay(6.0) {
            self.nextBatter()
            self.rollButton.isEnabled = true
            self.rollButton.alpha = 1
            self.startButtonAnimation()
            
        }
    }
    
    func configurePlayLabels(result: Player.PlayResults) {
        
        playResultLabel.text = result.rawValue
        
        if result == .single {
            secondaryPlayLabel.text = "Ready for next batter"
        } else {
            secondaryPlayLabel.text = "2 runs scored?"
        }
    }
    func nextBatter() {
        // *** WIll need to determine home or away roster
        // *** Need to check inning state: Outs, top/bottom, etc..
        // change to incorporate 3 outs and change to opponent roster
        if awayBatterIndex < awayTeam.players.count - 1 {
            awayBatterIndex += 1
        } else {
            awayBatterIndex = 0
        }
   
        currentBatter = awayTeam.players[awayBatterIndex]
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
    }

    
    // MARK:- Animations
    func animatePlayLabels() {
        playResultLabel.center.x -= view.bounds.width
        secondaryPlayLabel.center.x += view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [], animations:  {
            self.playResultLabel.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 2.8, options: [], animations: {
            self.secondaryPlayLabel.center.x -= self.view.bounds.width
        }, completion: {
            finished in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: [], animations: {
                self.playResultLabel.center.x -= self.view.bounds.width
            }, completion: {
                finished in
                self.playResultLabel.text = ""
                UIView.animate(withDuration: 1.0, delay: 0.6, options: [], animations: {
                    self.secondaryPlayLabel.alpha = 0
                }, completion: nil)
            })
        })
    }
    func startButtonAnimation() {
        // animate Roll button
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction ], animations: {
            self.rollButton.alpha = 0.3
        }, completion: nil)
    }
    
    func stopButtonAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            self.rollButton.alpha = 1.0
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

