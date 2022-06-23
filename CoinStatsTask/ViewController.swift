//
//  ViewController.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 21.06.22.
//

import UIKit

class ViewController: UIViewController {
let fetchtest = FetchCoinArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToTableView(_ sender: Any) {
        let vc = CoinsViewController(
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }

}
