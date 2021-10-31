//
//  lotteryAPIManager.swift
//  LotteryProject
//
//  Created by mac on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class lotteryAPIManager {
    static let shared = lotteryAPIManager()
    
    
    
    func fetchlottoData(data: String, result: @escaping (Int,JSON)->() ) {
        
       let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(data)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value): //성공했을 때(let 연관값)
                let json = JSON(value)
                
                let code = response.response?.statusCode ?? 500
                
                result(code,json)
                
                print("JSON: \(json)")
            case .failure(let error): //실패했을 때
                print(error)
            }
        }
        
    }
    
}
