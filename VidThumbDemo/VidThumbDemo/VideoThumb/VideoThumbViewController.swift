//
//  VideoThumbViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import RxSwift

class VideoThumbViewController: BaseViewController<VideoThumbInteractor, VideoThumbPresenter, BaseRouter> {
    @IBOutlet weak var videoThumbCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        if let flowLayout = videoThumbCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = UIScreen.main.bounds.size.width / 2
            flowLayout.itemSize = CGSize(width: itemWidth, height: (itemWidth * 360 / 640))
        }
        videoThumbCollectionView.register(UINib(nibName: VideoThumbCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: VideoThumbCollectionViewCell.reuseId)
    }
    
    override func setupRX() {
        super.setupRX()
        
    }
}
