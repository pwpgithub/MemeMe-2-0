//
//  MMFTabBarController.swift
//  MemeMe-2-0-Final
//
//  Created by Ping Wu on 01/07/2017.
//  Copyright © 2017 SHDR. All rights reserved.
//

import UIKit

//MARK: - MMFTTabBarController: UITabBarController

class MMFTabBarController: UITabBarController {
    
    //MARK: - Life Cycle Views
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start with the ViewController associated with the Index
        self.selectedIndex = 0
    }
}
