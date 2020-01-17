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
    var ballImageView = BallImage()
    var rollResultText = ""
    
    // Views
    var leftDiceImage = UIImageView()
    var rightDiceImage = UIImageView()
    
    var mainLabel = UILabel()
    var secondaryLabel = UILabel()
    var ballImage = UIImageView()
    
    // Teams, batting order and Runners
    let awayTeam: Team
    let homeTeam: Team
    var battingTeam: Team
    var currentBatter: Player
    var awayBatterIndex = 0
    var homeBatterIndex = 0
    var isOn1st = false
    var isOn2nd = false
    var isOn3rd = false
    var awayTeamIsBatting = true
   
    // Outlet Variables
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var inningLabel: UILabel!
    @IBOutlet weak var atBatLabel: UILabel!
    @IBOutlet weak var outsLabel: UILabel!
    @IBOutlet weak var fieldImage: UIImageView!
    @IBOutlet weak var rollButton: UIButton!
    
    // Scoreboard variables
    var awayTeamScore = 0
    var homeTeamScore = 0
    var inningHalf = "Top"
    var inning = 1
    var outs = 0
           
       
    
    required init?(coder: NSCoder) {
        self.awayTeam = league.teams[0]
        self.homeTeam = league.teams[1]
        self.battingTeam = awayTeam
        self.currentBatter = battingTeam.players[awayBatterIndex]
        super.init(coder: coder)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        leftDiceImage = dice.leftDiceImage
        rightDiceImage = dice.rightDiceImage
        mainLabel = resultLabels.mainLabel
        secondaryLabel = resultLabels.secondaryLabel
        ballImage = ballImageView.ballImageView
        ballImage.center.x = view.bounds.width / 2
        ballImage.center.y = fieldImage.center.y * 1.28
        ballImage.alpha = 0
        
        view.addSubview(leftDiceImage)
        view.addSubview(rightDiceImage)
        view.addSubview(mainLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(ballImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rollButton.isEnabled = false
        rollButton.alpha = 0.3
        inningLabel.text = "Warmup"
        mainLabel.text = ""
        atBatLabel.text = ""
        
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        
        //handle in game tap on button with alert or other cancelable option
        sender.alpha = 0.4
        sender.isEnabled = false // alert for in game tapping?
        resultLabels.slideSecondaryLabelOut(withDelay: 0.5)
        league.assignTeamNames()
        
        // update scoreboard labels
        inningLabel.text = inningHalf + " " + String(inning)
        atBatLabel.text = currentBatter.lastName + " " + currentBatter.position.rawValue
        mainLabel.text = "Play Ball!"
        resultLabels.fadeMainLabelOut(withDelay: 2.0)
        delay(4.0) {
            self.startButtonAnimation()
        }

    }

    // MARK:- Gameplay
    @IBAction func rollTapped(_ sender: Any) {
        leftDiceImage.alpha = 0
        rightDiceImage.alpha = 0
        stopButtonAnimation()
        let rollTuple = dice.rollDice()
        dice.animateDice()
        var rollResult = currentBatter.getDiceResults(dice1: rollTuple.0, dice2: rollTuple.1)
        rollResultText = rollResult.rawValue
        
        
        rollResult = .out
        // *************** //
        // TODO:- outs, inning changes
        // timing needs tweaking...test every case(hit)
        
        if rollResult == .out {
            outs += 1
            outsLabel.text = String(outs)
            inningCheck()
            return
        }
        
        let newRuns = resultLabels.handleResults(rollResult: rollResult)
        ballImageView.animateBall(hit: rollResult)
        if newRuns > 0 {
            handleRuns(newRuns: newRuns)
        }
        
        delay(2.0) {
            self.fieldImage.image = self.resultLabels.field
        }
        delay(5.0) {
            self.fieldImage.image = self.resultLabels.field
            self.nextBatter()
            self.startButtonAnimation()
        }
        
    }
    
    func inningCheck() {
        
        if outs == 3 {
            inningChange()
        }
        delay(3.0) {
            self.fieldImage.image = self.resultLabels.field
            self.nextBatter()
            self.startButtonAnimation()
        }
    }
    
    func inningChange() {
        outs = 0
        resultLabels.field = UIImage(named: "basesEmptyField")
        if inningHalf == "Top" {
            inningHalf = "Bottom"
        } else {
            inningHalf = "Top"
            inning += 1
        }
        
        inningLabel.text = inningHalf + " " + String(inning)
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
    
    func handleRuns(newRuns: Int) {
           if awayTeamIsBatting {
               awayTeamScore += newRuns
            awayTeamScoreLabel.text = String(awayTeamScore)
           } else {
               homeTeamScore += newRuns
               homeTeamScoreLabel.text = String(homeTeamScore)
           }
       }
    
 
    // MARK:- Animation
    func startButtonAnimation() {
        //rollButton.alpha = 1.0
        rollButton.isEnabled = true
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction ], animations: {
            self.rollButton.alpha = 1.0
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

