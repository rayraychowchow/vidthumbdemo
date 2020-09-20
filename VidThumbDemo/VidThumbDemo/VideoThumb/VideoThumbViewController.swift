//
//  VideoThumbViewController.swift
//  VidThumbDemo
//
//  Created by Ray Chow on 20/9/2020.
//

import Foundation
import UIKit
import RxSwift
import AVKit

class VideoThumbViewController: BaseViewController<VideoThumbInteractor, VideoThumbPresenter, BaseRouter> {
    @IBOutlet weak var videoThumbCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.setupAVSession()
        presenter.getDemoVideos().subscribe().disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        if let flowLayout = videoThumbCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = UIScreen.main.bounds.size.width / 2 - 20
            flowLayout.itemSize = CGSize(width: itemWidth, height: (itemWidth * 360 / 640))
        }
        videoThumbCollectionView.register(UINib(nibName: VideoThumbCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: VideoThumbCollectionViewCell.reuseId)
    }
    
    override func setupRX() {
        super.setupRX()
        presenter.avAssets
            .bind(to: videoThumbCollectionView.rx
                    .items(cellIdentifier: VideoThumbCollectionViewCell.reuseId,
                           cellType: VideoThumbCollectionViewCell.self))
            { index, asset, cell in
            cell.setupCell(with: asset)
        }.disposed(by: disposeBag)
    }
}
