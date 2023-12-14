//
//  RealmViewController.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/14.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    // データベース(Realm)を宣言
    let realm = try! Realm()
    // データベースのAnimalテーブルのデータを入れておく変数
    var animals: List<Animal>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // 初ビルド時にDB初期化
        try! realm.write {
            realm.deleteAll()
        }
        
        // データベースに保存したAnimalデータリストを取得
        animals = realm.objects(DBList.self).first?.animalList
        // NavigationBarの右に「editButton」を追加する
        navigationItem.rightBarButtonItems = [editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Realm URLの取得
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Viewの表示時にAnimalデータリストのデータ更新
        animals = realm.objects(DBList.self).first?.animalList
        // TableViewの更新
        tableView.reloadData()
    }

    // セルを表示する個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Animalデータリストがnilの場合、セルの表示数は0
        if animals == nil {
            return 0
        } else { // Animalデータリストがある場合、セルの表示数はデータの数分
            return animals.count
        }
    }
    
    // Tableセルの表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = animals[indexPath.row].name
        return cell! // テキストなどを持たせたcellを表示する
    }
    
    // 編集モードに切り替える処理(編集できるようにする)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    //並び替え時の処理
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        try! realm.write {
            let array_item = animals[fromIndexPath.row]
            animals.remove(at: fromIndexPath.row)
            animals.insert(array_item, at: to.row)
        }

    }

    //並び替えを可能にする
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //削除の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                animals.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //スワイプでの削除させない
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing == true {
            return .delete
        } else {
            return .none
        }
    }

}
