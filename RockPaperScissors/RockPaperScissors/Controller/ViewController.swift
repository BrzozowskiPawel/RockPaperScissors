//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuration of UI elements:
        
        // Properly formated main label text:
        nameLabel.text = "ROCK \n / PAPAER / \n SCISSORS"
        
        // Set radius for both buttons:
        hostButton.layer.cornerRadius = 10
        joinButton.layer.cornerRadius = 10
    }


}

