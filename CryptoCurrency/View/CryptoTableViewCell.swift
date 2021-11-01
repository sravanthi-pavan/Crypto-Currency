//
//  CryptoTableViewCell.swift
//  CryptoCurrency
//
//  Created by Sravanthi Gumma on 10/30/21.
//

import UIKit
struct CryptoTableViewCellViewModel {
    let code: String
    let rate: Double
    let date: String
    
}

class CryptoTableViewCell: UITableViewCell {
 static let identifier = "CryptoTableViewCell"
    
    //SubViews
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(codeLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    // Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        codeLabel.sizeToFit()
        rateLabel.sizeToFit()
        dateLabel.sizeToFit()
        codeLabel.frame = CGRect(x: 10, y: 5, width: contentView.frame.size.width/2, height:  contentView.frame.size.height/2)
        rateLabel.frame = CGRect(x: 10, y: contentView.frame.size.height/2, width: contentView.frame.size.width/2, height:  contentView.frame.size.height/2)
        dateLabel.frame = CGRect(x: contentView.frame.size.width/2, y: 0, width: contentView.frame.size.width/2, height:  contentView.frame.size.height/2)
    }
    
    func configure(with viewModel:CryptoTableViewCellViewModel){
        codeLabel.text =  viewModel.code
        rateLabel.text = "\(viewModel.rate)"
        dateLabel.text = viewModel.date
    }

}
