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

}

