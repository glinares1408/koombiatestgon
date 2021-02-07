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
typealias HomePostsRemoveAllDataCompletionClosure = (_ sucess: Bool, _ error: Error?) -> Void

class HomePostViewModel {
    let useCase: InterfaceHomePostsUseCase
    var homePublication: [HomePostAuxiliar]?
    
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
            
            self.processHomePublication(homePosts: homePosts)
            completion(true, nil)
        }
    }
    
    func processHomePublication(homePosts: HomePostsResponse) {
        let homePostsAuxiliarList = homePosts.data.map ({ item -> HomePostAuxiliar in
            
            let dateToShow = (item.post.date.count > 10) ? String(item.post.date.prefix(10)) : item.post.date
            
            let type = (item.post.pics.count >= 4) ? HomePostsType.twoBoxesTopBottomImages : (HomePostsType(rawValue: item.post.pics.count) ?? HomePostsType.unknown)
            
            let mainPic: String?
            let bottomPics: [PicAuxiliarItem]
            
            let totalPics = item.post.pics
            
            switch type {
            case .boxTopImage:
                mainPic = item.post.pics.first
                bottomPics = []
            case .boxBottomImages:
                mainPic = nil
                bottomPics = item.post.pics.map{PicAuxiliarItem(pic: $0)}
            case .twoBoxesTopImageTwoBottomImages:
                mainPic = item.post.pics.first
                bottomPics = Array(totalPics.dropFirst()).map{ PicAuxiliarItem(pic: $0)}
            case .twoBoxesTopBottomImages:
                mainPic = item.post.pics.first
                bottomPics = Array(totalPics.dropFirst()).map{ PicAuxiliarItem(pic: $0)}
            case .unknown:
                mainPic = nil
                bottomPics = []
            }
            
            let koombeaAux = KoombeaPostAuxiliar(id: item.post.id, date: item.post.date, type: type, mainPic: mainPic, mainPicImage: nil, pics: bottomPics)
            
            let homePostAuxiliar = HomePostAuxiliar(uid: item.uid, name: item.name, email: item.email, profilePic: item.profilePic, profilePicImage: nil, dateProfile: dateToShow, post: koombeaAux)
            
            return homePostAuxiliar
            
        })
        
        homePublication = homePostsAuxiliarList
    }
    
    func setupImage(path: String, completion: @escaping HomePostSetupImageCompletionClosure) {
        CatchImagesUseCase().summonImage(path: path) { (image, currentPath, error) in
            guard let image = image, path == currentPath else { return }
            completion(image, nil)
        }
    }
    
    func removeAllData(completion: @escaping HomePostsRemoveAllDataCompletionClosure) {
        useCase.removeDataFromDB { (success, error) in
            completion(success, error)
        }
    }
}
