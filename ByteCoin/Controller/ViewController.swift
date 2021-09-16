import UIKit

class ViewController: UIViewController {
    
        
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
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
}

