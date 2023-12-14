//
//  UserDefaultsViewController.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/14.
//

import UIKit

class UserDefaultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var animals = [String]()
    
    var saveData: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        if let animalsData = saveData.object(forKey: "animals_data") {
            animals = animalsData as! [String]
        } else {
            // UserDefaultsに空のanimalsをセットする
            saveData.set(animals, forKey: "animals_data")
        }
        
        // NavigationBarの右に「editButton」を追加する
        navigationItem.rightBarButtonItems = [editButtonItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Viewの表示時にAnimalデータリストのデータ更新
        animals = saveData.object(forKey: "animals_data") as! [String]
        // TableViewの更新
        tableView.reloadData()
    }
    
    // セルを表示する個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    // Tableセルの表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = animals[indexPath.row]
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
        let array_item = animals[fromIndexPath.row]
        animals.remove(at: fromIndexPath.row)
        animals.insert(array_item, at: to.row)
        saveData.set(animals, forKey: "animals_data")
    }
    
    //並び替えを可能にする
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //削除の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveData.set(animals, forKey: "animals_data")
    }
    
    //スワイプでの削除させない
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing == true {
            return .delete
        } else {
            return .none
        }
    }
    
    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show", sender: nil)
    }
    
    // データの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let editItemVC = segue.destination as? UserDefaultsEditItemViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }
                
                editItemVC.recieveIndexNumber = indexPath.row
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        // 入力された値がnilでなければif文のブロック内の処理を実行
        if let keyword = searchBar.text {
            if keyword.isEmpty {
                animals = saveData.object(forKey: "animals_data") as! [String]
            } else {
                let defaultAnimals: [String] = saveData.object(forKey: "animals_data") as! [String]
                animals = defaultAnimals.filter({ $0.lowercased().contains(keyword.lowercased()) })
            }
            tableView.reloadData()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 入力された値がnilでなければif文のブロック内の処理を実行
        if let keyword = searchBar.text {
            if !keyword.isEmpty {
                // デバッグエリアに出力
                print(keyword)
                let defaultAnimals: [String] = saveData.object(forKey: "animals_data") as! [String]
                animals = defaultAnimals.filter({ $0.lowercased().contains(keyword.lowercased()) })
            } else {
                animals = saveData.object(forKey: "animals_data") as! [String]
            }
            tableView.reloadData()
        }
    }
    
}

