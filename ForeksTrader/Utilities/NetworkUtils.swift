//
//  NetworkUtils.swift
//  ForeksTrader
//
//  Created by BarisOdabasi on 23.01.2022.
//

import Foundation
import Alamofire

class NetworkUtils {
    
    static func getDefaults(completion:@escaping ([MyPageDefaults]) -> ()) {
        AF.request(Constants.baseURL + Constants.settingsURL, method: .get,encoding: JSONEncoding.default).response{ response in
            guard let data = response.data else {return}
            do {
                let pageResponse = try JSONDecoder().decode(DefaultPage.self, from:data)
                completion(pageResponse.mypageDefaults)
            }catch let e {
                print(e)
            }
        }
    }
    
    static func getDetail(tkeArray: String, completion:@escaping ([L]) -> ()) {
        AF.request(Constants.baseURL + Constants.interViewURL + "las" + "," + "pdd" + "," + "ddi" + "," + "low" + "," + "hig" + "&stcs=" + tkeArray, method: .get,encoding: JSONEncoding.default).response{ response in
            guard let data = response.data else {return}
            do {
                let pageResponse = try JSONDecoder().decode(DetailModel.self, from:data)
                completion(pageResponse.l)
            }catch let e {
                print(e)
            }
        }
    }
}
