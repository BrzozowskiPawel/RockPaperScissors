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
    
    var ID: String?
    
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

// Firebase commands:
//extension ViewController {
//    let db = Firestore.firestore()
//
//    // Generating collection <rand id> add adding <users> documnet
//    db.collection("TEST").document("users").setData(["Host":"me2"], merge: true)
//
//    // Listening for changes in "users"
//    db.collection("TEST").document("users").addSnapshotListener { docSnapshot, error in
//        if error == nil && docSnapshot != nil && docSnapshot!.data() != nil {
//            // No errors
//            print(docSnapshot!.data())
//            print(docSnapshot!.data()!.count)
//        }
//    }
//}
