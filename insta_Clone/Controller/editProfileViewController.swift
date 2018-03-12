//
//  editProfileViewController.swift
//  insta_Clone
//
//  Created by dto_admin on 3/12/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class editProfileViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    var databaseRef : DatabaseReference!
    var storageRef : StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
        storageRef = Storage.storage().reference()
        loadProfileToEdit()
        
    }


    func loadProfileToEdit(){
        
        if let userID = Auth.auth().currentUser?.uid{
            print("userID: \(userID)")
            databaseRef.child("profiles").child(userID).observe(.value, with: { (snapshot) in
                
                let returnedData = snapshot.value as? NSDictionary
                
                if let imgurl = returnedData?["profileImg"] as? String {
                    self.profileImg.sd_setImage(with: URL(string: imgurl))
                }
                
                if let userName = returnedData?["username"] as? String {
                    self.userNameTxtField.text = userName
                }
                if let email = returnedData?["email"] as? String {
                    self.emailTxtField.text = email
                }
                
            })
        }
        
    }
    
    
    @IBAction func onOkBtnPressed(_ sender: Any) {
    }
    
    @IBAction func onCancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onChangeImageBtnPressed(_ sender: Any) {
    }
    
}
