//
//  MainScreen.swift
//  N01419457_Assignment2
//
//  Created by user193869 on 10/23/21.

import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var tableViewProducts: UITableView!
    
    var optedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewProducts.reloadData()
    }
    
    
    func resetFields() {
        optedIndex = -1
        quantityLabel.text = "Quantity"
        totalLabel.text = "Total"
        typeLabel.text = "Type"
        
    }
    
    func updatePrice() {
        if(optedIndex != -1) {
            let quantity = Double(quantityLabel.text ?? "0")
            totalLabel.text = "\(products[optedIndex].price * (quantity != nil ? quantity! : 0))"
            totalLabel.text = totalLabel.text == "0" ? "Total" : totalLabel.text
        }
    }
    
    
    
    @IBAction func btnBackSpaceAction(_ sender: UIButton) {
        var quant: String = quantityLabel.text!
        if(quant.count > 0 && quant != "Quantity") {
            quant.remove(at: quant.index(before: quant.endIndex))
            quantityLabel.text = quant
        }
        
        if(quant.count == 0) {
            quantityLabel.text = "Quantity"
        }
        
        updatePrice()
    }
    
    @IBAction func btnDigitsAction(_ sender: UIButton) {
        quantityLabel.text = (quantityLabel.text! + "\(sender.tag)").digits
        updatePrice()
    }
    
    
    
    @IBAction func btnBuyAction(_ sender: UIButton) {
        if(optedIndex != -1) {
            guard let quantity = Int(quantityLabel.text!), quantity > 0 else {
                return
            }
            if(products[optedIndex].quantity >= quantity) {
                products[optedIndex].quantity = products[optedIndex].quantity - quantity
                tableViewProducts.reloadData()
                historyList.append(ProductSale(id: products[optedIndex].id, name: products[optedIndex].name, quantity: quantity, totalPrice: Double(quantity) * products[optedIndex].price, Date: Date().toString(format: "MM/DD/YYYY hh:mm:ss a")))
                
                managerButton.isHidden = false
                resetFields()
            }
            else {
                alert(title: "Alert", message: "Quantity is not Enough")
            }
        }
        else {
            alert(title: "Error", message: "You have to select an Item and provide a Quantity")
        }
    }
    
}

    extension MainScreen: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
            cell.titleLabel.text = products[indexPath.row].name
            cell.quantityLabel.text = "\(products[indexPath.row].quantity)"
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            optedIndex = indexPath.row
            typeLabel.text = products[indexPath.row].name
            updatePrice()
        }
    }

class ProductCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
}
