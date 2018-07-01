//
//  MMFEditorViewController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit
import Foundation

// Menu Controller
let menuController: UIMenuController = UIMenuController()


// MARK: - MMFEditorViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIPopoverControllerDelegate

class MMFEditorViewController: UIViewController, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate, UIScrollViewDelegate {
    
    //MARK: Properites
    
    var memeEditor: MMFMeme!
    let mmCaptionTextFieldDelegate = MMFCaptionTextFieldDelegate()
    
    var myFontNames: [String] = ["HelveticaNeue-CondensedBlack", "AppleColorEmoji", "KhmerSangamMN", "Markerfelt-Thin", "SnellRoundhand-Black", "BradleyHandITCTT-Bold", "Papyrus", "SavoyeLetPlain", "TimesNewRomanPS-ItalicMT", "AppleSDGothicNeo-Bold", "BodoniSvtyTwoITCTT-Book", "BodoniSvtyTwoITCTT-BookIta", "Baskerville-Bold", "PartyLetPlain", "ChalkboardSE-Bold", "Noteworthy-Bold", "Chalkduster", "Didot-Bold"]
    
    var selectedFontName: String = "HelveticaNeue-CondensedBlack"
    
    
    
    //MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextFieldT: UITextField!
    @IBOutlet weak var captionTextFieldB: UITextField!
    @IBOutlet weak var toolBarT: UIToolbar!
    @IBOutlet weak var toolBarB: UIToolbar!
    @IBOutlet weak var shareBBItem: UIBarButtonItem!
    @IBOutlet weak var cancelBBItem: UIBarButtonItem!
    @IBOutlet weak var cameraBBItem: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontPickerView: UIPickerView!
    
    @IBOutlet weak var fontView: UIView!
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextField Delegate
        captionTextFieldT.delegate = mmCaptionTextFieldDelegate
        captionTextFieldB.delegate = mmCaptionTextFieldDelegate
        
        //Set TextField UI
        initializeUICaptionTextField(captionTextFieldT)
        initializeUICaptionTextField(captionTextFieldB)
        
        print("\n\nIn Editor 'viewDidLoad': \(memeEditor)\n")
        updateEditorView()
        setupMenuItem()
        setupSlider()
        setupScrollView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Bring the view back to the default position
        if view.frame.origin.y > 0 {
            view.frame.origin.y = 0
        }
        print("\n\nIn Editor 'viewWillAppear': \(memeEditor)\n")
        updateBBItemsStatus()
        fontView.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\n\nIn Editor 'viewWillDisappear': \(memeEditor)\n")
    }
    
    
    func setupScrollView () {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.pinchGestureRecognizer?.isEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setupSlider () {
        fontSizeSlider.minimumValue = 14.0
        fontSizeSlider.maximumValue = 60.0
        fontSizeSlider.value = 40.0
    }
    
    @IBAction func fontSizeSliderValueChanged(_ sender: UISlider) {
        
        captionTextFieldT.font = UIFont(name: selectedFontName, size: CGFloat(sender.value))
        captionTextFieldB.font = UIFont(name: selectedFontName, size: CGFloat(sender.value))
    }
    
    
    @IBAction func fontColorButtonClicked(_ sender: UIButton) {
        
        captionTextFieldT.textColor = sender.backgroundColor
        captionTextFieldB.textColor = sender.backgroundColor
    }
    
    // MARK: Actions
    
    // Tap background to dismiss keyboard
    @IBAction func backgroundTapped(_ sender: Any) {
        print("backgroundTapped")
        view.endEditing(true)
        fontView.isHidden = true
    }
    
    
    
    @IBAction func cancelBBItemPressed(_ sender: Any) {
        imageView.image = nil
        //captionTextFieldT.text = "TOP"
        //captionTextFieldB.text = "BOTTOM"
        initializeUICaptionTextField(captionTextFieldT)
        initializeUICaptionTextField(captionTextFieldB)
        updateBBItemsStatus()
        
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        print("\n\nmemes: \(appDelegate.memes)")
        
        if appDelegate.memes.count > 0 {
            print("viewCounts: \(String(describing: self.navigationController?.viewControllers.count))")
            self.dismiss(animated: false, completion: {
                NotificationCenter.default.post(name: .UIDeviceOrientationDidChange, object: nil)
            })
        }
    }
    
    
    @IBAction func shareBBItemPressed(_ sender: Any) {
        
        let activityVC = UIActivityViewController(activityItems: [makeMemeImage()], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.saveMeme()
                self.dismiss(animated: false, completion: {
                    // Device orientation change
                    NotificationCenter.default.post(name: .UIDeviceOrientationDidChange, object: nil)
                })
            }
        }
        
        // iPad
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            activityVC.popoverPresentationController?.sourceView = self.view
        }
        
        self.present(activityVC, animated: false, completion: nil)
    }
    
    
    //MARK: Configure BarButtonItmes UI
    func updateBBItemsStatus() {
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        cancelBBItem.isEnabled = appDelegate.memes.count != 0
        shareBBItem.isEnabled = imageView.image != nil
        cameraBBItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}


//MARK: - MMFEditorViewController (UImenuItem change font)

extension MMFEditorViewController {
    @objc func changeFontView(_ menuItem: UIMenuItem) {
        captionTextFieldT.resignFirstResponder()
        captionTextFieldB.resignFirstResponder()
        fontView.isHidden = false
    }
    
    
    func setupMenuItem () {
        let menuItem = UIMenuItem.init(title: "ChangeFont", action: #selector(changeFontView(_:)))
        menuController.menuItems = [menuItem]
    }
    
}

//MARK: - MMFEditorViewController: UIPickerViewelegate, UIPickerViewDataSource

extension MMFEditorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myFontNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myFontNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 320
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        let hue = CGFloat(row) / CGFloat(myFontNames.count)
        label.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        label.text = myFontNames[row]
        let font = UIFont(name: label.text!, size: 28)
        
        label.font = font
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myFont = UIFont(name: myFontNames[row], size: CGFloat(fontSizeSlider.value))
        selectedFontName = myFontNames[row]
        captionTextFieldT.font = myFont
        captionTextFieldB.font = myFont
    }
    
}


//MARK: - MMFEditorViewController (Make and Save Meme Image)

extension MMFEditorViewController {
    
    func saveMeme() {
        let meme = MMFMeme(stringT: captionTextFieldT.text!, stringB: captionTextFieldB.text!, originalImage: imageView.image!, memeImage: makeMemeImage()) as MMFMeme
        memeEditor = meme
        let appDelegate = UIApplication.shared.delegate as! MMFAppDelegate
        appDelegate.memes.append(meme)
    }
    
    func makeMemeImage() -> UIImage {
        
        prepareMakingMemeImage()
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        doneMakingMemeImage()
        
        return memeImage
    }
    
    func prepareMakingMemeImage() {
        toolBarT.isHidden = true
        toolBarB.isHidden = true
        captionTextFieldT.isHidden = captionTextFieldT.text == "TOP"
        captionTextFieldB.isHidden = captionTextFieldB.text == "BOTTOM"
        imageView.backgroundColor = UIColor.white
        captionTextFieldT.backgroundColor = UIColor.clear
        captionTextFieldB.backgroundColor = UIColor.clear
        fontView.isHidden = true
    }
    
    func doneMakingMemeImage() {
        toolBarT.isHidden = false
        toolBarB.isHidden = false
        captionTextFieldT.isHidden = false
        captionTextFieldB.isHidden = false
        imageView.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
}


//MARK: - MMFEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension MMFEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image: UIImage!
        
        if picker.allowsEditing == true {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        } else {
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        imageView.image = image
        picker.delegate = self
        self.dismiss(animated: false, completion: nil)
    }

    //MARK: Actions
    @IBAction func takePhotoFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.showsCameraControls = true
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: false, completion: nil)
    }
    
    @IBAction func pickPhotoFromAlbum(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: false, completion: nil)
    }
}

//MARK: - MMFEditorViewController (Keyboard Notifications)

extension MMFEditorViewController {
    func subscribeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscripeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}

//MARK: - MMFEditorViewController (Move views correspond to keyboard status when editing the bottom caption text field)

extension MMFEditorViewController {
    //MARK: Actions (bottom caption text field)
    @IBAction func captionTextFieldBBeginEditing(_ sender: Any) {
        subscribeKeyboardNotification()
    }
    @IBAction func cationTextFieldBEndEditing(_ sender: Any) {
        unsubscripeKeyboardNotification()
    }
    
    //MARK: Move views
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.view.frame.origin.y >= 0 {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}


//MARK: - MMFEditorViewController (Initialize UI)

extension MMFEditorViewController {
    
    func updateEditorView () {
        if memeEditor != nil {
            captionTextFieldT.text = memeEditor.stringT
            captionTextFieldB.text = memeEditor.stringB
            imageView.image = memeEditor.originalImage
        }
    }
    
    func initializeUICaptionTextField(_ textField: UITextField) {
        
        let descriptor = UIFontDescriptor(name: "HelveticaNeue-CondensedBlack", size: 40)
        
        print(descriptor.postscriptName)
        let font = UIFont(descriptor: descriptor, size: 40)
        
        
        let textFieldAttributes: [String : Any] = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
                                                   NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
                                                   NSAttributedStringKey.strokeWidth.rawValue : -3.0,
                                                   NSAttributedStringKey.font.rawValue : font]
        
        textField.defaultTextAttributes = textFieldAttributes
        
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = UIColor.clear
        
        if textField == captionTextFieldT {
            textField.text = "TOP"
            textField.placeholder = "TOP"
        } else if (textField == captionTextFieldB) {
            textField.text = "BOTTOM"
            textField.placeholder = "BOTTOM"
        }
    }
}
