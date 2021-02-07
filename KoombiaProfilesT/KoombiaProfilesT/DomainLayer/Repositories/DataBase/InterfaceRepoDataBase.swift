//
//  InterfaceRepoDataBase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation


protocol InterfaceRepoDataBase {
    func insertHomePosts(homePosts: HomePostsResponse, completion: @escaping RepoDataBaseInsertingDataCompletionClosure)
    func fetchHomePosts(completion: @escaping RepoDataBaseFetchingDataCompletionClosure)
    func removeAllData(completion: @escaping RepoDataVaseDeleDataCompletionClosure)
}
