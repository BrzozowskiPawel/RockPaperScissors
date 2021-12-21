//
//  ChooseViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit
import Firebase

class ChooseViewController: UIViewController {

    var ID:String?
    var user: String? // Host or Guest
    let db = Firestore.firestore()
    
    var hostResult: String?
    var guestResult: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(ID)
    }
    

    // Send results to resultsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.RESULT_SEGUE {
            if let resultsVC = segue.destination as? ResultViewController {
                resultsVC.guest = guestResult
                resultsVC.host = hostResult
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
    
    func sendUserReadyToUserCollection() {
        // Generating collection <rand id> add adding user to the <users> documnet
        db.collection(ID!).document("users").setData([user!:"ready"], merge: true)
    }
    
    func sendChoosenMove(move: String) {
        // Generating collection <rand id> add adding choosen move to the <moves> documnet
        db.collection(ID!).document("moves").setData([user!:move], merge: true)
    }
    
    
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
    
    func checkWhoWon() {
        print("CHECKING MOVES")
        db.collection(ID!).document("moves").getDocument { docSpanshot, error in
            if error == nil && docSpanshot != nil && docSpanshot!.data() != nil{
                // No error, we have snapshot and data
                print("RESULTS OF GAME: ")
                print(docSpanshot!.data())
                let hostMove = docSpanshot!.data()!["HOST"] as! String
                print(hostMove)
                let guestMove = docSpanshot!.data()!["GUEST"] as! String
                
                if hostMove == "ROCK" && guestMove == "PAPER" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if hostMove == "PAPER" && guestMove == "SCISSORS" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if hostMove == "SCISSORS" && guestMove == "ROCK" {
                    // Host lost
                    self.hostResult = "LOST"
                    self.guestResult = "WON"
                }
                else if hostMove == "ROCK" && guestMove == "SCISSORS" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if hostMove == "PAPER" && guestMove == "ROCK" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if hostMove == "SCISSORS" && guestMove == "PAPER" {
                    // Host won
                    self.hostResult = "WON"
                    self.guestResult = "LOST"
                }
                else if hostMove == "ROCK" && guestMove == "ROCK" {
                    // NO winner
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                
                else if hostMove == "PAPER" && guestMove == "PAPER" {
                    // No winer
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                else if hostMove == "SCISSORS" && guestMove == "SCISSORS" {
                    // No winner
                    self.hostResult = "NOWINNER"
                    self.guestResult = "NOWINNER"
                }
                
                self.performSegue(withIdentifier: Constants.RESULT_SEGUE, sender: nil)
                
            } else {
                print("Error while reading document with moves: \(error)")
            }
        }
    }
    
    
    @IBAction func moveButtonTapped(_ sender: UIButton) {
        // Tag list:
        // 0 - rock
        // 1 - paper
        // 2 - scissors
        print("USER PRESSED")
        sendUserReadyToUserCollection()
        switch sender.tag {
        case 0:
            sendChoosenMove(move: "ROCK")
        case 1:
            sendChoosenMove(move: "PAPER")
        case 2:
            sendChoosenMove(move: "SCISSORS")
        default:
            print("SWITCH ERROR")
        }
        setListenerForSecondPlayerMove()
    }
    

}
