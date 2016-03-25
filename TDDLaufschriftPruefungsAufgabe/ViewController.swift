//
//  ViewController.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 24.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let digitController = DigitControllerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        digitController.text = "This is a message"
        digitController.initDisplay()
        self.view.addSubview(digitController)
        displayAnimation()
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