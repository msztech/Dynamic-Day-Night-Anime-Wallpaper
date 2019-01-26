//
//  ViewController.swift
//  Dynamic Anime Wallpaper
//
//  Created by Shunzhe Ma on 1/24/19.
//  Copyright © 2019 Shunzhe Ma. All rights reserved.
//

import Cocoa
import CoreML
import Vision

class ViewController: NSViewController, NSOpenSavePanelDelegate {
    
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var subtitleLabel: NSTextField!
    @IBOutlet var progress: NSProgressIndicator!
    
    var dayImages = [String]()
    var nightImages = [String]()
    var imageCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func browseFile(sender: AnyObject) {
        let openPanel = NSOpenPanel();
        openPanel.title = "Select a folder for wallpapers"
        openPanel.message = "It will then be analyzed with CoreML and show as your desktop wallpaper!"
        openPanel.showsResizeIndicator=true;
        openPanel.canChooseDirectories = true;
        openPanel.canChooseFiles = false;
        openPanel.allowsMultipleSelection = false;
        openPanel.canCreateDirectories = true;
        openPanel.delegate = self;
        
        openPanel.begin { (result) -> Void in
            if(result == NSApplication.ModalResponse.OK){
                //Update the UI
                self.titleLabel.stringValue = "Recognizing"
                self.subtitleLabel.stringValue = "The app is using CoreML to recognize and analyze the images. "
                self.progress.isHidden = false
                //Start CoreML tast
                let path = openPanel.url!.path
                self.processFiles(path: path)
            }
        }
    }
    
    func processFiles(path: String){
        let fm = FileManager.default
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            for item in items {
                let completePath = path + "/" + item
                let image = CIImage(contentsOf: URL(fileURLWithPath: completePath))
                if image != nil{
                    imageCount += 1
                    detectScene(image: image!, path: completePath)
                }
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
    }
    
    func detectScene(image: CIImage, path: String) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
            fatalError("Can't load Inception ML model")
        }
        
        // Create a Vision request with completion handler
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
            }
            let detectedResult = topResult.identifier
            if detectedResult == "Day"{
                self!.dayImages.append(path)
            } else if detectedResult == "Night"{
                self!.nightImages.append(path)
            }
            //Update the progress UI
            let processedCount = self!.dayImages.count + self!.nightImages.count
            let progress = Double(processedCount) / Double(self?.imageCount ?? 1)
            DispatchQueue.main.async {
                self?.progress.doubleValue = progress * 100
                let prefix = "The app is using CoreML to recognize and analyze the images. ("
                self?.subtitleLabel.stringValue = prefix + String(self?.imageCount ?? 0 - processedCount) + " remaining out of " + String(self?.imageCount ?? 0) + " total image)"
            }
            //Save the arrays
            let store = UserDefaults.standard
            store.set(self!.dayImages, forKey: "stored_dayImages")
            store.set(self!.nightImages, forKey: "stored_nightImages")
            //Check if the progress finished
            print(self!.dayImages.count + self!.nightImages.count)
            if (processedCount == self!.imageCount){
                self!.finishedML()
            }
        }
        
        // Run the Core ML model classifier on global dispatch queue
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
    
    func finishedML(){
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let confirmView = storyboard.instantiateController(withIdentifier: "confirmView") as! confirmView
        DispatchQueue.main.async {
            self.view.window?.contentViewController = confirmView
        }
    }
    
}

