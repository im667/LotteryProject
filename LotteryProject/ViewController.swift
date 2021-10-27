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

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var roundPickerView: UIPickerView!
    
    
    var drwNo = Array(1...903).sorted(by: {$0 > $1})
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        roundPickerView.delegate = self
        roundPickerView.dataSource = self

        
        self.resultLabel.backgroundColor = .systemPink
        self.resultLabel.textColor = .white
        
        
    }


}

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  "\(drwNo[row])"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  drwNo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = textField.text else {return}
        
        lotteryAPIManager.shared.fetchlottoData(data: data) { code, json in
            switch code {
            case 200:
                print(json)
                self.textField.text = "\(self.drwNo[row])"
                self.resultLabel.text = json["drwtNo1"].stringValue
                self.resultLabel.text?.append(contentsOf: ",")
                self.resultLabel.text?.append(contentsOf: json["drwtNo2"].stringValue)
                self.resultLabel.text?.append(contentsOf: ",")
                self.resultLabel.text?.append(contentsOf: json["drwtNo3"].stringValue)
                self.resultLabel.text?.append(contentsOf: ",")
                self.resultLabel.text?.append(contentsOf: json["drwtNo4"].stringValue)
                self.resultLabel.text?.append(contentsOf: ",")
                self.resultLabel.text?.append(contentsOf: json["drwtNo5"].stringValue)
                self.resultLabel.text?.append(contentsOf: ",")
                self.resultLabel.text?.append(contentsOf: json["drwtNo6"].stringValue)
                self.resultLabel.text?.append(contentsOf: "+")
                self.resultLabel.text?.append(contentsOf: json["bnusNo"].stringValue)
                
                self.dateLabel.text = json["drwNoDate"].stringValue
                self.roundLabel.text = json["drwNo"].stringValue
               
            case 400:
                print("error")
                
            default : print("error")
            }
            
            
            
        }
    }
    
    
}
