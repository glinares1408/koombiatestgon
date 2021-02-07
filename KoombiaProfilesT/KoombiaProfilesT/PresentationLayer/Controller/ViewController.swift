//
//  ViewController.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit
import CouchbaseLiteSwift

import Alamofire

class ViewController: UIViewController {
    
    private let profileHeaderHeight: CGFloat = 70
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 500
            tableView.allowsSelection = false
            
            let nib = UINib(nibName: HomePostTableViewCell.defaultReuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: HomePostTableViewCell.defaultReuseIdentifier)
            
            let nibSection = UINib(nibName: UserInformationTableViewHeaderView.defaultReuseIdentifier, bundle: Bundle.main)
            tableView.register(nibSection, forHeaderFooterViewReuseIdentifier: UserInformationTableViewHeaderView.defaultReuseIdentifier)
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    let viewModel = HomePostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        // Do any additional setup after loading the view.
        
        let myButton = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        myButton.setTitle("Click here", for: .normal)
        view.addSubview(myButton)
        
    }
    
    @objc func buttonTapped() {
        viewModel.getPosts { [weak self] (success, error) in
            self?.tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.homePublication?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: HomePostTableViewCell.defaultReuseIdentifier, for: indexPath)
        
        guard
            let cell = tableViewCell as? HomePostTableViewCell,
            let item = viewModel.homePublication?[safe: indexPath.section]
        else {
            return tableViewCell
        }
        
        let isContainingTopBox = cell.setupData(homePost: item)
        
        if isContainingTopBox {
            guard let image = item.post.mainPicImage else {
                viewModel.setupImage(path: item.post.mainPic ?? String()) { (image, error) in
                    item.post.mainPicImage = image
                    cell.setupTopImage(image: image)
                }
                return cell
            }
            
            cell.setupTopImage(image: image)
        }
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: UserInformationTableViewHeaderView.defaultReuseIdentifier)
        guard
            let headerView = header as? UserInformationTableViewHeaderView,
            let userInfo = viewModel.homePublication?[safe: section]
        else {
            return nil
        }
        
        if let image = userInfo.profilePicImage {
            headerView.setupUserProfileImage(image: image)
        } else {
            viewModel.setupImage(path: userInfo.profilePic) { (image, error) in
                userInfo.profilePicImage = image
                headerView.setupUserProfileImage(image: image)
            }
        }
        
        headerView.setupProperties(name: userInfo.name, email: userInfo.email, date: userInfo.dateProfile)//Improve date
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return profileHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
