//
//  HostViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit

class HostViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var naviagtionControllerSetActive = false
    var newID = String(Int.random(in: 1000...9999))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Properly formated main label text:
        mainLabel.text = "ROCK \n / PAPAER / \n SCISSORS"
        
        // Set radius for both button and TextField:
        startButton.layer.cornerRadius = 10
        IdTextField.layer.cornerRadius = 20
        
        // Dispaly information about new random game ID:
        IdTextField.placeholder = "GAME ID: \(newID), tap to change."
    }
    
    // Hide anvigation bar on apearing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // Set nagiation bar viible again for next screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // Send HOST id to chooseVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.HOST_TO_CHOOSE {
            if let chooseVC = segue.destination as? ChooseViewController {
                chooseVC.ID = newID
                chooseVC.user = "HOST"
            }
        }
    }
    
    // Set navigation bar visible again and set new ID
    @IBAction func idTextFieldPressed(_ sender: UITextField) {
        // If this is pressed first time, show naviation controlelr bar
        // If it's edited multipe times still show.
        if !naviagtionControllerSetActive {
            navigationController?.setNavigationBarHidden(false, animated: false)
            naviagtionControllerSetActive = true
        }
        newID = sender.text!
    }
    
}
