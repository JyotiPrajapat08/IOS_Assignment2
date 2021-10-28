//
//  ProductDetailsScreen.swift
//  N01419457_Assignment2
//
//  Created by user193869 on 10/23/21.

import UIKit

class ProductDetailsScreen: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var optedProduct: ProductSale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    func initData() {
        guard let optedProduct = optedProduct else {
            return
        }
        
        title = optedProduct.name
        detailLabel.text = "\(optedProduct.name)\n\(optedProduct.quantity)\n\(optedProduct.Date)\nTotal amount : \(optedProduct.totalPrice)"
    }
    
}
