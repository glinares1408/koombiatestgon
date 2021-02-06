//
//  ViewController.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = HomePostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
        
        let myButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        myButton.center = view.center
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        myButton.setTitle("Click here", for: .normal)
        view.addSubview(myButton)
        
    }
    
    @objc func buttonTapped() {
        viewModel.getPosts { [weak self] (success, error) in
           
        }
    }


}

