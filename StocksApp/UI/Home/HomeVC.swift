//
//  HomeVC.swift
//  StocksApp
//
//  Created by Hakan Adanur on 30.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var popButton: UIButton!
    @IBOutlet private weak var infoButton: UIButton!
    private var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stockCell = UINib(nibName: "StockCell", bundle: nil)
        tableView.register(stockCell, forCellReuseIdentifier: "stockCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        searchBar.delegate = self
        
        viewModel.fetchStocks()
        setMySymbolsButton()
        setInfoButton()
    }
    
    private func setMySymbolsButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)
        }
        
        popButton.menu = UIMenu(children: [
            UIAction(title: "My Symbols",
                     state: .off,
                     handler: optionClosure),
            UIAction(title: "All Symbols",
                     state: .off ,
                     handler: optionClosure),
        ])

        popButton.showsMenuAsPrimaryAction = true
        popButton.changesSelectionAsPrimaryAction = true
    }
    
    private func setInfoButton(){
        let optionClosure = {(action: UIAction) in
            print(action.title)
        }
        
        infoButton.menu = UIMenu(children: [
            UIAction(title: "Edit WatchList",
                     state: .off,
                     handler: optionClosure),
            UIAction(title: "Show Currency",
                     state: .off ,
                     handler: optionClosure),
        ])
        infoButton.showsMenuAsPrimaryAction = true
        infoButton.changesSelectionAsPrimaryAction = true
    }
}


extension HomeVC {
    static func create() -> HomeVC {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.viewModel = HomeVM()
        return vc
    }
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterStock(with: searchText.lowercased())
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        let data = viewModel.filteredStocks[indexPath.row]
        cell.configure(stock: data)
        return cell
    }
}

extension HomeVC: HomeVMDelegate {
    func fetchDataSuccess() {
        self.tableView.reloadData()
    }
    
    func fetchDataError() {
        self.showAlert(title: "Error", message: "Try Again")
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}
