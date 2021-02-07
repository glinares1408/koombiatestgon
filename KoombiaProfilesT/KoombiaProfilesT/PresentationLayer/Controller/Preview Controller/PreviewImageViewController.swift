//
//  PreviewImageViewController.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 7/02/21.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    let path: String
    
    @IBOutlet weak var previewImageView: UIImageView! {
        didSet {
            previewImageView.contentMode = .scaleAspectFit
            previewImageView.backgroundColor = .clear
        }
    }
    
    init?(coder: NSCoder, path: String) {
        self.path = path
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupImage()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurredEffectView)
        
        view.sendSubviewToBack(blurredEffectView)
        
        previewImageView.alpha = 1
    }
    
    private func setupImage() {
        CatchImagesUseCase().summonImage(path: path) { [weak self] (image, path, error) in
            self?.previewImageView.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.previewImageView.alpha = 1
        }
    }
}
