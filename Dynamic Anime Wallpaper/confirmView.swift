//
//  confirmView.swift
//  Dynamic Anime Wallpaper
//
//  Created by Shunzhe Ma on 1/24/19.
//  Copyright © 2019 Shunzhe Ma. All rights reserved.
//

import Foundation
import Cocoa

class confirmView : NSViewController{
    
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var fileTableView : NSTableView!
    @IBOutlet var actionBtn : NSButton!
    
    var dayImgAry: [String]!
    var nightImgAry: [String]!
    var tableViewData = [tableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Read the ary.
        let store = UserDefaults.standard
        dayImgAry = store.stringArray(forKey: "stored_dayImages")
        nightImgAry = store.stringArray(forKey: "stored_nightImages")
        constructTableData()
        fileTableView.delegate = self
        fileTableView.dataSource = self
        fileTableView.action = #selector(onItemClicked)
    }
    
    func constructTableData(){
        for dayImg in dayImgAry{
            let row = tableRow()
            row.imgName = dayImg
            row.imgId = "Day"
            tableViewData.append(row)
        }
        for nightImg in nightImgAry{
             let row = tableRow()
             row.imgName = nightImg
             row.imgId = "Night"
            tableViewData.append(row)
        }
        tableViewData = tableViewData.sorted(by: { $0.imgName < $1.imgName })
    }
    
    var wallpaperTimer: Timer!
    var isPaused = true
    
    @IBAction func pressActionButton(sender: AnyObject){
        if wallpaperTimer == nil || isPaused{
            start()
            changeWallPaper()
            isPaused = false
            actionBtn.title = "Stop"
            titleLabel.stringValue = "Currently Running."
        } else {
            isPaused = true
            wallpaperTimer.invalidate()
            actionBtn.title = "Run"
            titleLabel.stringValue = "Currently Stopped."
        }
    }
    
    func start(){
        wallpaperTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
            self.changeWallPaper()
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.wallpaperTimer != nil && self.wallpaperTimer.isValid && !self.isPaused{
                let timeFire = self.wallpaperTimer.fireDate.timeIntervalSince(Date())
                self.titleLabel.stringValue = timeFire.stringTime + " until next wallpaper."
            }
        }
    }
    
    func changeWallPaper(){
        let now = Date()
        let calender = Calendar.current
        let hour = calender.component(Calendar.Component.hour, from: now)
        //Day
        if 8 <= hour && hour <= 18{
            let random = self.dayImgAry.randomElement()
            if random != nil{
                self.setWallpaper(wallpaperPath: random!)
            }
        } else {
            let random = self.nightImgAry.randomElement()
            if random != nil{
                self.setWallpaper(wallpaperPath: random!)
            }
        }
    }
    
    func setWallpaper(wallpaperPath: String){
        let sharedWorkspace = NSWorkspace.shared
        let screens = NSScreen.screens
        let wallpaperUrl = URL(fileURLWithPath: wallpaperPath)
        var options = [NSWorkspace.DesktopImageOptionKey: Any]()
        options[.imageScaling] = NSImageScaling.scaleProportionallyUpOrDown.rawValue
        options[.allowClipping] = true
        for screen in screens{
            do {
                try sharedWorkspace.setDesktopImageURL(wallpaperUrl, for: screen, options: options)
            } catch {
                print(error)
            }
        }
    }
    
}

class tableRow {
    var imgName = "", imgId : String = ""
}

extension confirmView:NSTableViewDataSource, NSTableViewDelegate{
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let result:customeCell  = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: self) as! customeCell
        
        var name = tableViewData[row].imgName
        result.imgLogo.image = NSImage(contentsOf: URL(fileURLWithPath: name))
        //Filter the path so it only displays the image name
        let lastDividerLoc = name.lastIndex(of: "/")!
        name = String(name.suffix(from: lastDividerLoc))
        result.lblTitle.stringValue = name + " (" + tableViewData[row].imgId + ")"
        
        return result
    }
    
    @objc func onItemClicked() {
        let row = fileTableView.clickedRow
        let data = tableViewData[row]
        //Switch the status
        if data.imgId == "Day"{
            //Remove from day array and switch to light
            if let index = dayImgAry.firstIndex(of: data.imgName){
                dayImgAry.remove(at: index)
                nightImgAry.append(data.imgName)
            }
        } else if data.imgId == "Night"{
            if let index = nightImgAry.firstIndex(of: data.imgName){
                nightImgAry.remove(at: index)
                dayImgAry.append(data.imgName)
            }
        }
        //Save the data
        let store = UserDefaults.standard
        store.set(dayImgAry, forKey: "stored_dayImages")
        store.set(nightImgAry, forKey: "stored_nightImages")
        //Refresh the data
        tableViewData = [tableRow]()
        viewDidLoad()
        //Reload tableview
        fileTableView.reloadData()
    }
    
}

//https://stackoverflow.com/a/44910195
extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return Int(self) / 3600
    }
    
    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}
