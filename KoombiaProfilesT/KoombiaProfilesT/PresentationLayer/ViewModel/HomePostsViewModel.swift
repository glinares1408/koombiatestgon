//
//  HomePostsViewModel.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias HomePostsViewModelCompletionClosure = (_ success: Bool, _ error: Error?) -> Void

class HomePostViewModel {
    let useCase: InterfaceHomeUseCase
    var homePublication: HomePostsResponse?
    
    required init(useCase: InterfaceHomeUseCase = HomePostsUseCase(repoWeb: RepoHomeWeb(proxyRest: ProxyRest()))) {//WIP: improve this
        self.useCase = useCase
    }
}

extension HomePostViewModel: InterfaceHomePostsViewModel {
    func getPosts(completion: @escaping HomePostsViewModelCompletionClosure) {
        
        useCase.obtainHomePosts {[weak self] (homePosts, error) in
            guard
                let self = self,
                let homePosts = homePosts else {
                completion(false, error)
                return
            }
            
            self.homePublication = homePosts;
            
            completion(true, nil)
        }
    }
}
