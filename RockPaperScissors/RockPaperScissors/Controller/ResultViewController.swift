//
//  ResultViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var resultsRebel: UILabel!
    
    // Results: ex guest - lost, host - won (or NOWINNER), send form previous screen
    var guestResult: String?
    var hostResult: String?
    
    // Data passed from previous screen about what move have HOST/GUEST choosen
    var guestMove: String?
    var hostMove: String?

    var user: String? // Who is this current user user (host or guest).
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("‼️ FINAL RESULTS: USER: \(user) host: \(hostResult), guest: \(guestResult)")
        
        // Set radius for button
        playAgainButton.layer.cornerRadius = 10
        
        // Setup label and pictures to dispaly properly
        setUpResults()
        setUpPictures()
    }
   
    // Settingup who has won and changing label text to match it
    func setUpResults() {
        if user == "HOST" && hostResult == "WON" {
            // This user won
            resultsRebel.text = "YOU WON ♥️"
        } else if user == "HOST" && hostResult == "LOST" {
            // This user lost
            resultsRebel.text = "YOU LOST 😭"
        } else if user == "GUEST" && hostResult == "WON" {
            // This user lost
            resultsRebel.text = "YOU LOST 😭"
        } else if user == "GUEST" && hostResult == "LOST" {
            // This user won
            resultsRebel.text = "YOU WON ♥️"
        } else {
            // no winner
            resultsRebel.text = "IT'S A DRAW"
        }
    }
    
    // Setting up proper image for each player (on the bottom is always this phone user)
    func setUpPictures() {
        if user == "HOST" {
            switch hostMove {
            case "ROCK":
                bottomImage.image = UIImage(named: "Rock.png")
            case "PAPER":
                bottomImage.image = UIImage(named: "Paper.png")
            case "SCISSORS":
                bottomImage.image = UIImage(named: "Scissors.png")
            default:
                return
            }
            switch guestMove {
            case "ROCK":
                topImage.image = UIImage(named: "RockUpside.png")
            case "PAPER":
                topImage.image = UIImage(named: "PaperUpside.png")
            case "SCISSORS":
                topImage.image = UIImage(named: "ScissorsUpside.png")
            default:
                return
            }
        }
        
        else if user == "GUEST" {
            switch hostMove {
            case "ROCK":
                topImage.image = UIImage(named: "RockUpside.png")
            case "PAPER":
                topImage.image = UIImage(named: "PaperUpside.png")
            case "SCISSORS":
                topImage.image = UIImage(named: "ScissorsUpside.png")
            default:
                return
            }
            switch guestMove {
            case "ROCK":
                bottomImage.image = UIImage(named: "Rock.png")
            case "PAPER":
                bottomImage.image = UIImage(named: "Paper.png")
            case "SCISSORS":
                bottomImage.image = UIImage(named: "Scissors.png")
            default:
                return
            }
        }
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
    
    // Reseting game if usser press "play again" button
    @IBAction func playAgianButtonPressed(_ sender: Any) {
        let appDelegate = AppDelegate()
        appDelegate.resetApp()
    }

}
