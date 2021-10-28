//
//  RestockScreen.swift
//  N01419457_Assignment2
//
//  Created by user193869 on 10/23/21.


import UIKit

class RestockScreen: UIViewController {
    
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var tableViewProducts: UITableView!
    
    var optedIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnRestockAction(_ sender: UIButton) {
        if(optedIndex != -1) {
            products[optedIndex].quantity = Int(tfQuantity.text?.digits ?? "0") ?? 0
            tableViewProducts.reloadData()
        }
        else {
            alert(title: "Error", message: "You have to select an item and provide a new quantity")
        }
    }
    
    
    
}

    extension RestockScreen: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestockProductCell
            cell.lblTitle.text = products[indexPath.row].name
            cell.lblQuantity.text = "\(products[indexPath.row].quantity)"
            return cell
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            optedIndex = indexPath.row
        }
    }

    class RestockProductCell: UITableViewCell {
        @IBOutlet weak var lblTitle: UILabel!
        @IBOutlet weak var lblQuantity: UILabel!
        
    }
