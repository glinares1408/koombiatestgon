//
//  RepoWebImage.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit
import Foundation

typealias RepoWebImageCompletionClosure = (_ image: UIImage?, _ error: Error?) -> Void

class RepoWebImage {
    func obtainImage(path: String, completion: @escaping RepoWebImageCompletionClosure) {
        ProxyImage().performStandartRequestForImage(path: path) { (image, error) in
            completion(image, error)
        }
    }
}
