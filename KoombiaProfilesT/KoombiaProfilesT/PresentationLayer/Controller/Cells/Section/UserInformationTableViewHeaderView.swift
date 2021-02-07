//
//  UserInformationTableViewHeaderView.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit

class UserInformationTableViewHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInterface()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userPhotoImageView.image = nil
        nameLabel.text = nil
        emailLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setupInterface() {
        contentView.backgroundColor = UIColor.white
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.height / 2
        userPhotoImageView.clipsToBounds = true
        userPhotoImageView.backgroundColor = UIColor.blue
        
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        emailLabel.font = UIFont.italicSystemFont(ofSize: 14)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func setupProperties(name: String, email: String, date: String) {
        nameLabel.text = name
        emailLabel.text = email
        dateLabel.text = date
    }
}
