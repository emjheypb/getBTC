//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didSucceed(coinManager: CoinManager, response: ResponseModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let secret = Secret().API_KEY
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["PHP","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(secret)"
        print(urlString)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(data: safeData, currency: currency) {
                        self.delegate?.didSucceed(coinManager: self, response: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data, currency: String) -> ResponseModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let time = decodedData.time
            let doubleRate = decodedData.rate
            let coin = ResponseModel(time: time, doubleRate: doubleRate, currency: currency)
            
            return coin
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
