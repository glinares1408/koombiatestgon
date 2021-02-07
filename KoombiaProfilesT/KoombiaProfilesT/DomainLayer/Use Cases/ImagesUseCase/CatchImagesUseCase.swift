//
//  CatchImagesUseCase.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import UIKit


typealias CatchImagesUseCaseCompletionClosure = (_ image: UIImage?, _ path: String, _ error: Error?) -> Void

class CatchImagesUseCase {
    static let shared = CatchImagesUseCase()
    
    func summonImage(path: String, completion: @escaping CatchImagesUseCaseCompletionClosure) {
        
        ProxyFile().readFileFrom(path: path, directory: Constants.directoryImages) { (image, currentPath, error) in
            DispatchQueue.main.async {
                if let image = image,  currentPath == path {
                    completion(image, path, nil)
                } else {
                    
                    RepoWebImage().obtainImage(path: path) { (image, error) in
                        guard let image = image else {
                            //Default image?
                            return
                        }

                        completion(image, path, nil)
                        
                        UtilityKoom.convertImageToData(image: image, name: path) { (data, currentPath) in
                            guard path == currentPath, let data = data else { return }
                            ProxyFile().writeFileTo(path: path, data: data, directory: Constants.directoryImages) { (sucess, error) in }
                        }
                    }
                }
            }
        }
    }
}
