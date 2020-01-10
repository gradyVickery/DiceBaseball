//
//  BaseballCardViewController.swift
//  BaseballGame
//
//  Created by Grady Vickery on 4/3/18.
//  Copyright © 2018 Grady Vickery. All rights reserved.
//

import UIKit

class BaseballCardViewController: UIViewController {

    var currentBatter = Batter()
    
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var jerseyNumberLabel: UILabel!
    @IBOutlet weak var hitterTypeLabel: UILabel!
    
    @IBOutlet weak var playResult11: UILabel!
    @IBOutlet weak var playResult12: UILabel!
    @IBOutlet weak var playResult13: UILabel!
    @IBOutlet weak var playResult14: UILabel!
    @IBOutlet weak var playResult15: UILabel!
    @IBOutlet weak var playResult16: UILabel!
    @IBOutlet weak var playResult22: UILabel!
    @IBOutlet weak var playResult23: UILabel!
    @IBOutlet weak var playResult24: UILabel!
    @IBOutlet weak var playResult25: UILabel!
    @IBOutlet weak var playResult26: UILabel!
    @IBOutlet weak var playResult33: UILabel!
    @IBOutlet weak var playResult34: UILabel!
    @IBOutlet weak var playResult35: UILabel!
    @IBOutlet weak var playResult36: UILabel!
    @IBOutlet weak var playResult44: UILabel!
    @IBOutlet weak var playResult45: UILabel!
    @IBOutlet weak var playResult46: UILabel!
    @IBOutlet weak var playResult55: UILabel!
    @IBOutlet weak var playResult56: UILabel!
    @IBOutlet weak var playResult66: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillCard()
      
    }

    @IBAction func backToMainButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // fill card info
    func fillCard() {
    
        fullNameLabel.text = currentBatter.firstName + currentBatter.lastName
        positionLabel.text = currentBatter.position
        teamNameLabel.text = currentBatter.teamName
        jerseyNumberLabel.text = String(currentBatter.num)
        hitterTypeLabel.text = currentBatter.hitterType
        
//        playResult11.text = currentBatter.getPlayLabels(code: arrayCodes[0])
//        playResult12.text = currentBatter.getPlayLabels(code: arrayCodes[1])
//        playResult13.text = currentBatter.getPlayLabels(code: arrayCodes[2])
//        playResult14.text = currentBatter.getPlayLabels(code: arrayCodes[3])
//        playResult15.text = currentBatter.getPlayLabels(code: arrayCodes[4])
//        playResult16.text = currentBatter.getPlayLabels(code: arrayCodes[5])
//        playResult22.text = currentBatter.getPlayLabels(code: arrayCodes[6])
//        playResult23.text = currentBatter.getPlayLabels(code: arrayCodes[7])
//        playResult24.text = currentBatter.getPlayLabels(code: arrayCodes[8])
//        playResult25.text = currentBatter.getPlayLabels(code: arrayCodes[9])
//        playResult26.text = currentBatter.getPlayLabels(code: arrayCodes[10])
//        playResult33.text = currentBatter.getPlayLabels(code: arrayCodes[11])
//        playResult34.text = currentBatter.getPlayLabels(code: arrayCodes[12])
//        playResult35.text = currentBatter.getPlayLabels(code: arrayCodes[13])
//        playResult36.text = currentBatter.getPlayLabels(code: arrayCodes[14])
//        playResult44.text = currentBatter.getPlayLabels(code: arrayCodes[15])
//        playResult45.text = currentBatter.getPlayLabels(code: arrayCodes[16])
//        playResult46.text = currentBatter.getPlayLabels(code: arrayCodes[17])
//        playResult55.text = currentBatter.getPlayLabels(code: arrayCodes[18])
//        playResult56.text = currentBatter.getPlayLabels(code: arrayCodes[19])
//        playResult66.text = currentBatter.getPlayLabels(code: arrayCodes[20])
    }
}
