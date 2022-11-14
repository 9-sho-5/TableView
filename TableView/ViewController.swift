//
//  ViewController.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        array = ["Dog","Cat","Cow","Mouse","Rat","Tiger","Bird"]
        // NavigationBarの右に「editButton」を追加する
        navigationItem.rightBarButtonItems = [editButtonItem]
    }

    // セルを表示する個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    // Tableセルの表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = array[indexPath.row]
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
        let array_item = array[fromIndexPath.row]
        array.remove(at: fromIndexPath.row)
        array.insert(array_item, at: to.row)
    }

    //並び替えを可能にする
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //削除の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}

