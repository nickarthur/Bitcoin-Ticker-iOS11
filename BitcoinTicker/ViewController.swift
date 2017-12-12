
//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    //MARK: PROPERTIES
    /***************************************************************/

    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    // NOTE: the followig two arrays must be kept in sync
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolsArray =    ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    var finalURL = ""

    //MARK: OUTLETS
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    //MARK: Methods
    /***************************************************************/

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this class will serve both roles
        currencyPicker.delegate = self;
        currencyPicker.dataSource = self;
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    //MARK: UIPickerViewDatasource Methods
    /***************************************************************/

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // only 1 column of data
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count // one display row is needed for each item in the array
    }
    
    //MARK: UIPickerViewDelegate Delegate Methods
    /***************************************************************/

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symbolsArray[row] + currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        getCurrencyData(url: finalURL)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let myString = NSMutableAttributedString(string: symbolsArray[row] + currencyArray[row])
        
        // Declare the fonts
        let myStringFont1 = UIFont(name:"Helvetica-Light", size:30.0)!
        
        // Declare the colors
        let myStringColor1 = UIColor(red: 0.985538, green: 0.009297, blue: 0.999171, alpha: 1.000000)
        
        // Declare the paragraph styles
        let myStringParaStyle1: NSMutableParagraphStyle = NSMutableParagraphStyle()
        
        myStringParaStyle1.alignment = NSTextAlignment.center
        myStringParaStyle1.tabStops = [NSTextTab(textAlignment: NSTextAlignment.left, location: 28.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 56.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 84.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 112.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 140.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 168.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 196.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 224.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 252.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 280.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 308.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 336.000000, options: [:]), ]
        
        
        let length = myString.length
        // Create the attributes and add them to the string
        myString.addAttribute(NSAttributedStringKey.foregroundColor, value:myStringColor1, range:NSMakeRange(0,length))
        myString.addAttribute(NSAttributedStringKey.paragraphStyle, value:myStringParaStyle1, range:NSMakeRange(0,length))
        myString.addAttribute(NSAttributedStringKey.font, value:myStringFont1, range:NSMakeRange(0,length))

            return myString
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getCurrencyData(url: String) {
        
        Alamofire.request(url, method: .get, parameters: nil)
            .responseJSON { response in
                if response.result.isSuccess {

                    print("Sucess! Got the currency data")
                    let currencyJSON : JSON = JSON(response.result.value!)

                    self.updateCurrencyData(json: currencyJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    
    
    
    
//    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCurrencyData(json : JSON) {
        
        print(json["averages"]["day"])
        bitcoinPriceLabel.text = json["averages"]["day"].stringValue
        
    }
    




}

