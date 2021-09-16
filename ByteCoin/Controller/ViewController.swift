//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
        
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateRate(_ coinManager: CoinManager, coinData: CoinData) {
        DispatchQueue.main.async {
            let rateString = String(format: "%.2f", coinData.rate)
            self.currencyLabel.text = coinData.asset_id_quote
            self.bitcoinLabel.text = rateString
            print(coinData.rate)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
        coinManager.delegate = self
    }


}

