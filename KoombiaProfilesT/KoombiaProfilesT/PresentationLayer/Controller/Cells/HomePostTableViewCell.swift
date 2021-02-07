//
//  HomePostTableViewCell.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topContentView: UIView!
    
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var bottomContentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topImageView.backgroundColor = nil
        topImageView.image = nil
    }
    
    func hide() {
        topContentView.isHidden = true
        topImageView.backgroundColor = UIColor.systemPink
    }
    
}
