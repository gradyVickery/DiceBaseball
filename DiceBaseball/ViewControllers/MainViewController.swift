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
    var resultLabels = ResultLabels()
    var league = League()
    var rollResultText = ""
    
    var leftDiceImage = UIImageView()
    var rightDiceImage = UIImageView()
    var mainLabel = UILabel()
    var secondaryLabel = UILabel()
    
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
        mainLabel = resultLabels.mainLabel
        secondaryLabel = resultLabels.secondaryLabel
        
        view.addSubview(leftDiceImage)
        view.addSubview(rightDiceImage)
        view.addSubview(mainLabel)
        view.addSubview(secondaryLabel)
        
        rollButton.isEnabled = false
        rollButton.alpha = 0.3
        inningLabel.text = "Warmup"
        mainLabel.text = ""
        secondaryLabel.text = "Press 'New Game' to start."
        atBatLabel.text = ""
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        resultLabels.slideSecondaryLabelOut(withDelay: 0.5)
        league.assignTeamNames()
        
        // update scoreboard labels
        inningLabel.text = inningHalf + " " + String(inning)
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
        mainLabel.text = "Play Ball!"
        resultLabels.fadeMainLabelOut(withDelay: 3.0)
        delay(5.0) {
            self.startButtonAnimation()
            self.mainLabel.text = ""
        }

    }

    // MARK:- Gameplay
    @IBAction func rollTapped(_ sender: Any) {
        leftDiceImage.alpha = 0
        rightDiceImage.alpha = 0
        stopButtonAnimation()
        let rollTuple = dice.rollDice()
        dice.animateDice()
        let rollResult = currentBatter.getDiceResults(dice1: rollTuple.0, dice2: rollTuple.1)
        rollResultText = rollResult.rawValue

        handleResultLabels()
        
        // *************** //
        // TODO:- handle baserunners, runs, outs, inning changes
        
        // delay allows labels time to be read
        delay(6.0) {
            self.nextBatter()
            self.startButtonAnimation()
        }
    }
    
    func nextBatter() {
        
        if awayBatterIndex < awayTeam.players.count - 1 {
            awayBatterIndex += 1
        } else {
            awayBatterIndex = 0
        }
   
        currentBatter = awayTeam.players[awayBatterIndex]
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
    }
    
    
    
    func handleResultLabels() {
        mainLabel.text = rollResultText
        secondaryLabel.text = "You have baserunners on 1st and 3rd"
        
        resultLabels.slideMainLabelIn(withDelay: 0.9)
        resultLabels.slideSecondaryLabelIn(withDelay: 2.1)
        resultLabels.slideMainLabelOut(withDelay: 5.0)
        resultLabels.slideSecondaryLabelOut(withDelay: 6.0)
    }
    // MARK:- Animation
    func startButtonAnimation() {
        // animate Roll button
        rollButton.alpha = 1.0
        rollButton.isEnabled = true
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction ], animations: {
            self.rollButton.alpha = 0.4
        }, completion: nil)
    }
    
    func stopButtonAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            self.rollButton.alpha = 0.3
        }, completion: nil)
        rollButton.isEnabled = false
        
    }


    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowPlayer" {
            let controller = segue.destination as! BaseballCardViewController
            controller.currentBatter = currentBatter
         }
     }
}

