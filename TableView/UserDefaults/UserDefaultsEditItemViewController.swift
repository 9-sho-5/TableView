//
//  EditItemViewController.swift
//  TableView
//
//  Created by ほしょ on 2023/12/14.
//

import UIKit

class UserDefaultsEditItemViewController: UIViewController {
    
    @IBOutlet var textFielad: UITextField!
    
    var recieveIndexNumber: Int!
    var saveData: UserDefaults = UserDefaults.standard
    var animals = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animals = saveData.object(forKey: "animals_data") as! [String]
        textFielad.text = animals[recieveIndexNumber]
    }
    
    @IBAction func editData() {
        if let textData = textFielad.text {
            // 指定のデータを更新する
            animals[recieveIndexNumber] = textData
        } else {
            print("Error: textData was nil")
        }
        // データの更新
        saveData.set(animals, forKey: "animals_data")
        // いつ前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }

}
