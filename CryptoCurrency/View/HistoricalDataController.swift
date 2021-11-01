//
//  HistoricalDataController.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/31/21.
//

import UIKit
import Charts


class HistoricalDataController: UIViewController, ChartViewDelegate {
    var currencyCode: String = ""
    
    @IBOutlet weak var lineChart: LineChartView!
    let historicalViewModel = HistoricDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currencyCode)
        lineChart.delegate = self
        title = "Historical Data" //"BTC/USD"
        let code = "BTC/\(currencyCode)" //
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"

        //let dateString = formatter.string(from: now)
        let dateDateString = formatter.string(from: Date().pastDay)//2016-01-01T00:00:00
        
        historicalViewModel.historialOHLCVData(symbol: code, periodId: "2MTH", timeStart: "2016-01-01T00:00:00", timeEnd: "", limit: 0) { [weak self] result in
            switch result {
            case .success(let models):
                print(models)
                if (models.count != 0) {
                    DispatchQueue.main.async {
                        var entries = [ChartDataEntry]()
                        _ = models.compactMap({
                        entries.append(ChartDataEntry(x:Double($0.priceClose), y: Double($0.priceClose)))
                        })
                        let set  = LineChartDataSet(entries: entries)
                        set.colors = ChartColorTemplates.material()
                        let data = LineChartData(dataSet: set)
                        self?.lineChart.data = data
                    }
                }
                
            case .failure(let error) :
                print("Error: \(error)")
            }
      }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var pastDay: Date {
        return Calendar.current.date(byAdding: .day, value: -14, to: self)!
    }
}
