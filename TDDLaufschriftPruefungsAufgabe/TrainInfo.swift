//
//  TrainInfo.swift
//  iKVB
//
//  Created by Marc Felden on 21.03.16.
//  Copyright © 2016 Timm Kent. All rights reserved.
//

import Foundation

struct TrainInfo {

    var line:Int!
    var destination:String?
    var eta:Int?
    
    init(line: Int, destination:String? = nil, eta:Int?=nil) {
        self.line = line
        self.destination = destination
        self.eta = eta
    }
    
}