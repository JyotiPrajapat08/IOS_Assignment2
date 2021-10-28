//
//  HistoryScreen.swift
//  N01419457_Assignment2
//
//  Created by user193869 on 10/23/21.

import UIKit

class HistoryScreen: UIViewController {
    
    @IBOutlet weak var tableViewHistory: UITableView!
    
    var optedProduct: ProductSale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHistory.delegate = self
        tableViewHistory.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "history_detail_segue" {
            if let targetController = segue.destination as? ProductDetailsScreen {
                targetController.optedProduct = optedProduct
            }
        }
    }
}

    extension HistoryScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell =
            UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                        reuseIdentifier: "cell")
        cell.textLabel?.text = historyList[indexPath.row].name
        cell.detailTextLabel?.text = "\(historyList[indexPath.row].quantity)"
        return cell
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        optedProduct = historyList[indexPath.row]
        self.performSegue(withIdentifier: "history_detail_segue", sender: self)
    }
}
