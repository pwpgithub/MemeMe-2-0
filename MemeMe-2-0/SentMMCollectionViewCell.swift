//
//  SentMMCollectionViewCell.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 02/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

//MARK: - SentMMCollectionViewCell: UICollectionViewCell

class SentMMCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var collectionCellImageView: UIImageView!
    @IBOutlet weak var collectionCellLabelT: UILabel!
    @IBOutlet weak var collectionCellLabelB: UILabel!
    
    //MARK: Configure UI of collection view cell
    func configureCollectionViewCell(_ meme: MMFMeme) {
        
        collectionCellLabelT.text = meme.stringT
        collectionCellLabelB.text = meme.stringB
        
        collectionCellImageView.image = meme.originalImage
        
        collectionCellImageView.clipsToBounds = true
        
        configureImageLabelFont(collectionCellLabelT)
        configureImageLabelFont(collectionCellLabelB)
        
        collectionCellLabelT.isHidden = collectionCellLabelT.text == "TOP"
        collectionCellLabelB.isHidden = collectionCellLabelB.text == "BOTTOM"
    }
    
    //MARK: Configure cell image label UI
    func configureImageLabelFont(_ label: UILabel) {
        
        let labelTextAttributes: [NSAttributedString.Key : Any] = [
            
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue) : UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue) : -3.0,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.init(name: "HelveticaNeue-CondensedBold", size: 17)!
        ]
        
        let text = label.text
        
        label.attributedText = NSAttributedString(string: text!, attributes: labelTextAttributes)
        label.textAlignment = .center
        
    }
}
