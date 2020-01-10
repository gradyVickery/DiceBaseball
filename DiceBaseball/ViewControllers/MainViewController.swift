//
//  ViewController.swift
//  DiceBaseball
//
//  Created by Grady Vickery on 1/8/20.
//  Copyright © 2020 Grady Vickery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func rollTapped(_ sender: Any) {
        print("tapped")
    }
    
   // presenting baseball card for player
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         
         if segue.identifier == "ShowPlayer" {
             let controller = segue.destination as! BaseballCardViewController
             print("segue to card...nothing passed yet")
             // TODO:-  ***Pass Player Data Here***
         }
     }
}

