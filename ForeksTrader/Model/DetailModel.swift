//
//  DetailModel.swift
//  ForeksTrader
//
//  Created by BarisOdabasi on 23.01.2022.
//

import Foundation

struct DetailModel: Codable {
    let l: [L]
    let z: String
}

struct L: Codable {
    var tke: String = ""
    var clo: String = ""
    var pdd: String = ""
    var las: String = ""
    var ddi: String = ""
    var low: String = ""
    var hig: String = ""
}
