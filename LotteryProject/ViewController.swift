//
//  ViewController.swift
//  LotteryProject
//
//  Created by mac on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        getLotto()
    }

    func getLotto(){
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
        //비공개
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value): //성공했을 때(let 연관값)
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error): //실패했을 때
                print(error)
            }
        }
    }
}

