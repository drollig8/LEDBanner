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
    var frameNumber = -1
    var background: UIImageView!
    var yOffset = 30
    let cornerRadius:CGFloat = 2
    let digitSize = 2
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        background = UIImageView(frame: frame)
        let image = UIImage(named: "displayBackground")
        background.image = image
        self.addSubview(background)
        
        
     //   drawLineForFrameWithCurrentTextSegment("Dies ist ein Test", forTimeFrame: 0)
        currentTextSegment = "Dies ist ein Test. "
        startAnimation()
    }
    
    func startAnimation() {
        
        
        
        let animationDuration: NSTimeInterval = 0.1
        let switchingInterval: NSTimeInterval = 0.1

            CATransaction.begin()
            CATransaction.setAnimationDuration(animationDuration)
            CATransaction.setCompletionBlock {
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.startAnimation()
                }
            }
            let transition = CATransition()
            transition.type = kCATransitionFade
            displayFrame()
            CATransaction.commit()
        
        
    }
    
    func stopAnimation() {
        
    }
    
    func drawLineForFrameWithCurrentTextSegment(currentSegmentTextString:String, forTimeFrame timeframe:Int) {
        
        let text = (currentSegmentTextString + "\(currentSegmentTextString[0])")
        for index in 0..<text.characters.count - 1 {
            
            let firstletter = text[index]
            let secondletter = text[index+1]
            let code = getCodeForFrameWithFirstletter(firstletter, secondLetter: secondletter, forTimeFrame: timeframe)
            
            drawLetterWithCode(code, atPosition: index)

        }

    }
    
    func clearDisplay() {
        for view in background.subviews {
            view.removeFromSuperview()
        }
    }
    
    func displayFrame() {
        
        clearDisplay()
        if frameNumber < 5 {
            frameNumber++
        } else {
            currentTextSegment = rotateToNextLetter(currentTextSegment)
            frameNumber = 1
        }
        
        drawLineForFrameWithCurrentTextSegment(currentTextSegment, forTimeFrame: frameNumber)
        
    }
    
    func rotateToNextLetter(currentTextSegment:String) -> String {
        
        let firstCharacter = currentTextSegment.characters.first!
        let neuesTeilSegment = currentTextSegment.characters.dropFirst()
        return String(neuesTeilSegment) + String(firstCharacter)
    }

    func drawLetterWithCode(code: [[Int]], atPosition position:Int) {
        
        let xPos = position * 5 * digitSize
        
        func addLineAtPosition(yPos: Int,rowdescription:[Int]) {
            for (line, codeBit) in rowdescription.enumerate() {
                
                if codeBit == 1 {
                    let element = UIView(frame: CGRect(x: xPos + line*digitSize, y: yPos, width: digitSize, height: digitSize))
                    element.layer.cornerRadius = cornerRadius
                    element.backgroundColor = UIColor.iKVBDisplayDigitOn()
                    background.addSubview(element)
                }
            }
        }
        

        for (zeile,code) in code.enumerate() {
            addLineAtPosition((zeile+1)*digitSize+yOffset,rowdescription: code)
        }
    }
    
    
    
    
    func getCodeForFrameWithFirstletter(firstletter: Character, secondLetter: Character, forTimeFrame timeframe: Int) -> [[Int]] {
        
        let firstCharacterCode = codeForCharacter(firstletter)
        let secondCharacterCode = codeForCharacter(secondLetter)
        
// das hier ist u.U. CPU intensiv
        // tausche spalten und reihen.
        
        var iColA = [[Int]]()
        
        for i in 0..<5 {
            let colum = getColumOfCode(firstCharacterCode, colum: i)
            iColA.append(colum)
        }
        
        var iColB = [[Int]]()
        
        for i in 0..<5 {
            let colum = getColumOfCode(secondCharacterCode, colum: i)
            iColB.append(colum)
        }
        
        
        var newCol = [[Int]]()
        
        // trenne vorne so viele ab, wie wir nicht wollen
        
        let startCol = timeframe
        
        for i in startCol..<5 {
            
            newCol.append(iColA[i])
        }
        
        for i in 0..<5-(5-startCol) {
            newCol.append(iColB[i])
        }
        
        
        
        var newRowNotation = [[Int]]()
        
        for i in 0..<8 {
            let colum = getColumOfCode(newCol, colum: i)
            newRowNotation.append(colum)
        }
        return newRowNotation
    }
    
    
 
    
    
    func getColumOfCode(code:[[Int]], colum: Int) -> [Int] {
        
        var result = [Int]()
        for row in code {
            
            result.append(row[colum])
        }
        return result
    }
    
    
    
    
    
    
    // ALT
    
    private func initDisplay() {
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
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
