//
//  RepoWeb.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

typealias ObtainRepoHomePostsCompletionClosure = (_ posts: HomePostsResponse?,_ error: Error?) -> Void

enum RepoHomeWebError: Error {
    case decoding
}

class RepoHomeWeb {
    let proxyRest: InterfaceProxyRest
    
    private let baseURL = Constants.EndPoints.baseURL
    private let postsEndPoint = Constants.EndPoints.koombeaPosts
    
    required init(proxyRest: InterfaceProxyRest) {
        self.proxyRest = proxyRest
    }
}

extension RepoHomeWeb: InterfaceRepoHomeWeb {
    func obtainHomePosts(completion: @escaping ObtainRepoHomePostsCompletionClosure) {
        let postsURL = baseURL + postsEndPoint
        
        proxyRest.perfromStandartRequest(urlString: postsURL) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            guard
                let object = try? JSONDecoder().decode(HomePostsResponse.self, from: data)
            else {
                completion(nil, RepoHomeWebError.decoding)
                return
            }
            
            completion(object, nil);
        }
    }
}


