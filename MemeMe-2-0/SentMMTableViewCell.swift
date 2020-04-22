//
//  SentMMTableViewCell.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 02/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

//MARK: - SentMMTableViewCell: UITableViewCell

class SentMMTableViewCell: UITableViewCell {
    
    var meme: MMFMeme!
    
    //MARK: Outlets
    @IBOutlet weak var tableCellImageView: UIImageView!
    @IBOutlet weak var tableCellLabel: UILabel!
    @IBOutlet weak var imageLabelT: UILabel!
    @IBOutlet weak var imageLabelB: UILabel!
    
    //MARK: Configure UI of the table view cell
        
    func configureTableViewCell(_ meme: MMFMeme) {
        
        var topText = meme.stringT as String
        var bottomText = meme.stringB as String
        
        if topText == "TOP" {
            topText = ""
        }
        
        if bottomText == "BOTTOM" {
            bottomText = ""
        }
        
        imageLabelT.text = meme.stringT
        imageLabelB.text = meme.stringB
        
        tableCellLabel.text = "\(topText)...\(bottomText)"
        tableCellImageView.image = meme.originalImage
        
        tableCellImageView.clipsToBounds = true
        
        configureImageLabelFont(imageLabelT)
        configureImageLabelFont(imageLabelB)
        
        imageLabelT.isHidden = imageLabelT.text == "TOP"
        tableCellLabel.isHidden = tableCellLabel.text == "TOP"
        imageLabelB.isHidden = imageLabelB.text == "BOTTOM"
    }
    
    //MARK: Configure cell Image Label UI
    
    func configureImageLabelFont(_ label: UILabel) {
        
        let labelTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue) : UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue) : -3.0,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont.init(name: "HelveticaNeue-CondensedBold", size: 17)!
        ]
        
        let text = label.text
        
        label.attributedText = NSAttributedString(string: text!, attributes: labelTextAttributes)
        label.textAlignment = .center
        
    }
}
