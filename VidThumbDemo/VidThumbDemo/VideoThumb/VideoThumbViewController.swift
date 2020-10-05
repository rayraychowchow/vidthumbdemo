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

class VideoThumbViewController: VidThumbViewController<VideoThumbInteractor, VideoThumbPresenter, BaseRouter> {
    @IBOutlet weak var imgViewFakeBackground: UIImageView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstaintForNoSafeArea: NSLayoutConstraint!
    @IBOutlet weak var videoThumbCollectionView: UICollectionView!
    static let stopAllVideo = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getDemoVideos().subscribe().disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setupUI() {
        super.setupUI()
        if let flowLayout = videoThumbCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = UIScreen.main.bounds.size.width / 2 - 20
            flowLayout.itemSize = CGSize(width: itemWidth, height: (itemWidth * 360 / 640))
        }
        videoThumbCollectionView.register(UINib(nibName: VideoThumbCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: VideoThumbCollectionViewCell.reuseId)
        updateLayout()
    }
    
    func updateLayout() {
        let window = UIApplication.shared.keyWindow
        if let topPadding = window?.safeAreaInsets.top {
            if (topPadding == 0) {
                collectionViewHeightConstraint.isActive = false
                imgViewFakeBackground.image = UIImage(named: "fake_no_safe_area_background")
            } else {
                collectionViewHeightConstaintForNoSafeArea.isActive = false
            }
        }
    }
    
    override func setupRX() {
        super.setupRX()
        presenter.avAssets
            .bind(to: videoThumbCollectionView.rx
                    .items(cellIdentifier: VideoThumbCollectionViewCell.reuseId,
                           cellType: VideoThumbCollectionViewCell.self))
            { index, videoEntity, cell in
            cell.setupCell(with: videoEntity)
        }.disposed(by: disposeBag)
        
        videoThumbCollectionView.rx.willDisplayCell
            .subscribe { cell, indexPath in
                if let videoThumbCell = cell as? VideoThumbCollectionViewCell {
                    videoThumbCell.playVideo()
                }
            }.disposed(by: disposeBag)

        videoThumbCollectionView.rx.didEndDisplayingCell
            .subscribe { cell, indexPath in
                if let videoThumbCell = cell as? VideoThumbCollectionViewCell {
                    videoThumbCell.pauseVideo()
                }
            }.disposed(by: disposeBag)
        
        videoThumbCollectionView.rx.itemSelected.subscribe { [weak self] indexPathEvent in
            if let indexPath = indexPathEvent.element, let cell = self?.videoThumbCollectionView.cellForItem(at: indexPath) as? VideoThumbCollectionViewCell {
                cell.restart()
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        VideoThumbViewController.stopAllVideo.onNext(true)
        presenter.cleanVideos()
        navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
