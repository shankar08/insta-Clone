//
//  User.swift
//  insta_Clone
//
//  Created by dto_admin on 3/13/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import Foundation

class Person {
    
    var bio : String
    var display : String
    var email : String
    var photo : String
    var username : String
    
    init(bio:String, display: String, email: String, photo: String, username: String) {
        self.bio = bio
        self.display = display
        self.email = email
        self.photo = photo
        self.username = username
        
    }
    
    func getUserAsDictionary()->Dictionary<String, String>{
        let userDictionary = [
            "bio" : bio,
            "display" : display,
            "email" : email,
            "photo" : photo,
            "username" : username
        
        ]
        
        return userDictionary
    }
    
}
