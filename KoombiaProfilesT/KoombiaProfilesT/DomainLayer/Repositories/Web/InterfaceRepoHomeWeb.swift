//
//  InterfaceRepoHomeWeb.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

protocol InterfaceRepoHomeWeb {
    init(proxyRest: InterfaceProxyRest)
    func obtainHomePosts(completion: @escaping ObtainRepoHomePostsCompletionClosure)
}
