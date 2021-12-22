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
    
    // Join id provided by user from textField
    var joinID: String?
    // Variable responsible for showing navigation bar when user is editing
    // It make sure that trigering to show nav. bar will be fired only once.
    var naviagtionControllerSetActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Properly formated main label text:
        mainLabel.text = "ROCK \n / PAPAER / \n SCISSORS"
        
        // Set radius for both button and TextField:
        joinButton.layer.cornerRadius = 10
        idTextField.layer.cornerRadius = 20
        
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
    
    // When GUEST is editing textField show him option to go back via navigation controller
    @IBAction func edditingTextField(_ sender: Any) {
        if !naviagtionControllerSetActive {
            navigationController?.setNavigationBarHidden(false, animated: false)
            naviagtionControllerSetActive = true
        }
        
    }
    
    // Send provided JOIN id to chooseVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.JOIN_TO_CHOOSE {
            if let chooseVC = segue.destination as? ChooseViewController {
                // Send data about gameID and that the next screen have been triggered GUEST
                chooseVC.ID = idTextField.text!
                chooseVC.user = "GUEST"
            }
        }
    }
    
    // Code when GUEST press join button
    @IBAction func joinButtonPressed(_ sender: Any) {
    }
    
}
