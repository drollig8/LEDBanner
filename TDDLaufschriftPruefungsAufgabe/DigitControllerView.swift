//
//  DigitControllerView.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 25.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit

class DigitControllerView:UIView {
    
    var text = ""
    var currentTextSegment = ""
    var frameNumber = 0
    
    func initDisplay() {
         currentTextSegment = text + " "
         initDisplayWithCharacterString(currentTextSegment)
    }
    
    func initDisplayWithCharacterString(characterString: String) {
        for i in 0..<characterString.characters.count-1 {
    
            let digitView = DigitView(frame: CGRect(x: i*5*5 + 100, y: 100, width: 20, height: 30))
            digitView.backgroundColor = UIColor.lightGrayColor()
            digitView.tag = i
            setCharactersToDisplayDigit(digitView, currentTextSegment: currentTextSegment, i: i)
            self.addSubview(digitView)
        }
    }
    
     func updateDisplayWithCharacterString(characterString: String) {
        
        for view in self.subviews {
            if let view = view as? DigitView {
                setCharactersToDisplayDigit(view, currentTextSegment: currentTextSegment, i: view.tag)
            }
        }
    }
    
    func gotoNextLetter() -> String {

        let firstCharacter = currentTextSegment.characters.first!
        let neuesTeilSegment = currentTextSegment.characters.dropFirst()
        return String(neuesTeilSegment) + String(firstCharacter)
    }
    
    func setCharactersToDisplayDigit(digitView: DigitView, currentTextSegment:String, i:Int) {
        let firstletter = currentTextSegment[i]
        let secondletter = currentTextSegment[i+1]
        digitView.firstletter = firstletter
        digitView.secondletter = secondletter
    }
    
    func displayNextFrame() {
        
        if frameNumber < 5 {
            frameNumber++
        } else {
            currentTextSegment = gotoNextLetter()
            updateDisplayWithCharacterString(currentTextSegment)
            frameNumber = 0
        }

        for view in self.subviews {
            if let view = view as? DigitView {
                view.showFrame(frameNumber)
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
