//
//  Constants.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

struct Constants {
    enum HTTPStatusCode: Int {
        case ok = 200
        case serverError = 500
    }
    
    struct EndPoints {
        static let baseURL = "https://mock.koombea.io/mt/api/"
        static let koombeaPosts = "posts"
    }
    
    struct DataBase {
        static let homePosts = "home_posts"
    }
    
    static let directoryImages = "home_profiles"
}
