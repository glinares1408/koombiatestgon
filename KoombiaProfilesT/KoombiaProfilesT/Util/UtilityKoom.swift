//
//  UtilityKoom.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import Foundation
import UIKit

struct UtilityKoom {
    static func convertImageToData(image: UIImage?, name: String?, closure: @escaping (_ data: Data?, _ nickname: String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let image = image, let pngData = image.pngData() {
                closure(pngData, name)
            } else if let image = image, let jpgData = image.jpegData(compressionQuality: 0.5) {
                closure(jpgData, name)
            } else {
                closure(nil, nil)
            }
        }
    }
}
