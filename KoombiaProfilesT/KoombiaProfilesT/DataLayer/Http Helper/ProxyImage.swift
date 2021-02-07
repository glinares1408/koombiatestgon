//
//  ProxyImage.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit
import Alamofire
import AlamofireImage

typealias ProxyImageCompletionClosure = (_ image: UIImage?, _ error: Error?) -> Void

enum ProxyImageError: Error {
    case noImageData
    case worngPath
    case failure
}

class ProxyImage {
    static let shared = ProxyImage()
    
    func performStandartRequestForImage(path: String, completion: @escaping ProxyImageCompletionClosure) {
        AF.request(path).responseImage { (response) in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let image):
                    completion(image, nil)
                case .failure(let error):
                    completion(nil, ProxyImageError.failure)
                }
            }
        }
    }
}
