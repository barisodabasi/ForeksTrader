//
//  MyPageModel.swift
//  ForeksTrader
//
//  Created by BarisOdabasi on 23.01.2022.
//

import Foundation

struct DefaultPage: Codable {
    var mypageDefaults: [MyPageDefaults]
    var mypage: [MyPage]
}

struct MyPageDefaults: Codable {
    var cod: String?
    var gro: String?
    var tke: String?
    var def: String?
}


struct MyPage: Codable {
    var name: String?
    var key: String?
}
