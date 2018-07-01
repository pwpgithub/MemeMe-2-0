//
//  MMFCollectionViewController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionCell"

class SentMMCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: Outlets
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Life Cycle views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFlowLayout(flowLayout, view.frame)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
        
        subscribeDeviceOrientation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        flowLayout.invalidateLayout()
        unsubscribeDevicOrientation()
    }
}


//MARK: - SentMMCollectionViewController (Configure flowLayout)

extension SentMMCollectionViewController  {
    
    //MARK: Catch device rotation
    @objc func deviceOrientationChaged(_ notification: Notification) {
        myFlowLayout(flowLayout, (self.collectionView?.bounds)!)
    }
    
    //MAKR: Set flow layout
    func myFlowLayout(_ layout: UICollectionViewFlowLayout, _ rect: CGRect){
        
        layout.scrollDirection = .vertical

        let screenWidth = rect.size.width
        let estimatedItemSize = CGSize(width: 110, height: 110)
        let spaceX: CGFloat = 3.0
        let numOfItemsInRow = floorf((Float((screenWidth - 6 + spaceX) / (estimatedItemSize.width + spaceX))))
        let itemWidth: CGFloat = (screenWidth -  6 - spaceX * CGFloat(numOfItemsInRow - 1)) / CGFloat(numOfItemsInRow)
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 3.0
        layout.minimumLineSpacing = 3.0
        
    }
    
    //MARK: Set Section UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 20, right: 3)
    }
}


//MARK: - SentMMCollectionViewController (UICollectionViewDelegate)

extension SentMMCollectionViewController {
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MMFDetailViewController") as! MMFDetailViewController
        
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        let meme = appDelegate.memes[indexPath.item]
        
        detailVC.memeDetail = meme
        
        self.navigationController?.show(detailVC, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

//MARK: - SentMMCollectionViewController (UICollectionViewDataSource)

extension SentMMCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMMCollectionViewCell
        
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        let meme = appDelegate.memes[indexPath.item]
        cell.configureCollectionViewCell(meme)
        
        return cell
    }
}

//MARK: - SentMMCollectionViewController (Device orientation Notification)

extension SentMMCollectionViewController {
    func subscribeDeviceOrientation() {
        //UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChaged(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    func unsubscribeDevicOrientation() {
        NotificationCenter.default.removeObserver(self, name: .UIDeviceOrientationDidChange, object: nil)
        //UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}
