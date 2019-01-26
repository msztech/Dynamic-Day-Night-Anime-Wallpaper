//
//  mainViewController.swift
//  Dynamic Anime Wallpaper
//
//  Created by Shunzhe Ma on 1/25/19.
//  Copyright © 2019 Shunzhe Ma. All rights reserved.
//

import Foundation
import Cocoa

class mainViewController : NSViewController{
    //This is the class where it actually runs the program
    
    var dayImgPath:[String]!
    var nightImgPath:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
        
    }
    
    func loadValues(){
        let store = UserDefaults.standard
        dayImgPath = store.stringArray(forKey: "stored_dayImages")
        nightImgPath = store.stringArray(forKey: "stored_nightImages")
    }
    
    
    
}
