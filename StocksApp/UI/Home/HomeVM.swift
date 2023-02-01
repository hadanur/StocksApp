//
//  HomeVM.swift
//  StocksApp
//
//  Created by Hakan Adanur on 30.01.2023.
//

import Foundation
import UIKit

protocol HomeVMDelegate: AnyObject {
    func fetchDataSuccess()
    func fetchDataError()
    func reloadTableView()
}

class HomeVM {
    let service = Webservice.shared
    weak var delegate: HomeVMDelegate?
    var stocks = [Stock]()
    var filteredStocks = [Stock]()
    
    func fetchStocks() {
        service.downloadStocks { result in
            if let result = result {
                self.stocks = result
                self.filteredStocks = result
                
                DispatchQueue.main.async {
                    self.delegate?.fetchDataSuccess()
                }
            } else {
                self.delegate?.fetchDataError()
            }
        }
    }

    func filterStock(with searchText: String) {
        filteredStocks.removeAll()

        if searchText == "" {
            filteredStocks = stocks
        } else {
//            filteredStocks = stocks.filter { $0.currency.lowercased().contains(searchText)}

            for word in stocks {
                if word.currency.lowercased().contains(searchText) {
                    filteredStocks.append(word)
                }
            }
            
            delegate?.reloadTableView()
        }
    }
}
