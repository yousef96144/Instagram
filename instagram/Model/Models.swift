//
//  Models.swift
//  instagram
//
//  Created by yousef Elaidy on 18/03/2025.
//

import Foundation
enum Gender{
    case male,female,other
}
struct user{
    let username: String
    let bio: String
    let name: (first: String,last:String)
    let birthdate:Date
    let gender: Gender
    let counts: usercount
//    let joinDate: Date
    let profilephoto: URL?
}
struct usercount{
    let followers: Int
    let following: Int
    let posts: Int
}
public enum userposttype: String{
        case photo = "photo"
        case video = "video"
    }
    // represent a userpost
   
public struct UserPost{
 //   let identifier: String
    let posttype: userposttype
    let thumbnailimage: URL
    let posturl: URL
    let caption: String?
    let likecount: [postlike]
    let comments: [postcomment]
    let postdate: Date
    let tagpost: [user]
    let owner: user
}

struct postlike{
    let username: String
    let postIdentifier: String
}

struct commentlike{
    let username: String
    let commentIdentifier: String
}
struct postcomment{
    let identifier: String
    let username: String
    let text: String
    let createddate: Date
    let likes : [commentlike]
}
