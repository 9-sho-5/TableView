//
//  Add_Item_With_UserDefaults_ViewController.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/14.
//

import UIKit

class Add_Item_With_UserDefaults_ViewController: UIViewController {

    @IBOutlet var addItemButton: UIButton!
    @IBOutlet var textField: UITextField!
    
    var animals = [String]()
    
    // データベースのAnimalテーブルのデータを入れておく変数
    var saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        animals = saveData.object(forKey: "animals_data") as! [String]
    }
    
    @IBAction func addItem() {
        
        // DB.swiftのAnimalに書いた各値をセットする
        animals.append(textField.text!)
        
        saveData.set(animals, forKey: "animals_data")
        
        // 画面を１つ前に戻す
        dismiss(animated: true, completion: nil)
        
    }
}
