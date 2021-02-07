//
//  HomePostTableViewCell.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import UIKit

class HomePostTableViewCell: UITableViewCell {
    
    var collectionPics: [PicAuxiliarItem]?
    private let customSpace: CGFloat = 10
    private let itemHeight: CGFloat = 100;
    
    @IBOutlet weak var topContentView: UIView! {
        didSet {
            topContentView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var topImageView: UIImageView! {
        didSet {
            topImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var bottomContentView: UIView! {
        didSet {
            bottomContentView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var bottomCollectionView: UICollectionView! {
        didSet {
            bottomCollectionView.backgroundColor = .clear
            bottomCollectionView.bounces = true
            bottomCollectionView.isUserInteractionEnabled = true
            bottomCollectionView.isScrollEnabled = true
                       
                       let nib = UINib(nibName: BottomCollectionViewCell.defaultReuseIdentifier, bundle: nil)
            bottomCollectionView.register(nib, forCellWithReuseIdentifier: BottomCollectionViewCell.defaultReuseIdentifier)
            //bottomCollectionView.collectionViewLayout = collectionLayoutFlow()
            bottomCollectionView.dataSource = self
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topImageView.backgroundColor = nil
        topImageView.image = nil
        topContentView.isHidden = false
        topContentView.isHidden = false
    }
    
    func setupTopImage(image: UIImage?) {
        topImageView.image = image
    }
    
    func hide() {
        topContentView.isHidden = true
        topImageView.backgroundColor = UIColor.systemPink
    }
    
    func setupData(homePost: HomePostAuxiliar) -> Bool {
        let isContainingTopBox: Bool
        switch homePost.post.type {
        case .boxTopImage:
            topContentView.isHidden = false
            bottomContentView.isHidden = true
            isContainingTopBox = true
        case .boxBottomImages:
            topContentView.isHidden = true
            bottomContentView.isHidden = false
            setupCollectionView(pics: homePost.post.pics, type: homePost.post.type)
            isContainingTopBox = false
        case .twoBoxesTopImageTwoBottomImages, .twoBoxesTopBottomImages:
            topContentView.isHidden = false
            bottomContentView.isHidden = false
            setupCollectionView(pics: homePost.post.pics, type: homePost.post.type)
            isContainingTopBox = true
        default:
            topContentView.isHidden = false
            bottomContentView.isHidden = false
            isContainingTopBox = true
        }
        
        return isContainingTopBox
    }
    
    private func setupCollectionView(pics: [PicAuxiliarItem], type: HomePostsType) {
        let width: CGFloat
        let screenSizeWidth = UIScreen.main.bounds.size.width
        switch type {
        case .boxTopImage:
            width = screenSizeWidth
        case .boxBottomImages:
            width = (screenSizeWidth / 2) - ((customSpace * 3) / 2)
        case .twoBoxesTopImageTwoBottomImages:
            width = (screenSizeWidth / 2) - ((customSpace * 3) / 2)
        case .twoBoxesTopBottomImages:
            width = screenSizeWidth / 3
        case .unknown:
            width = .zero
        }
        
        bottomCollectionView.collectionViewLayout = collectionLayoutFlow(itemWidth: width)
        collectionPics = pics
        bottomCollectionView.reloadData()
    }
    
    func collectionLayoutFlow(itemWidth: CGFloat) -> UICollectionViewFlowLayout {
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.itemSize =  CGSize(width: itemWidth , height: itemHeight)
        collectionFlow.scrollDirection = .horizontal
        collectionFlow.minimumLineSpacing = customSpace
        collectionFlow.minimumInteritemSpacing = .zero
        collectionFlow.sectionInset = UIEdgeInsets(top: customSpace, left: customSpace, bottom: customSpace, right: customSpace)
        
        return collectionFlow
    }
}

extension HomePostTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPics?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCollectionViewCell.defaultReuseIdentifier, for: indexPath)
        
        guard
            let cell = collectionCell as? BottomCollectionViewCell,
            let pictureAuxiliary = collectionPics?[safe: indexPath.row]
        else {
            return collectionCell
        }
        
        if let image = pictureAuxiliary.picImage {
            cell.pictureImageView.image = image
        } else {
            CatchImagesUseCase().summonImage(path: pictureAuxiliary.pic) { (image, path, error) in
                guard path == pictureAuxiliary.pic else { return }
                pictureAuxiliary.picImage = image
                cell.pictureImageView.image = image
            }
        }
        
        return cell
    }
}
