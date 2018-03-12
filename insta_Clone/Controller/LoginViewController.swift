//
//  LoginViewController.swift
//  insta_Clone
//
//  Created by Champ on 3/2/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleLoginBtn: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser?.uid != nil {
//            goToHome()
//        }
    }

    @IBAction func onLoginBtnPressed(_ sender: Any) {
        Login()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }else {
                self.goToHome()
            }
        }
    }
    
    func Login(){
     
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }else {
                self.goToHome()
            }
        }
    }
    
    func goToHome(){
        let homePVC = RootPageViewController()
        self.present(homePVC, animated: true, completion: nil)
    }


}
