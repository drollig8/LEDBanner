//
//  Display.swift
//  iKVB
//
//  Created by Marc Felden on 21.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import UIKit



class DisplayController: Display {
    
   
    
    
    
}


class Display: UIView {
    
    var timeString = ""
    var header1 = " "
    var header2 = " "
    var footer1 = " "
    var footer2 = " "
    var rowArray = [String]()
    var maxNumberOfRows = 8

    func removeAllSubviews() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }

    func showServerErrorMessage() {
        rowArray.removeAll()
        removeAllSubviews()
        
        // ich glaube, wenn die felder zu lang sind, wird manchmal gar nichts angezeigt.
     
            rowArray.append("                             ")
            rowArray.append("                             ")
            rowArray.append("        Serverstörung        ")
            rowArray.append("                             ")
            rowArray.append("                             ")
            rowArray.append("                             ")
             layoutDisplay()

            
        
    }
    func showErrorMessage() {
        rowArray.removeAll()
        removeAllSubviews()
        
        if isIphone6() {
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("              Störung                 ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("            Kein Internet             ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            rowArray.append("                                      ")
            
        }
        
        if isIphone5() {
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("              Störung               ")
            rowArray.append("                                    ")
            rowArray.append("           Kein Internet            ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
            rowArray.append("                                    ")
        }
        layoutDisplay()
    }
    
    func layoutDisplay() {
        for (index,row) in rowArray.enumerate() {
            if index > 40 { return }
            let displaySize = 2
            let rowFrame = CGRect(x: 0, y: index*displaySize*8, width: Int(self.frame.width), height: displaySize*8)
            let rowView = DisplayDigit(frame: rowFrame)
            rowView.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
            rowView.width = displaySize
            rowView.height = displaySize
            rowView.display(row)
            self.addSubview(rowView)
        }
    }
    
    
    
    func showLoadingMessage() {
       
        rowArray.removeAll()
        removeAllSubviews()
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        rowArray.append("                                      ")
        layoutDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
