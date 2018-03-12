//
//  ProfileViewController.swift
//  insta_Clone
//
//  Created by dto_admin on 3/9/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var displayNameLbl: UILabel!
    
    var databaseRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        loadProflieInfo()

    }

    func loadProflieInfo(){
        if let userID = Auth.auth().currentUser?.uid {
            print("userID: \(userID)")
            databaseRef.child("profiles").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let returnedData = snapshot.value as? NSDictionary
                let userName = returnedData?["username"] as? String ?? "username"
                if let imgurl = returnedData?["profileImg"] as? String {
                    let url = URL(string: imgurl)
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            return
                        }
                        DispatchQueue.main.async {
                            self.profileImg.image = UIImage(data: data!)
                        }
                    }).resume()
                }
                self.userNameLabel.text = userName
                self.displayNameLbl.text = userName
                
            }){(error) in
                print(error.localizedDescription)
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onEditProfileBtnPressed(_ sender: Any) {
    }
    
}
