//
//  DigitTests.swift
//  TDDLaufschriftPruefungsAufgabe
//
//  Created by Marc Felden on 24.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import XCTest
@testable import TDDLaufschriftPruefungsAufgabe

class DigitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDigitCanTakeFirstLetter() {
        
        
        let digit = DigitView(frame: CGRectZero)
        let code = digit.codeForCharacter("a")
        let firstCol = digit.getColumOfCode(code, colum: 0)
        print(firstCol)
        
    }

    func testDigitCanTakeFirstLetter1() {
        
        
        let digit = DigitView(frame: CGRectZero)
        let code = digit.getMatrixForFrame(0)
        
        
    }
    

    
    
}

