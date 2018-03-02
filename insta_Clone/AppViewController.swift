//
//  AppViewController.swift
//  insta_Clone
//
//  Created by dto_admin on 3/2/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit
import Firebase

class AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
//            let loginVC = LoginViewController()
//            self.present(loginVC, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    

}
