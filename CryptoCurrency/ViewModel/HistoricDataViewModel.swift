//
//  HistoricDataViewModel.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/31/21.
//

import Foundation
/** BASE API URL **/
fileprivate let COINAPI_URL     = "https://rest.coinapi.io"
/** HEADER NAME **/
fileprivate let HEADER_API_KEY = "X-CoinAPI-Key"
class HistoricDataViewModel {
    private struct HistoricDataAPI {
        static let COINAPI_URL     = "https://rest.coinapi.io"
        static let HEADER_API_KEY = "X-CoinAPI-Key"
        static let apiKey = "9277457D-8CBD-4D30-8354-F2FB303376B5"
    }
    
    func historialOHLCVData(symbol id: String, periodId: String, timeStart: String, timeEnd:String, limit: Int, completionHandler: @escaping (Result<[HistoricData], Error>) -> ()) {
            // build URI string
            var requestResource = "/v1/ohlcv/\(id)/history?period_id=\(periodId)&time_start=\(timeStart)"
            
            if !timeEnd.isEmpty {
                requestResource.append("&time_end=\(timeEnd)")
            }
            if limit > 0 {
                requestResource.append("&limit=\(limit)")
            }
            
            guard let requestUrl = URL(string: COINAPI_URL.appending(requestResource)) else {
                //completionHandler(nil, CoinAPIError.invalidRequest)
                return
            }
            
            // Build request
           // let request = NSMutableURLRequest(url: requestUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 100)
            //request.httpMethod = "GET"
            //request.addValue(self.apiKey, forHTTPHeaderField: HEADER_API_KEY)
            
            // Perform request
            //perform(request: request as URLRequest, completionHandler: completionHandler)
        
//        guard let url = URL(string:ExchangeRatesAPI.COINAPI_URL.appending("/v1/exchangerate/\(base)")) else {
//            //completionHandler(nil, CoinAPIError.invalidRequest)
//            return
//        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.addValue(HistoricDataAPI.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let responseData = data else {
                completionHandler(.failure(error!))
                return
            }
            do {
                if let jsonResponse = try? JSONDecoder().decode([HistoricData].self, from: responseData) {
                    completionHandler(.success(jsonResponse))
                }
            } catch {
                completionHandler(.failure(error))
            }
            
        }.resume()
        
        
        
        
        }
}

