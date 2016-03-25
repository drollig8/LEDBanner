//
//  Digit.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 24.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit


class DigitView: UIView {
    
    var test = "Dies ist ein Test"
    
    
    var firstletter:Character = "a"
    var secondletter:Character = "b"
    var digiFrame:Int = 0

    
    var pixelViews = [UIView]()
    
    private var pixelTags = [Int]()
    
    
    // 5 x 8

    func getMatrixForFrame(digiFrame:Int) -> String {
        
        
        let firstCharacterCode = codeForCharacter(firstletter)
        let secondCharacterCode = codeForCharacter(secondletter)
        
        var result = ""
        
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
        
        let startCol = digiFrame
      
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

        for row in newRowNotation {
            for digit in row {
                if digit == 1 {
                    result = result + "1"
                } else {
                    result = result + "0"
                }
            }
        }
        return result
        
        
    }
    

    func getColumOfCode(code:[[Int]], colum: Int) -> [Int] {
        
        var result = [Int]()
        for row in code {

            result.append(row[colum])
        }
        return result
    }
    

    
    func showFrame(frame:Int) {
        
        let matrix = getMatrixForFrame(frame)
        for view in self.subviews {
            if let view = view as? PixelView {
                if isOn(view.tag, withMatrix: matrix) {
                    view.backgroundColor = UIColor.greenColor()
                } else {
                    view.backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    
    
    func isOn(index: Int, withMatrix: String) -> Bool {
        
        let letters = withMatrix.characters.map { String($0) }
        if 	letters[index] == "1" {
            return true
        }
        return false
    }
    
    class PixelView:UIView {
        var position = 0
    }
    func drawDigitAtPosition() {
        var col = 0
        var row = 0
        for index in 0..<40 {
            let xPos = col * 5
            
            let yPos = row * 5
            let pixelView = PixelView(frame: CGRect(x: xPos, y: yPos, width: 5, height: 5))
            
            if col < 4 {
                col++
            } else {
                col = 0
                row++
            }
            pixelView.tag = index
            
            pixelView.backgroundColor = UIColor.lightGrayColor()
            self.addSubview(pixelView)
        }
    }
    



    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        drawDigitAtPosition()
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}