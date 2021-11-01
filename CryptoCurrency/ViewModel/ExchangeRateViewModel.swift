//
//  ExchangeRateViewModel.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/30/21.
//

import Foundation
/** BASE API URL **/
fileprivate let COINAPI_URL     = "https://rest.coinapi.io"
/** HEADER NAME **/
fileprivate let HEADER_API_KEY = "X-CoinAPI-Key"

/** Handler block **/
typealias APIResponse = ((_ response: Any?, _ error: Error?) -> Void)

class ExchangeRateViewModel {
    private struct ExchangeRatesAPI {
        static let COINAPI_URL     = "https://rest.coinapi.io"
        static let HEADER_API_KEY = "X-CoinAPI-Key"
        static let apiKey = "9277457D-8CBD-4D30-8354-F2FB303376B5"
    }
    
    func allExchangeRatesBy(assetId base: String, completionHandler: @escaping (Result<ExchangeRateModel, Error>) -> ()) {
        guard let url = URL(string:ExchangeRatesAPI.COINAPI_URL.appending("/v1/exchangerate/\(base)")) else {
            //completionHandler(nil, CoinAPIError.invalidRequest)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(ExchangeRatesAPI.apiKey, forHTTPHeaderField: HEADER_API_KEY)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let responseData = data else {
                completionHandler(.failure(error!))
                return
            }
            do {
                print(responseData)
                let jsonResponses = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                print(jsonResponses)
                if let jsonResponse = try? JSONDecoder().decode(ExchangeRateModel.self, from: responseData) {
                    completionHandler(.success(jsonResponse))
                }
            } catch {
                completionHandler(.failure(error))
            }
            
        }.resume()
        
    }
   
    //func fetchExchangeRates( url: String, completionHandler:@escaping{([Converter])-> void in })
}
