//
//  UnitTestHelper.swift
//  KoombiaProfilesTTests
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import Foundation

enum MockJSONModel: String {
    case showAllPosts = "AllPosts"
}

struct UnitTestHelper {
    static func decodeJson<T: Codable>(fileName: String, model: T.Type) -> T? {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let model = try? decoder.decode(model.self, from: data)
        else {
            return nil
        }
        
        return model
    }
}
