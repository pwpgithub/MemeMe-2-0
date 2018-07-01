//
//  MMFCaptionTextFieldDelegate.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import Foundation
import UIKit

//MARK: - MMFCaptionTextFieldDelegate: NSObject, UITextFieldDelegate

class MMFCaptionTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = textField.text! as NSString
        text = text.replacingCharacters(in: range, with: string) as NSString
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
        
        if (textField.text?.isEmpty)! {
            textField.text = textField.placeholder
        }
    }
}
