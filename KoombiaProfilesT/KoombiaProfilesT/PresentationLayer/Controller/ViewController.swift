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
    private let titleText = "Home"
    private let tryAgainText = "Try again"
    private let cancelText = "Cancel"
    private let errorText = "Error"
    private let errorMessageText = "Error fetching data, please try again"
    
    let viewModel = HomePostViewModel()
    var currentImagePath = String()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Posts Data ...", attributes: attributes)
        return refreshControl
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        return activityIndicator
    }()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 500
            tableView.allowsSelection = true
            
            let nib = UINib(nibName: HomePostTableViewCell.defaultReuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: HomePostTableViewCell.defaultReuseIdentifier)
            
            let nibSection = UINib(nibName: UserInformationTableViewHeaderView.defaultReuseIdentifier, bundle: Bundle.main)
            tableView.register(nibSection, forHeaderFooterViewReuseIdentifier: UserInformationTableViewHeaderView.defaultReuseIdentifier)
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    @IBSegueAction func presentPreviewController(_ coder: NSCoder) -> PreviewImageViewController? {
        return PreviewImageViewController(coder: coder, path: currentImagePath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupData()
    }
    
    private func setupInterface() {
        view.backgroundColor = UIColor.white
        tableView.refreshControl = refreshControl
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        navigationItem.title = titleText
    }
    
    @objc private func setupData() {
        activityIndicator.startAnimating()
        viewModel.getPosts { [weak self] (success, error) in
            guard let self = self else { return }
            
            guard success else {
                self.presentalert()
                return
            }
            
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc private func refreshControlValueChanged() {
        viewModel.removeAllData { [weak self] (sucess, error) in
            guard let self = self, sucess else { return }
            
            self.viewModel.getPosts {[weak self] (success, error) in
                guard let self = self else { return }
                
                guard success else {
                    self.presentalert()
                    return
                }
                
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func presentalert() {
        let alert = UIAlertController(title: errorText, message: errorMessageText, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: tryAgainText, style: .default) { [weak self] (alert) in
            self?.setupData()
        }
        
        let cancelAction = UIAlertAction(title: cancelText, style: .cancel) { (alert) in }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
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
        
        cell.delegate = self
        
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
        guard
            let item = viewModel.homePublication?[safe: indexPath.section]
        else {
            return
        }
        
        currentImagePath = item.post.mainPic ?? String()
        performSegue(withIdentifier: "show_preview_image", sender: nil)
    }
}

extension ViewController: CollectionTapDelegate {
    func imageTapped(path: String) {
        currentImagePath = path
        performSegue(withIdentifier: "show_preview_image", sender: nil)
    }
}
