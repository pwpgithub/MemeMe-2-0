//
//  MMFDetailViewController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 02/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit
import Foundation

//MAKR: - MMFDetailViewController: UIViewController

class MMFDetailViewController: UIViewController, UIScrollViewDelegate {

    //MARK: Properties
    var memeDetail: MMFMeme!
    
    
    //MARK: Outlets
    @IBOutlet var memeImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memeImageView.image = memeDetail.memeImage
        //print("\n\nIn Detail: \(memeDetail)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear in Detail")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func setupScrollView () {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.pinchGestureRecognizer?.isEnabled = true
        scrollView.panGestureRecognizer.isEnabled = true
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return memeImageView
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
        let editorVC: MMFEditorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MMFEditorViewController") as! MMFEditorViewController
        
        editorVC.memeEditor = memeDetail
        self.present(editorVC, animated: false, completion: {
            print("present editor")
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
}
