//
//  AppStyle.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 23.06.22.
//

import UIKit.UIColor

struct AppStyle {
    static var priceDownColor:UIColor {
        return UIColor(named: "downColor")!
    }
    static var priceUpColor:UIColor {
        return UIColor(named: "upColor")!
    }
    static var percentLabelUpColor:UIColor {
        return UIColor(named: "coin_cell_percentUp_color")!
    }
    static var percentLabelDownColor:UIColor {
        return UIColor(named: "coin_cell_percentDown_color")!
    }
}
