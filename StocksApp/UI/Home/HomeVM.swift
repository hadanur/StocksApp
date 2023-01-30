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
    
}
