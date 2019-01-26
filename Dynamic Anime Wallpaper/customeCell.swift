//
//  customeCell.swift
//  MacOSDemoApp
//
//  Created by wos on 20/12/17.
//  Copyright © 2017 WhiteOrange Software. All rights reserved.
//

import Cocoa

class customeCell: NSTableCellView {
    
    @IBOutlet weak var viewBG: NSView!
    @IBOutlet weak var imgLogo: NSImageCell!
    @IBOutlet weak var lblTitle: NSTextField!
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
