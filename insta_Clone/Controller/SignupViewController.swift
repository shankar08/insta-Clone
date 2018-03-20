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
//                let loginVC = LoginViewController()
//                self.present(loginVC, animated: true, completion: nil)
                let homePVC = RootPageViewController()
                self.present(homePVC, animated: true, completion: nil)
            }
        }

        
    }
    
    func createProfile(_ user: User) {
        let userName = user.email?.components(separatedBy: "@")
        
        let newUser = Person(bio: "", display: userName![0], email: user.email!, photo: "https://firebasestorage.googleapis.com/v0/b/instapuzzlegram.appspot.com/o/dog.png?alt=media&token=33462e46-b7df-4d82-bd7f-209af0c8250b", username: userName![0])
        
        self.databaseRef.child("profiles").child(user.uid).updateChildValues(newUser.getUserAsDictionary()) {
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
