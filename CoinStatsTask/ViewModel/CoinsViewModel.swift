//
//  CoinsViewModel.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 22.06.22.
//

import Foundation
import Combine

final class CoinsViewModel {
    let fetchDataForTableView = Fetcher()
    let fetchCoinPrice = FetchCoinArray()
    let dataSource: CurrentValueSubject<[CoinTableViewCellModel], Never> = CurrentValueSubject([])
    var fetchedCoinArray:[String:[[Any]]]!
    var timer = Timer()
    
    init() {
        fetchDataForTable()
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] _ in
            self?.fetchCoinArrayPrice()
        })
    }
    
    func countOfCoins() -> Int {
        dataSource.value.count
    }
    
    func modelForIndexPath(index: IndexPath) -> CoinTableViewCellModel? {
        return dataSource.value[index.row]
    }
    
    private func fetchDataForTable() {
        fetchDataForTableView.getRequest { [weak self] data in
            guard let self = self else { return }
            let setupModels = data.coins.map { CoinTableViewCellModel(coin: $0) }
            self.dataSource.send(setupModels)
        }
    }
    
    private func fetchCoinArrayPrice() {
        fetchCoinPrice.getCoinArray { object in
            let coins = object?["coins"]?.compactMap { Coin(from: $0) } ?? []
            let prices = coins.map { $0.price }
            self.dataSource.value.enumerated().forEach { $0.element.livePrice.send(prices[$0.offset] ?? 0.0) }
        }
    }
}
