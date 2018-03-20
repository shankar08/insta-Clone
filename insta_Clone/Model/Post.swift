//
//  Post.swift
//  insta_Clone
//
//  Created by dto_admin on 3/12/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import Foundation

class Post {
    
    var profilePic : String
    var username : String
    var postImage  : String
    
    init(profilePic : String, username : String, postImage : String) {
        self.profilePic = profilePic
        self.username = username
        self.postImage = postImage
        
    }
    
}
