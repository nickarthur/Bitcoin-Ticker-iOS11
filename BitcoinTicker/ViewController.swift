
//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    //MARK: ATTRIBUTED STRING STYLING
    //BEGIN LEN DEBUG
    // Create the attributed string
    var myString = NSMutableAttributedString(string:"AUD")
    
    //MARK: PROPERTIES
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //MARK: OUTLETS
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this class will serve both roles
        currencyPicker.delegate = self;
        currencyPicker.dataSource = self;
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    //MARK: UIPickerViewDatasource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // only 1 column of data
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count // one display row is needed for each item in the array
    }
    
    //MARK: UIPickerViewDelegate Delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        finalURL = baseURL + currencyArray[row]
        print(finalURL)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let myString = NSMutableAttributedString(string: currencyArray[row])
        
        // Declare the fonts
        let myStringFont1 = UIFont(name:"Helvetica-Light", size:30.0)!
        
        // Declare the colors
        let myStringColor1 = UIColor(red: 0.985538, green: 0.009297, blue: 0.999171, alpha: 1.000000)
        
        // Declare the paragraph styles
        let myStringParaStyle1: NSMutableParagraphStyle = NSMutableParagraphStyle()
        
        myStringParaStyle1.alignment = NSTextAlignment.center
        myStringParaStyle1.tabStops = [NSTextTab(textAlignment: NSTextAlignment.left, location: 28.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 56.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 84.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 112.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 140.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 168.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 196.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 224.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 252.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 280.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 308.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 336.000000, options: [:]), ]
        
        
        // Create the attributes and add them to the string
        myString.addAttribute(NSAttributedStringKey.foregroundColor, value:myStringColor1, range:NSMakeRange(0,3))
        myString.addAttribute(NSAttributedStringKey.paragraphStyle, value:myStringParaStyle1, range:NSMakeRange(0,3))
        myString.addAttribute(NSAttributedStringKey.font, value:myStringFont1, range:NSMakeRange(0,3))

            return myString
    }
    
//    
//    //MARK: - Networking
//    /***************************************************************/
//    
//    func getWeatherData(url: String, parameters: [String : String]) {
//        
//        Alamofire.request(url, method: .get, parameters: parameters)
//            .responseJSON { response in
//                if response.result.isSuccess {
//
//                    print("Sucess! Got the weather data")
//                    let weatherJSON : JSON = JSON(response.result.value!)
//
//                    self.updateWeatherData(json: weatherJSON)
//
//                } else {
//                    print("Error: \(String(describing: response.result.error))")
//                    self.bitcoinPriceLabel.text = "Connection Issues"
//                }
//            }
//
//    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
//    func updateWeatherData(json : JSON) {
//        
//        if let tempResult = json["main"]["temp"].double {
//        
//        weatherData.temperature = Int(round(tempResult!) - 273.15)
//        weatherData.city = json["name"].stringValue
//        weatherData.condition = json["weather"][0]["id"].intValue
//        weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
//        }
//        
//        updateUIWithWeatherData()
//    }
//    




}

