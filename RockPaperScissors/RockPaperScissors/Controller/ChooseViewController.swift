//
//  ChooseViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit
import Firebase

class ChooseViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var pickOptionLabel: UILabel!
    
    var ID:String?                  // ID sended by previous screen
    var user: String?               // Host or Guest value sended by previous screen
    let db = Firestore.firestore()  // Reference to Firestor
    
    
    var hostResult: String?         // Results of game for between HOST and GUEST are saved here (WON OR LOST)
    var guestResult: String?        // Results of game for between HOST and GUEST are saved here (WON OR LOST)
    
    var guestMove: String?          // Local variable used to store what type of move has GUEST choosen
    var hostMove: String?           // Local variable used to store what type of move has HOST choosen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // Send results to resultsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.RESULT_SEGUE {
            if let resultsVC = segue.destination as? ResultViewController {
                // Send data to results screen
                resultsVC.guestResult = guestResult
                resultsVC.hostResult = hostResult
                resultsVC.guestMove = guestMove
                resultsVC.hostMove = hostMove
                resultsVC.user = user
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
    
    // When user choose move this function is fired.
    // Sending info that user choosen his/hers move
    func sendUserReadyToUserCollection() {
        // Generating collection <rand id> add adding user to the <users> documnet
        db.collection(ID!).document("users").setData([user!:"ready"], merge: true)
    }
    
    // Send type of move that this user have choosen to the DB
    func sendChoosenMove(move: String) {
        // Generating collection <rand id> add adding choosen move to the <moves> documnet
        db.collection(ID!).document("moves").setData([user!:move], merge: true)
    }
    
    // Set listener to be informed when 2 players are ready (have choosen moves).
    // When both players are ready fire checkWhoWOn()
    func setListenerForSecondPlayerMove() {
        // Listening for changes in "users"
        db.collection(ID!).document("users").addSnapshotListener { docSnapshot, error in
            if error == nil && docSnapshot != nil && docSnapshot!.data() != nil {
                // No errors
                print("USERS COUNT: \(docSnapshot!.data()!.count)")
                if docSnapshot!.data()!.count == 2 {
                    print("FOUND second player!!!")
                    self.checkWhoWon()
                }
            } else {
                print("ERROR with lsitener: \(error)")
            }
        }
    }
    
    // Function that is fired when both GUEST and HOST are ready (have choosen moves) by Listener function.
    // Checking who have won - HOST or GUEST and send the results to result screen via prepare function.
    func checkWhoWon() {
        db.collection(ID!).document("moves").getDocument { docSpanshot, error in
            if error == nil && docSpanshot != nil && docSpanshot!.data() != nil{
                // No error, we have snapshot and data
                print("RESULTS OF GAME: ")
                print(docSpanshot!.data())
                
                // Save what moves have they choosen
                self.hostMove = docSpanshot!.data()!["HOST"] as! String
                self.guestMove = docSpanshot!.data()!["GUEST"] as! String
                
                // Bassing on results decide who have won
                if self.hostMove == "ROCK" && self.guestMove == "PAPER" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if self.hostMove == "PAPER" && self.guestMove == "SCISSORS" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if self.hostMove == "SCISSORS" && self.guestMove == "ROCK" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if self.hostMove == "ROCK" && self.guestMove == "SCISSORS" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if self.hostMove == "PAPER" && self.guestMove == "ROCK" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if self.hostMove == "SCISSORS" && self.guestMove == "PAPER" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if self.hostMove == "ROCK" && self.guestMove == "ROCK" {
                    // NO winner
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                
                else if self.hostMove == "PAPER" && self.guestMove == "PAPER" {
                    // No winer
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                else if self.hostMove == "SCISSORS" && self.guestMove == "SCISSORS" {
                    // No winner
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                
                // When results are known and all data set perform segue to results screen
                self.performSegue(withIdentifier: Constants.RESULT_SEGUE, sender: nil)
                
            } else {
                print("Error while reading document with moves: \(error)")
            }
        }
    }
    
    // Buttons witch type of move
    @IBAction func moveButtonTapped(_ sender: UIButton) {
        // Tag list:
        // 0 - rock
        // 1 - paper
        // 2 - scissors
        
        // Mark this user (HOST or GUEST) as ready
        sendUserReadyToUserCollection()
        
        // Decide which of 3 buttons have been choosen
        // Fire function to save choosen move to the DB
        switch sender.tag {
        case 0:
            sendChoosenMove(move: "ROCK")
            pickOptionLabel.text = "PICKED ROCK"
        case 1:
            sendChoosenMove(move: "PAPER")
            pickOptionLabel.text = "PICKED PAPER"
        case 2:
            sendChoosenMove(move: "SCISSORS")
            pickOptionLabel.text = "PICKED SCISSORS"
        default:
            print("SWITCH ERROR")
        }
        
        // Activate listeners when both players are ready
        // only then showing next screen is possible
        setListenerForSecondPlayerMove()
    }
    

}
