//
//  HomeUseCase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias HomePostsUseCaseCompletionClosure = (_ posts: HomePostsResponse?, _ error: Error?) -> Void

class HomePostsUseCase {
    let repo: InterfaceRepoHomeWeb
    
    required init(repoWeb: InterfaceRepoHomeWeb) {
        self.repo = repoWeb
    }
}

extension HomePostsUseCase: InterfaceHomeUseCase {
    func obtainHomePosts(completion: @escaping HomePostsUseCaseCompletionClosure) {
        repo.obtainHomePosts { (response, error) in
            completion(response, error)
        }
    }
}
