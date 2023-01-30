//
//  Webservice.swift
//  StocksApp
//
//  Created by Hakan Adanur on 30.01.2023.
//

import Foundation
import UIKit

class Webservice {
    
    static let shared = Webservice()
    
    private init() { }
    
    func downloadStocks(completion : @escaping ([Stock]?) -> ()) {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let stockList = try JSONDecoder().decode([Stock].self, from: data)
                    completion(stockList)
                } catch {
                    print(error.localizedDescription)
                    print(String(describing: error))
                }
            }
        }.resume()
    }
}
