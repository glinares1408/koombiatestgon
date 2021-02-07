//
//  BottomCollectionViewCell.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView! {
        didSet {
            pictureImageView.contentMode = .scaleAspectFill
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.backgroundColor = nil
        pictureImageView.image = nil
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
