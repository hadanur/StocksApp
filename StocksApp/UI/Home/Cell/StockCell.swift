//
//  StockCell.swift
//  StocksApp
//
//  Created by Hakan Adanur on 30.01.2023.
//

import Foundation
import UIKit

class StockCell: UITableViewCell {
    @IBOutlet private weak var stockName: UILabel!
    @IBOutlet private weak var stockPrice: UILabel!
    @IBOutlet private weak var percentView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    
    func configure(stock: Stock) {
        let randomPercent = Int.random(in: -10..<10)
        
        stockName.text = stock.currency
        stockPrice.text = stock.price
        percentView.layer.cornerRadius = 4
        percentLabel.text = String(describing: randomPercent)
       
        if randomPercent < 0 {
            self.percentView.backgroundColor = UIColor.red
        } else {
            self.percentView.backgroundColor = UIColor.systemGreen
        }
    }
}
