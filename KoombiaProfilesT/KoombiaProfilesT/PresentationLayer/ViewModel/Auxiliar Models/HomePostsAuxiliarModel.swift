//
//  HomePostsAuxiliarModel.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import Foundation
import UIKit

enum HomePostsType: Int {
    case unknown
    case boxTopImage
    case boxBottomImages
    case twoBoxesTopImageTwoBottomImages
    case twoBoxesTopBottomImages
}

class HomePostAuxiliar {
    let uid: String
    let name: String
    let email: String
    let profilePic: String
    var profilePicImage: UIImage?
    let dateProfile: String
    let post: KoombeaPostAuxiliar
    
    init(uid: String, name: String, email: String, profilePic: String, profilePicImage: UIImage?, dateProfile: String, post: KoombeaPostAuxiliar) {
        self.uid = uid
        self.name = name
        self.email = email
        self.profilePic = profilePic
        self.profilePicImage = profilePicImage
        self.dateProfile = dateProfile
        self.post = post
    }
}

class KoombeaPostAuxiliar {
    let id: Int
    let date: String
    let type: HomePostsType
    let mainPic: String?
    var mainPicImage: UIImage?
    let pics: [PicAuxiliarItem]
    
    init(id: Int, date: String, type: HomePostsType, mainPic: String?, mainPicImage: UIImage?, pics: [PicAuxiliarItem]) {
        self.id = id
        self.date = date
        self.type = type
        self.mainPic = mainPic
        self.pics = pics
    }
}

class PicAuxiliarItem {
    let pic: String
    var picImage: UIImage?
    
    init(pic: String, picImage: UIImage? = nil) {
        self.pic = pic
        self.picImage = picImage
    }
}
