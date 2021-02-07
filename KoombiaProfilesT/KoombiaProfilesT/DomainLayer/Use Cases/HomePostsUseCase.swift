//
//  HomeUseCase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias HomePostsUseCaseCompletionClosure = (_ posts: HomePostsResponse?, _ error: Error?) -> Void

class HomePostsUseCase {
    let repoWeb: InterfaceRepoHomeWeb
    let repoDataBase: InterfaceRepoDataBase
    
    required init(repoWeb: InterfaceRepoHomeWeb, repoDataBase: InterfaceRepoDataBase) {
        self.repoWeb = repoWeb
        self.repoDataBase = repoDataBase
    }
}

extension HomePostsUseCase: InterfaceHomePostsUseCase {
    func obtainHomePosts(completion: @escaping HomePostsUseCaseCompletionClosure) {
        
        repoDataBase.fetchHomePosts { [weak self] (response, error) in
            guard let self = self else { return }
            
            if let response = response {
                completion(response, nil)
            } else {
                self.repoWeb.obtainHomePosts { (response, error) in
                    guard let homePosts = response else {
                        completion(nil, error)
                        return
                    }
                    
                    //Mmmmm I dunno.
                    self.repoDataBase.insertHomePosts(homePosts: homePosts) { (success, error) in
                        completion(homePosts, nil)
                    }
                }
            }
        }
    }
    
    func pullToRefresh() {
        //Add logic to delete all database and fetch new data.
    }
}
