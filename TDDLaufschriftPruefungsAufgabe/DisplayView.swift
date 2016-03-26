//
//  DigitControllerView.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 25.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit


protocol DisplayViewDataSource {
   
    func refreshIntervalInDisplayView(refreshInterval: DisplayView) -> NSTimeInterval
    func numberOfRowInDisplayView(displayView: DisplayView) -> Int
    func displayView(displayView: DisplayView, testAtRow row: Int) -> String?
    func displayView(displayView: DisplayView, isAnimatedAtRow row: Int) -> Bool

}


class DisplayView:UIView {
    
    var currentTextSegment = ""
    var frameNumber = -1
    var background: UIImageView!
    var yOffset = 1
    let cornerRadius:CGFloat = 2
    let digitSize = 2
    var dataSource: DisplayViewDataSource!
    var animationShouldBeRunning = true
    
    // next step: create more than one row.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        background = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let image = UIImage(named: "displayBackground")
        background.image = image
        self.addSubview(background)
    }
    
    func startAnimation() {

        let refreshInterval = dataSource.refreshIntervalInDisplayView(self)
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(refreshInterval * NSTimeInterval(NSEC_PER_SEC)))
                if self.animationShouldBeRunning {
                    dispatch_after(delay, dispatch_get_main_queue()) {
                         self.startAnimation()
                        }
                }
            }
            displayAnimatedFrame()
            CATransaction.commit()
        
        
    }
    
    func stopAnimation() {
        animationShouldBeRunning = false
    }
    
    func drawLineForFrameWithCurrentTextSegment(currentSegmentTextString:String, forTimeFrame timeframe:Int, toRow row:Int) {
        
        let text = (currentSegmentTextString + "\(currentSegmentTextString[0])")
        for index in 0..<text.characters.count - 1 {
            
            let firstletter = text[index]
            let secondletter = text[index+1]
            let code = getCodeForFrameWithFirstletter(firstletter, secondLetter: secondletter, forTimeFrame: timeframe)
            
            drawLetterWithCode(code, atPosition: index, toRow: row)
        }

    }
   
    
    var animatedRows = [UIView]()
    func clearDisplay() {
        for view in background.subviews {
            view.removeFromSuperview()
        }
    }

    func clearAnimatedRows() {
        for view in animatedRows {
            view.removeFromSuperview()
        }
        animatedRows.removeAll()
    }
    
    
    func displayAnimatedFrame() {
        let numberOfRows = dataSource.numberOfRowInDisplayView(self)
        
        for row in 0..<numberOfRows {
            
            if dataSource.displayView(self, isAnimatedAtRow: row)  {
                clearAnimatedRows()
                
                if frameNumber < 5 {
                frameNumber++
                } else {
                currentTextSegment = rotateToNextLetter(currentTextSegment)
                frameNumber = 1
                }
                drawLineForFrameWithCurrentTextSegment(currentTextSegment, forTimeFrame: frameNumber, toRow: row)

            }
        }
    }
    
    
    func displayFrame() {
        let numberOfRows = dataSource.numberOfRowInDisplayView(self)
        
        for row in 0..<numberOfRows {
            let  textToDisplay = dataSource.displayView(self, testAtRow: row)
            if frameNumber == -1 {frameNumber = 0}
            if let text = textToDisplay {
                drawLineForFrameWithCurrentTextSegment(text, forTimeFrame: frameNumber, toRow: row)
            }
        }
    }
    
    func displayAnimatedFrame(row:Int) {
        clearAnimatedRows()
        if frameNumber < 5 {
            frameNumber++
        } else {
            currentTextSegment = rotateToNextLetter(currentTextSegment)
            frameNumber = 1
        }
        drawLineForFrameWithCurrentTextSegment(currentTextSegment, forTimeFrame: frameNumber, toRow: row)
    }
    
    
    func displayView(displayView: DisplayView, isAnimatedAtRow row: Int) -> Bool {
        if row == 0 { return false }
        return true
    }
    
    func rotateToNextLetter(currentTextSegment:String) -> String {
        
        let firstCharacter = currentTextSegment.characters.first!
        let neuesTeilSegment = currentTextSegment.characters.dropFirst()
        return String(neuesTeilSegment) + String(firstCharacter)
    }

    func drawLetterWithCode(code: [[Int]], atPosition position:Int, toRow row:Int) {
        
        let xPos = position * 5 * digitSize
        
        func addLineAtPosition(yPos: Int,rowdescription:[Int]) {
            for (line, codeBit) in rowdescription.enumerate() {
                
                if codeBit == 1 {
                    let element = UIView(frame: CGRect(x: xPos + line*digitSize, y: yPos, width: digitSize, height: digitSize))
                    
                    //if sizeExceedsRightFrameBorder()
                    if element.frame.origin.x > (background.frame.width + background.frame.origin.x) { return }
                    
                    element.layer.cornerRadius = cornerRadius
                    element.backgroundColor = UIColor.iKVBDisplayDigitOn()
                    if self.displayView(self, isAnimatedAtRow: row) {
                        animatedRows.append(element)
                    }
                    background.addSubview(element)
                }
            }
        }
        

        for (zeile,code) in code.enumerate() {
            
            let yPos = (zeile+1)*digitSize+yOffset + row * digitSize * 8
            addLineAtPosition(yPos,rowdescription: code)
        }
    }
    
    
    
  
    func getCodeForFrameWithFirstletter(firstletter: Character, secondLetter: Character, forTimeFrame timeframe: Int) -> [[Int]] {
        
        // causes 5% CPU
        var newRowNotation = [[Int]]()
        
        let firstCharacterCode = codeForCharacter(firstletter)
        let secondCharacterCode = codeForCharacter(secondLetter)
        

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
        
        let startCol = timeframe
        
        for i in startCol..<5 {
            newCol.append(iColA[i])
        }
        
        for i in 0..<5-(5-startCol) {
            newCol.append(iColB[i])
        }
        
        
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
}

extension UIColor {
    
    class func iKVBDisplayDigitOn()-> UIColor {
        return UIColor(red: 255/255, green: 206/255, blue: 109/255, alpha: 1.0)
    }
    class func iKVBDisplayDigitOff()-> UIColor {
        return UIColor(red: 60/255, green: 45/255, blue: 45/255, alpha: 1.0)
    }
}

