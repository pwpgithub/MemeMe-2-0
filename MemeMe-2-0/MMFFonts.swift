//
//  MMFFonts.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 08/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import Foundation
import UIKit

struct  MMFFonts {
    
    var fontNames: [String] = [String]()
    var font: UIFont!
    var fontSize: CGFloat!
    var fonts: [UIFont]!
    
    

    mutating func allFonts() {
        let fontFamilyNames = UIFont.familyNames
        for fontFamilyName in fontFamilyNames {
            fontNames = UIFont.fontNames(forFamilyName: fontFamilyName)
            for fontName in fontNames {
                font = UIFont(name: fontName, size: fontSize)
                print(fontName)
                
                fonts.append(font)
            }
        }
        print(fonts)
    }
}
