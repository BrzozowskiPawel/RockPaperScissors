//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Paweł Brzozowski on 20/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let db = Firestore.firestore()
        
        // Generating collection <rand id> add adding <users> documnet
        db.collection("TEST").document("users").setData(["Host":"me2"], merge: true)
        
        // Listening for changes in "users"
        db.collection("TEST").document("users").addSnapshotListener { docSnapshot, error in
            if error == nil && docSnapshot != nil && docSnapshot!.data() != nil {
                // No errors
                print(docSnapshot!.data())
                print(docSnapshot!.data()!.count)
            }
        }
    }
    


}

