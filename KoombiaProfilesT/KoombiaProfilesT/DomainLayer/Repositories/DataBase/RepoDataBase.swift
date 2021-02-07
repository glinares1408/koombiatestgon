//
//  RepoDataBase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias RepoDataBaseFetchingDataCompletionClosure = (_ homePost: HomePostsResponse?, _ error: Error?) -> Void
typealias RepoDataBaseInsertingDataCompletionClosure = (_ success: Bool, _ error: Error?) -> Void
typealias RepoDataVaseDeleDataCompletionClosure = (_ sucess: Bool, _ error: Error?) -> Void

class RepoDataBase {
    let dao = HomePostsDAO()
}

extension RepoDataBase: InterfaceRepoDataBase {
    func fetchHomePosts(completion: @escaping RepoDataBaseFetchingDataCompletionClosure) {
        dao.fetchHomePosts { (response, error) in
            completion(response, error)
        }
    }
    
    func insertHomePosts(homePosts: HomePostsResponse, completion: @escaping RepoDataBaseInsertingDataCompletionClosure) {
        dao.insertHomePosts(homePostResponse: homePosts) { (success, error) in
            completion(success, error)
        }
    }
    
    func removeAllData(completion: @escaping RepoDataVaseDeleDataCompletionClosure) {
        dao.deleteDocument { (success, error) in
            completion(success, error)
        }
    }
}
