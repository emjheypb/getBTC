//
//  ResponseModel.swift
//  ByteCoin
//
//  Created by Mariah Baysic on 3/1/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct ResponseModel {
    let time: String
    let doubleRate: Double
    let currency: String
    
    init(time: String, doubleRate: Double, currency: String) {
        self.doubleRate = doubleRate
        self.time = time
        self.currency = currency
    }
    
    var rate: String {
        return String(format: "%.2f", doubleRate)
    }
}
