//
//  ProxyRest.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation
import Alamofire

typealias ProxyRestCompletionClosure = (_ response: Data?,_ error: Error?) -> Void

enum ProxyRestError: Error {
    case wrongURL
    case noConnection
    case noData
    case serverError
    case unknownError
}

class ProxyRest {}

extension ProxyRest: InterfaceProxyRest {
    
    func perfromStandartRequest(urlString: String, completion: @escaping ProxyRestCompletionClosure) {
        guard let url = URL(string: urlString) else {
            completion(nil, ProxyRestError.wrongURL)
            return
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(queue: queue, options: .allowFragments) { (response: AFDataResponse<Any>) in
            DispatchQueue.main.async {
                self.processResponse(response: response) { (data, error) in
                    completion(data, error)
                }
            }
        }
    }
    
    func processResponse(response: AFDataResponse<Any>, completion: @escaping ProxyRestCompletionClosure) {
        switch response.response?.statusCode {
        case Constants.HTTPStatusCode.ok.rawValue:
            guard let data = response.data else {
                completion(nil, ProxyRestError.noData)
                return
            }
            completion(data, nil)
        case Constants.HTTPStatusCode.serverError.rawValue:
            completion(nil, ProxyRestError.serverError)
        default:
            completion(nil, ProxyRestError.unknownError)
        }
    }
}
