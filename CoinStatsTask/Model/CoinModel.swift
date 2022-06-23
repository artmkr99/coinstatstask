//
//  CoinModel.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 21.06.22.
//

import Foundation

struct CoinModel: Codable {
    let coins: [Coin]
}

struct Coin: Codable {
    let iconUrl: String?
    let coinName: String?
    let coinShortName: String?
    let coinRank: Int?
    let price: Double?
    let percentForTwentyFourHours: Float?
    
    enum CodingKeys: String, CodingKey {
        case iconUrl = "ic"
        case price = "pu"
        case coinName = "n"
        case coinShortName = "s"
        case percentForTwentyFourHours = "p24"
        case coinRank = "r"
    }
    
    init?(from array: [Any]) {
        guard let price = array[2] as? Double else { return nil }
        self.price = price
        self.iconUrl = nil
        self.coinName = nil
        self.coinShortName = nil
        self.coinRank = nil
        self.percentForTwentyFourHours = nil
    }
}

