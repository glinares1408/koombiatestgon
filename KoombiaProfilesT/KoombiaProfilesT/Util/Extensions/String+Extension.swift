//
//  String+Extension.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import Foundation

extension String {
    func convertToFilePath() -> String? {
        guard let temporalString = self.split(separator: "/").last?.split(separator: ".").first else {
            return nil
        }
        
        return String(temporalString)
    }
}
