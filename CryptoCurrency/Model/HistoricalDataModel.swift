//
//  HistoricalDataModel.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/31/21.
//

import Foundation
struct HistoricData: Codable {
    let priceClose : Double
    let priceHigh:Double
    let priceLow: Double
    let priceOpen:Double
    let timeClose: String
    let timeOpen: String
    let timePeriodEnd: String
    let timePeriodStart: String
    let tradesCount : Int
    let volumeTraded: Double
    enum CodingKeys: String, CodingKey {
        case timePeriodStart = "time_period_start"
        case timePeriodEnd = "time_period_end"
        case timeOpen = "time_open"
        case timeClose = "time_close"
        case priceOpen = "price_open"
        case priceHigh = "price_high"
        case priceLow = "price_low"
        case priceClose = "price_close"
        case volumeTraded = "volume_traded"
        case tradesCount = "trades_count"
    }
    
}


