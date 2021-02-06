//
//  InterfaceHomeUseCase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

protocol InterfaceHomeUseCase {
    init(repoWeb: InterfaceRepoHomeWeb)
    func obtainHomePosts(completion: @escaping HomePostsUseCaseCompletionClosure)
}
