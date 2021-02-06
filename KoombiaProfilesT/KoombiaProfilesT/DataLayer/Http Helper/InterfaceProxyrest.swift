//
//  InterfaceProxyrest.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation
import Alamofire

protocol InterfaceProxyRest {
    func perfromStandartRequest(urlString: String, completion: @escaping ProxyRestCompletionClosure)
    func processResponse(response: AFDataResponse<Any>, completion: @escaping ProxyRestCompletionClosure)
}
