//
//  Fetcher.swift
//  CoinStatsTask
//
//  Created by Scylla IOS on 21.06.22.
//

import Foundation

struct Fetcher {
    func getRequest(completion: @escaping (CoinModel) -> ()) {
        guard let url = URL(string: "https://api.coin-stats.com/v3/coins") else { fatalError("Invalid URL") }
        let networkManager = NetworkManager()

        networkManager.request(url: url) { (result: Result<CoinModel, Error>) in
            switch result {
            case .success(let coins):
                completion(coins)
            case .failure(let error):
                print("We got a failure trying to get the users. The error we got was: \(error)")
            }
        }
    }
}

struct FetchCoinArray {
    func getCoinArray(completion: @escaping ([String : [[Any]]]?) -> ()) {
        let url = URL(string: "https://api.coin-stats.com/v3/coins?responseType=array")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [[Any]]]

                completion(object)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
