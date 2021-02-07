//
//  HomePostsViewModel.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation
import UIKit

typealias HomePostsViewModelCompletionClosure = (_ success: Bool, _ error: Error?) -> Void
typealias HomePostSetupImageCompletionClosure = (_ image: UIImage?, _ error: Error?) -> Void

class HomePostViewModel {
    let useCase: InterfaceHomePostsUseCase
    var homePublication: HomePostsResponse?
    
    required init(useCase: InterfaceHomePostsUseCase = HomePostsUseCase(repoWeb: RepoHomeWeb(proxyRest: ProxyRest()), repoDataBase: RepoDataBase())) {//WIP: improve this
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
    
    func setupImage(path: String, completion: @escaping HomePostSetupImageCompletionClosure) {
        CatchImagesUseCase().summonImage(path: path) { (image, currentPath, error) in
            guard let image = image, path == currentPath else { return }
            completion(image, nil)
        }
    }
}
