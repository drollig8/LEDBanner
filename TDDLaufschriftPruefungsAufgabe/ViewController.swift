//
//  ViewController.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 24.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var digitController: DigitControllerView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Show Background
        let display = DisplayController(frame:  self.view.frame)
        display.backgroundColor = UIColor.greenColor()
        self.view.addSubview(display)
        display.showLoadingMessage()
        */
        
        digitController = DigitControllerView(frame: self.view.frame)
        digitController = DigitControllerView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: self.view.frame.height))
        digitController.text = "This is a message"
        self.view.addSubview(digitController)
     //   displayAnimation()
        
    }
    
    // 25 Hz
    let animationDuration: NSTimeInterval = 0.01
    let switchingInterval: NSTimeInterval = 0.01

    func updateUI() {
        
    }
    
    
    func displayAnimation() {
           CATransaction.begin()
            CATransaction.setAnimationDuration(animationDuration)
            CATransaction.setCompletionBlock {
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.displayAnimation()
                }
            }
            let transition = CATransition()
            transition.type = kCATransitionFade
            digitController.displayNextFrame()
            CATransaction.commit()
    }


}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
}