//
//  CoinTableViewCellModel.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 23.06.22.
//

import UIKit
import Combine

class CoinTableViewCellModel {
    var coin: Coin
    var livePrice: CurrentValueSubject<Double, Never>
    var cancellables: Set<AnyCancellable> = []
    
    init(coin: Coin) {
        self.coin = coin
        livePrice = CurrentValueSubject(coin.price ?? 0)
    }
}
