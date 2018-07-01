//
//  MMFMeme.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import Foundation
import UIKit

//MARK: - MMFMeme

struct MMFMeme {
    var stringT: String!
    var stringB: String!
    var originalImage: UIImage!
    var memeImage: UIImage!
    
    init(stringT: String, stringB: String, originalImage: UIImage, memeImage: UIImage) {
        self.stringT = stringT
        self.stringB = stringB
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
}
