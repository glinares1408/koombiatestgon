//
//  HomePostsResponse.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation


struct HomePostsResponse: Codable {
    let data: [HomePost]
}

struct HomePost: Codable {
    let uid: String
    let name: String
    let email: String
    let profilePic: String
    let post: KoombeaPost
    
    enum CodingKeys: String, CodingKey {
        case uid, name, email
        case profilePic = "profile_pic"
        case post
    }
}

struct KoombeaPost: Codable {
    let id: Int
    let date: String
    let pics: [String]
}
