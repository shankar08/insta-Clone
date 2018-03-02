//
//  SignupViewController.swift
//  insta_Clone
//
//  Created by Champ on 3/1/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    @IBAction func onSignUpBtnPressed(_ sender: Any) {
        signup()
    }
    
    func signup(){
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error)
            }else {
                let homePVC = RootPageViewController()
                self.present(homePVC, animated: true, completion: nil)
            }
        }

        
    }
    
    func setupProfile(){
        //TODO: Create user profile
    }
    
}
