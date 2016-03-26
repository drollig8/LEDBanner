//
//  ViewController.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 24.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit


class ViewController: UIViewController,DisplayViewDataSource {

    var displayView: DisplayView!
    var messageArray = ["Dies ist ein Test1","Bla","Blub"]
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        displayView = DisplayView(frame: self.view.frame)
        displayView = DisplayView(frame: CGRect(x: 20, y: 20, width: 280, height: 200))
        self.view.addSubview(displayView)
        
        displayView.currentTextSegment = "This is an animated Row.This is an animated Row."
        displayView.dataSource = self
        
        displayView.displayFrame()
        displayView.startAnimation()
      //  displayView.stopAnimation()
      
        
    }
    
    // Diplay View Datasource

    
    func refreshIntervalInDisplayView(refreshInterval: DisplayView) -> NSTimeInterval {
        return 0.04
    }
    
    func numberOfRowInDisplayView(displayView: DisplayView) -> Int {
       return messageArray.count
    }
    
    // there can always only be one row animated.
    func displayView(displayView: DisplayView, isAnimatedAtRow row: Int) -> Bool {
        if row == 1 { return true }
        return false
    }
    func displayView(displayView: DisplayView, testAtRow row: Int) -> String? {
        return messageArray[row]
    }

}

