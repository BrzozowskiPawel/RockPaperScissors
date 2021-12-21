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
    
    // Results: ex guest - lost, host - won (or NOWINNER)
    var guestResult: String?
    var hostResult: String?
    
    var guestMove: String?
    var hostMove: String?

    // Who is user (host or guest)
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("‼️ FINAL RESULTS: USER: \(user) host: \(hostResult), guest: \(guestResult)")
        
        setUpResults()
        setUpPictures()
    }
   
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
                topImage.image = UIImage(named: "Rock.png")
            case "PAPER":
                topImage.image = UIImage(named: "Paper.png")
            case "SCISSORS":
                topImage.image = UIImage(named: "Scissors.png")
            default:
                return
            }
        }
        
        else if user == "GUEST" {
            switch hostMove {
            case "ROCK":
                topImage.image = UIImage(named: "Rock.png")
            case "PAPER":
                topImage.image = UIImage(named: "Paper.png")
            case "SCISSORS":
                topImage.image = UIImage(named: "Scissors.png")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
