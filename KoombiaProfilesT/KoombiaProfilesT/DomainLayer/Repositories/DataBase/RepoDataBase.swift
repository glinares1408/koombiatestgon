//
//  RepoDataBase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias RepoDataBaseFetchingDataCompletionClosure = (_ homePost: HomePostsResponse?, _ error: Error?) -> Void
typealias RepoDataBaseInsertingDataCompletionClosure = (_ success: Bool, _ error: Error?) -> Void

class RepoDataBase {
    
}

extension RepoDataBase: InterfaceRepoDataBase {
    func fetchHomePosts(completion: @escaping RepoDataBaseFetchingDataCompletionClosure) {
        HomePostsDAO().fetchHomePosts { (response, error) in
            completion(response, error)
        }
    }
    
    func insertHomePosts(homePosts: HomePostsResponse, completion: @escaping RepoDataBaseInsertingDataCompletionClosure) {
        HomePostsDAO().insertHomePosts(homePostResponse: homePosts) { (success, error) in
            completion(success, error)
        }
    }
}
