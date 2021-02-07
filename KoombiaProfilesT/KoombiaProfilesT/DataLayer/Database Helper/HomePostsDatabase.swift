//
//  HomePostsDatabase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation
import CouchbaseLiteSwift

struct HomePostsDatabase {
    static let shared = HomePostsDatabase()
    
    let database: Database?
    
    init() {
        //let config = DatabaseConfiguration()
        let dataBaseName = Constants.DataBase.homePosts
        //config.encryptionKey = EncryptionKey.password("KoombeaTest") //WIP: this pass could be a random string from keychain.
        //database = try? Database(name: dataBaseName, config: config)
        database = try? Database(name: dataBaseName)
    }
}
