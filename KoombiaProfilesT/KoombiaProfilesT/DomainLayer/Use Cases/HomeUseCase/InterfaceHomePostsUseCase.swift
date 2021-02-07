//
//  InterfaceHomeUseCase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

protocol InterfaceHomePostsUseCase {
    init(repoWeb: InterfaceRepoHomeWeb, repoDataBase: InterfaceRepoDataBase)
    func obtainHomePosts(completion: @escaping HomePostsUseCaseCompletionClosure)
    func removeDataFromDB(completion: @escaping HomePostsDeleteDataCompletionClosure)
}
