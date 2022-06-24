//
//  CoinTableViewCell.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 21.06.22.
//

import UIKit
import Kingfisher
import Combine

final class CoinTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var percentView: UIView!
    @IBOutlet private weak var coinIcon: UIImageView!
    @IBOutlet private weak var coinName: UILabel!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var coinRank: UILabel!
    @IBOutlet private weak var coinPercent: UILabel!
    @IBOutlet private weak var percentUpDownIcon: UIImageView!
    @IBOutlet private weak var coinShortName: UILabel!
    
    private let viewModel = CoinsViewModel()
    let dataSource: CurrentValueSubject<[CoinTableViewCellModel], Never> = CurrentValueSubject([])
    var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabeles()
    }
    
    @objc func mySelector1(_ not: Notification) {
        DispatchQueue.main.async {
            self.coinPriceLabel.reloadInputViews()
        }
    }
    
    func setupLabeles() {
        coinRank.adjustsFontSizeToFitWidth = true
        coinRank.minimumScaleFactor = 0.5
        coinPriceLabel.adjustsFontSizeToFitWidth = true
        coinPriceLabel.minimumScaleFactor = 0.5
        coinPercent.adjustsFontSizeToFitWidth = true
        coinPercent.minimumScaleFactor = 0.5
        coinName.adjustsFontSizeToFitWidth = true
        coinName.minimumScaleFactor = 0.5
    }
    
    func setup(_ model: CoinTableViewCellModel){
        DispatchQueue.main.async {
            self.coinIcon.kf.setImage(with: URL(string: model.coin.iconUrl!))
        }
        if let modelGranted = model.coin.price {
            coinPriceLabel.text = "$" + "\(String(describing: modelGranted))"
        }
        
        coinName.text = model.coin.coinName
        percentView.backgroundColor = AppStyle.priceUpColor.withAlphaComponent(0.1)
        coinPercent.textColor = AppStyle.percentLabelDownColor
        
        model.livePrice.receive(on: RunLoop.main).sink(receiveValue: { value in
            DispatchQueue.main.async {
                self.coinPriceLabel.text = "$" + "\(value)"
                self.coinPriceLabel.reloadInputViews()
            }
        }).store(in: &cancellables)
        
        coinRank.text = "\(model.coin.coinRank!)"
        if let model = model.coin.percentForTwentyFourHours{
            coinPercent.text = "\(String(describing: model))" + "%"
            if coinPercent.text!.contains(find: "-"){
                percentView.backgroundColor = AppStyle.priceDownColor.withAlphaComponent(0.1)
                coinPercent.textColor = AppStyle.percentLabelDownColor
                percentUpDownIcon.image = UIImage(named: "down_percent_icon")
                coinPercent.text?.removeFirst()
            }else {
                percentView.backgroundColor = AppStyle.priceUpColor.withAlphaComponent(0.1)
                coinPercent.textColor = AppStyle.percentLabelUpColor
                
                percentUpDownIcon.image = UIImage(named: "up_percent_icon")
            }
        }
        coinShortName.text = model.coin.coinShortName
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinName.text = nil
        coinIcon.image = nil
        coinPriceLabel.text = nil
        coinRank.text = nil
        coinShortName.text = nil
        cancellables = []
    }
    
}
