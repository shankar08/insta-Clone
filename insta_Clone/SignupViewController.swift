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

    var databaseRef: DatabaseReference!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       databaseRef = Database.database().reference()
    }

    @IBAction func onSignUpBtnPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        signup(email:email, password:password )
    }
    
    func signup(email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
                return
            }else {
                self.createProfile(user!)
                let loginVC = LoginViewController()
                self.present(loginVC, animated: true, completion: nil)
//                let homePVC = RootPageViewController()
//                self.present(homePVC, animated: true, completion: nil)
            }
        }

        
    }
    
    func createProfile(_ user: User) {
        let userName = user.email?.components(separatedBy: "@")
        let newUser = ["username": userName![0],
            "email":user.email]
        
        self.databaseRef.child("profiles").child(user.uid).updateChildValues(newUser) {
            (error, ref) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print("Profile successfully created")
            
        }
        
        
        
    }
    func setupProfile(){
        //TODO: Create user profile
    }
    
}
