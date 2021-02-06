//
//  InterfaceHomePostsViewModel.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation

protocol InterfaceHomePostsViewModel {
    init(useCase: InterfaceHomeUseCase)
    var homePublication: HomePostsResponse? { get set }
    func getPosts(completion: @escaping HomePostsViewModelCompletionClosure)
}
