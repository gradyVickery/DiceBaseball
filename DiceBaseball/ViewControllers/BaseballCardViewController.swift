//
//  BaseballCardViewController.swift
//  BaseballGame
//
//  Created by Grady Vickery on 4/3/18.
//  Copyright © 2018 Grady Vickery. All rights reserved.
//

import UIKit

class BaseballCardViewController: UIViewController {

    var currentBatter: Player?
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var jerseyNumberLabel: UILabel!
    @IBOutlet weak var hitterTypeLabel: UILabel!
    @IBOutlet var diceResults: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillCard()
    }

    @IBAction func backToMainButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // fill card info
    func fillCard() {
        if let batter = currentBatter {
            fullNameLabel.text = batter.firstName + " " + batter.lastName
            positionLabel.text = batter.position.rawValue
            teamNameLabel.text = batter.teamName
            jerseyNumberLabel.text = String(batter.number)
            hitterTypeLabel.text = batter.hitterType.rawValue
            
            // loop for diceResult images
            var control = 1
            var resultIndex = 0
            for i in 1...6 {
                for j in 1...6 {
                    if i >= control && j >= control {
                        diceResults[resultIndex].text = batter.getDiceResults(dice1: i, dice2: j).rawValue
                        resultIndex += 1
                    }
                }
                control += 1
            }
        }
    }
}
