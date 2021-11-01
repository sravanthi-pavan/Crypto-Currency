//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/30/21.
//

import UIKit

class ViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let tableView: UITableView  = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModel = [CryptoTableViewCellViewModel]()
     var exRateViewModel = ExchangeRateViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Bitcoin Exchange Rates"
        tableView.dataSource = self
        tableView.delegate = self
        fetchExchangeRateDataFromCodeData()
        fetchExchageRateDateFromAPI()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchExchageRateDateFromAPI(){
        exRateViewModel.allExchangeRatesBy(assetId: "BTC") { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModel = models.rates.compactMap({
                    
                    CryptoTableViewCellViewModel.init(code: $0.assetIDQuote, rate: $0.rate , date: $0.time)
                    
                    
                })
                self?.saveDataIntoCoreData(exchangeRateItem: self!.viewModel)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error) :
                print("Error: \(error)")
            }
            
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        fetchExchageRateDateFromAPI()
    }
    func saveDataIntoCoreData(exchangeRateItem: [CryptoTableViewCellViewModel]){
        let contextItem = ExchangeRates(context: context)
        for item in exchangeRateItem {
            contextItem.date = item.date
            contextItem.code = item.code
            contextItem.rate = item.rate
            
        }
        do{
           try context.save()
        }
        catch {
            
        }
        
    }
   func fetchExchangeRateDataFromCodeData(){
        do{
            let data = try context.fetch(ExchangeRates.fetchRequest()) as [ExchangeRates]
            self.viewModel = data.compactMap({
                CryptoTableViewCellViewModel.init(code: $0.code!, rate: $0.rate , date: $0.date!)
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel[indexPath.row];
        if let vc = storyboard?.instantiateViewController(withIdentifier: "HistoricalData") as? HistoricalDataController {
            vc.currencyCode = model.code
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

