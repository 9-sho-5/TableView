//
//  AddItemViewController.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/14.
//

import UIKit
import RealmSwift

class RealmViewControllerAddItemViewController: UIViewController {
    
    @IBOutlet var addItemButton: UIButton!
    @IBOutlet var textField: UITextField!
    
    // データベース(Realm)を宣言
    let realm = try! Realm()
    // データベースのAnimalテーブルのデータを入れておく変数
    var animals: List<Animal>!

    override func viewDidLoad() {
        super.viewDidLoad()
        animals = realm.objects(DBList.self).first?.animalList
    }
    
    @IBAction func addItem() {
        
        // 新しい動物をする準備
        let new_animal = Animal()
        // DB.swiftのAnimalに書いた各値をセットする
        new_animal.name = textField.text!
        new_animal.createdDate = Date()
        
        // データベースに書き込み
        try! realm.write {
            if animals == nil {
                let DBList = DBList()
                DBList.animalList.append(new_animal)
                realm.add(DBList)
            } else {
                animals.append(new_animal)
            }
        }
        animals = realm.objects(DBList.self).first?.animalList
        
        // 画面を１つ前に戻す
        dismiss(animated: true, completion: nil)
        
    }
}
