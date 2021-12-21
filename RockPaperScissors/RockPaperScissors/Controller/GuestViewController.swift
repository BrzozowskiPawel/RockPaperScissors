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
    
    var joinID: String?
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
                chooseVC.ID = idTextField.text!
                chooseVC.user = "GUEST"
            }
        }
    }
    
    @IBAction func joinButtonPressed(_ sender: Any) {
    }
    
}
