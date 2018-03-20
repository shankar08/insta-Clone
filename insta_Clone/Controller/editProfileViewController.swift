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

class editProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
                
                if let imgurl = returnedData?["photo"] as? String {
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
        updateUserProfileData()
    }
    
    func updateUserProfileData(){
        
        if let userID = Auth.auth().currentUser?.uid {
            
            let storageItem = storageRef.child("profile_images").child(userID)
            
            guard let profileImage = self.profileImg.image else {return}
            
            if let newImage = UIImagePNGRepresentation(profileImage) {
            
                storageItem.putData(newImage, metadata: nil, completion: { (metaData, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    storageItem.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            return
                        }
                        if let photoURL = url?.absoluteString {
                            guard let userName = self.userNameTxtField.text else {return}
                            guard let email = self.emailTxtField.text else {return}
                            
                            let newValues = ["username": userName,
                                             "email":email,
                                             "photo" : photoURL
                            ]
                            self.databaseRef.child("profiles").child(userID).updateChildValues(newValues, withCompletionBlock: { (error, reference) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    return
                                }
                                print("Profile successfully updated")
                            })
                        }
                    })
                })
               // storageItem
            }
            
        }
    }
    
    @IBAction func onCancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onChangeImageBtnPressed(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
         picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var choosenImage = UIImage()
        
         choosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        profileImg.image = choosenImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
