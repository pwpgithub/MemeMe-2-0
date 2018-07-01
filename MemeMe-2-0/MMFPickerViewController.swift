//
//  MMFPickerViewController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 09/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

class MMFPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var textField: UITextField!
    
    
    var textColor: UIColor = UIColor.white
    var textSize: CGFloat = CGFloat(40.0)
    var textFontDescriptor: UIFontDescriptor = UIFontDescriptor.init(name: "HelveticaNeue-CondensedBlack", size: 40)
    var textFont: UIFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    
    var fontDescriptors: [UIFontDescriptor] = [
        UIFontDescriptor.init(name: "HelveticaNeue-CondensedBlack", size: 40),
        UIFontDescriptor.init(name: "AppleColorEmoji", size: 40),
        UIFontDescriptor.init(name: "KhmerSangamMN", size: 40),
        UIFontDescriptor.init(name: "Markerfelt-Thin", size: 40),
        UIFontDescriptor.init(name: "SnellRoundhand-Black",  size: 40),
        UIFontDescriptor.init(name: "BradleyHandITCTT-Bold", size: 40),
        UIFontDescriptor.init(name: "Papyrus", size: 40),
        UIFontDescriptor.init(name: "SavoyeLetPlain", size: 40),
        UIFontDescriptor.init(name: "TimesNewRomanPS-ItalicMT", size: 40),
        UIFontDescriptor.init(name: "AppleSDGothicNeo-Bold", size: 40),
        UIFontDescriptor.init(name: "BodoniSvtyTwoITCTT-Book", size: 40),
        UIFontDescriptor.init(name:  "BodoniSvtyTwoITCTT-BookIta", size: 40),
        UIFontDescriptor.init(name: "Baskerville-Bold", size: 40),
        UIFontDescriptor.init(name: "PartyLetPlain", size: 40),
        UIFontDescriptor.init(name: "ChalkboardSE-Bold", size: 40),
        UIFontDescriptor.init(name: "Noteworthy-Bold", size: 40),
        UIFontDescriptor.init(name: "Chalkduster", size: 40),
        UIFontDescriptor.init(name: "Didot-Bold", size: 40),
        ]
    
    @IBOutlet weak var fontPickerView: UIPickerView!
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var magentaButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var cyanButton: UIButton!
    @IBOutlet weak var brownButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!

    let colorButtons: [UIButton] = [UIButton]()
    
    init(_ textAttributes: [NSAttributedStringKey : Any]) {
        textColor = textAttributes[NSAttributedStringKey.foregroundColor] as! UIColor
        textFont = textAttributes[NSAttributedStringKey.font] as! UIFont
        textSize = textFont.pointSize
        textFontDescriptor = textFont.fontDescriptor
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...fontDescriptors.count {
            let descriptor = fontDescriptors[i]
            
            if descriptor.postscriptName == textField.font?.fontDescriptor.postscriptName {
                self.fontPickerView.selectRow(i, inComponent: 1, animated: true)
                break
            }
        }
        
        fontSizeSlider.minimumValue = 14.0
        fontSizeSlider.maximumValue = 60.0
        fontSizeSlider.value = 40.0
        
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontDescriptors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontDescriptors[row].postscriptName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.font = UIFont.init(descriptor: fontDescriptors[row], size: 40)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        let hue = CGFloat(row) / CGFloat(fontDescriptors.count)
        label.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        label.text = fontDescriptors[row].postscriptName
        let font = UIFont(descriptor: fontDescriptors[row], size: 28)
        
        label.font = font
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }
    
    @IBAction func colorButtonSelected(_ sender: UIButton) {
        //textField.textColor = sender.backgroundColor
        sender.isSelected = true
        sender.isEnabled = sender.isSelected == false
        self.fontPickerView.backgroundColor = sender.backgroundColor
    }
    
    @IBAction func fontSizeSliderValueChanged(_ sender: Any) {
        let row = self.fontPickerView.selectedRow(inComponent: 1)
        textField.font = UIFont(descriptor: fontDescriptors[row], size: CGFloat(fontSizeSlider.value))
    }
}



extension MMFPickerViewController {
    
   

    
}
