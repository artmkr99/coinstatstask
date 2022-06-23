//
//  CoinsViewController.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 21.06.22.
//

import UIKit
import Combine

final class CoinsViewController: UIViewController {
    
    @IBOutlet weak var coinsTableView: UITableView!
    
    private let viewModel = CoinsViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        coinsTableView.delegate = self
        coinsTableView.dataSource = self
        removeTableViewTopPadding()
        bindToDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
        self.coinsTableView.reloadData()
    }
    
    func setupNavigationBar() {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Semibold", size: 17)]
        UINavigationBar.appearance().titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func bindToDataSource() {
        viewModel.dataSource
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.coinsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setupTableView() {
        coinsTableView.register(UINib(nibName: "CoinHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CoinHeaderView")
        coinsTableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: "coinCell")
        coinsTableView.separatorColor = .clear
    }
    
    func removeTableViewTopPadding() {
        if #available(iOS 15.0, *) {
            self.coinsTableView.sectionHeaderTopPadding = 0
        }
    }
}

extension CoinsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfCoins()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinsTableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinTableViewCell
        cell.selectionStyle = .none
        DispatchQueue.main.async {
            cell.setup(self.viewModel.modelForIndexPath(index: indexPath)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = coinsTableView.dequeueReusableHeaderFooterView(withIdentifier: "CoinHeaderView") as! CoinHeaderView
        headerView.backgroundColor = .clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
