//
//  GuestViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit

class GuestViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Properly formated main label text:
        mainLabel.text = "ROCK \n / PAPAER / \n SCISSORS"
        
        // Set radius for both button and TextField:
        joinButton.layer.cornerRadius = 10
        idTextField.layer.cornerRadius = 20
        
    }
    

}
