//
//  ResponseModel.swift
//  ByteCoin
//
//  Created by Mariah Baysic on 3/1/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct ResponseModel {
    let rate: String
    
    init(rate: Double) {
        self.rate = String(format: "%.2f", rate)
    }
}
