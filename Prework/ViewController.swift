//
//  ViewController.swift
//  Prework
//
//  Created by Chaturved Sumanth Lakkaraju on 21/12/21.
//

import UIKit

let defaults = UserDefaults.standard;

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tipCalcNavBar: UINavigationBar!
    
    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipPercLabel:UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var peopleStepper: UIStepper!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    @IBOutlet weak var tipPPLabel: UILabel!
    @IBOutlet weak var tipPPAmountLabel:
        UILabel!
    
    @IBOutlet weak var totalPPLabel: UILabel!
    @IBOutlet weak var totalPPAmountLabel: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var currencyExchangeLabel: UILabel!
    
    @IBOutlet weak var exchangeToLabel: UILabel!
    @IBOutlet weak var exchangeToPicker: UIPickerView!
    
    
    @IBOutlet weak var totalDiffCurrLabel: UILabel!
    @IBOutlet weak var totalAmountDiffCurrLabel: UILabel!
    
    
    let refreshTime: Double = 600;
    
    let tip1Default: Double = 15;
    let tip2Default: Double = 18;
    let tip3Default: Double = 20;
    
    let animationTime: Double = 0.3;
    
    let localeFormatter = NumberFormatter();
    let foreignFormatter = NumberFormatter();
    var currencyCodes: [String] = [];
    var convertedValue: Double = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.exchangeToPicker.delegate = self;
        self.exchangeToPicker.dataSource = self;
        
        localeFormatter.numberStyle = .currency;
        localeFormatter.locale = Locale.current;
        localeFormatter.maximumFractionDigits = 2;
        
        //setConfiguredSettings();
    }
    
    func setConfiguredSettings(){
        billAmountTextField.becomeFirstResponder();
        refreshColorMode();
        refreshDefaultTips();
        refreshBillAmount();
        refreshCurrencyExchangerView();
        updateTip();
    }
    
    func refreshAnimation(){
        
        tipCalcNavBar.alpha = 0;
        
        billAmountLabel.alpha = 0;
        billAmountTextField.alpha = 0;
        
        tipPercLabel.alpha = 0;
        tipControl.alpha = 0;
        
        peopleLabel.alpha = 0;
        peopleStepper.alpha = 0;
        peopleCountLabel.alpha = 0;
        
        tipPPLabel.alpha = 0;
        tipPPAmountLabel.alpha = 0;
        totalPPLabel.alpha = 0;
        totalPPAmountLabel.alpha = 0;
        
        tipLabel.alpha = 0;
        tipAmountLabel.alpha = 0;
        totalLabel.alpha = 0;
        totalAmountLabel.alpha = 0;
        
        currencyExchangeLabel.alpha = 0;
        
        exchangeToLabel.alpha = 0;
        exchangeToPicker.alpha = 0;
        
        totalDiffCurrLabel.alpha = 0;
        totalAmountDiffCurrLabel.alpha = 0;
        
        animateNavBar();
        
    }
    
    func refreshDefaultTips(){
        
        let tips = defaults.array(forKey: "defaultTips");
        
        let selectedindex = defaults.integer(forKey: "DefaultTipSelection");
        
        if(tips != nil){
            let tip1Text = "\(tips?[0] ?? tip1Default)%" ;
            let tip2Text = "\(tips?[1] ?? tip2Default)%" ;
            let tip3Text = "\(tips?[2] ?? tip3Default)%" ;
            
            tipControl.setTitle(tip1Text, forSegmentAt: 0);
            tipControl.setTitle(tip2Text, forSegmentAt: 1);
            tipControl.setTitle(tip3Text, forSegmentAt: 2);
        }
        
        tipControl.selectedSegmentIndex = selectedindex;
        
    }

    func refreshColorMode(){
        let colormode = defaults.string(forKey: "DarkModeSwitchState");
        
        if(colormode != nil){
            if(colormode == "On"){
                setColorsforDarkMode();
            }
            else{
                setColorsforLightMode();
            }
        }
        else{
            setColorsforLightMode();
        }
    }
    
    func setColorsforDarkMode(){
        view.backgroundColor = UIColor.black;
        
        tipCalcNavBar.barTintColor = UIColor.black;
        tipCalcNavBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)];
        tipCalcNavBar.setTitleVerticalPositionAdjustment(1, for: UIBarMetrics.default);
        
        billAmountLabel.textColor = UIColor.white;
        billAmountTextField.keyboardAppearance = UIKeyboardAppearance.dark;
        
        tipPercLabel.textColor = UIColor.white;
        tipControl.backgroundColor = UIColor.white;
        tipControl.selectedSegmentTintColor = UIColor.green;
        
        peopleLabel.textColor = UIColor.white;
        peopleStepper.backgroundColor = UIColor.white;
        peopleCountLabel.textColor = UIColor.white;
        
        tipPPLabel.textColor = UIColor.white;
        tipPPAmountLabel.textColor = UIColor.green;
        totalPPLabel.textColor = UIColor.white;
        totalPPAmountLabel.textColor = UIColor.green;
        
        tipLabel.textColor = UIColor.white;
        tipAmountLabel.textColor = UIColor.green;
        totalLabel.textColor = UIColor.white;
        totalAmountLabel.textColor = UIColor.green;
        
        exchangeToLabel.textColor = UIColor.white;
        
        totalDiffCurrLabel.textColor = UIColor.white;
        totalAmountDiffCurrLabel.textColor = UIColor.green;
        
    }
    
    func setColorsforLightMode(){
        view.backgroundColor = UIColor.white;
        
        tipCalcNavBar.barTintColor = nil;
        tipCalcNavBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)];
        tipCalcNavBar.setTitleVerticalPositionAdjustment(1, for: UIBarMetrics.default);
        
        billAmountLabel.textColor = UIColor.black;
        billAmountTextField.keyboardAppearance = UIKeyboardAppearance.default;
        
        tipPercLabel.textColor = UIColor.black;
        tipControl.backgroundColor = UIColor.white;
        tipControl.selectedSegmentTintColor = UIColor.green;
        
        peopleLabel.textColor = UIColor.black;
        peopleStepper.backgroundColor = UIColor.white;
        peopleCountLabel.textColor = UIColor.black;
        
        tipPPLabel.textColor = UIColor.black;
        tipPPAmountLabel.textColor = UIColor.black;
        totalPPLabel.textColor = UIColor.black;
        totalPPAmountLabel.textColor = UIColor.black;
        
        tipLabel.textColor = UIColor.black;
        tipAmountLabel.textColor = UIColor.black;
        totalLabel.textColor = UIColor.black;
        totalAmountLabel.textColor = UIColor.black;
        
        exchangeToLabel.textColor = UIColor.black;
        
        totalDiffCurrLabel.textColor = UIColor.black;
        totalAmountDiffCurrLabel.textColor = UIColor.black;
        
    }
    
    func refreshBillAmount(){
        
        let lastdate = defaults.object(forKey: "LastTimeBillAmountChanged");
        
        
        if(lastdate != nil){
            
            let diff = -1 * Date().distance(to: lastdate as! Date);
            
            if(diff >= refreshTime) {
                billAmountTextField.text = "";
                refreshAnimation();
            }
            else{
                billAmountTextField.text = defaults.string(forKey: "Bill Amount");
            }
        }
        else {
            refreshAnimation();
        }
        
        updateTip();
        
    }
    
    func updateTip(){
        
        let bill = Double(billAmountTextField.text!) ?? 0;
        
        let tips = defaults.array(forKey: "defaultTips") ?? [tip1Default, tip2Default, tip3Default];
        
        let people = Double(peopleCountLabel.text!) ?? 1.0;
        
            
        let tip = ((tips[tipControl.selectedSegmentIndex] as! Double) / 100) * bill ;
            
        let total = bill + tip;
        let totalPP = total / people;
        let tipPP = tip / people;
        
        tipPPAmountLabel.text = localeFormatter.string(from: (tipPP as NSNumber));
        totalPPAmountLabel.text = localeFormatter.string(from: (totalPP as NSNumber));
        tipAmountLabel.text = localeFormatter.string(from: (tip as NSNumber));
        totalAmountLabel.text = localeFormatter.string(from: (total as NSNumber));
        
        //print("before:", currencyCodes);
        //print("total:",total);
        if(currencyCodes.count == 0) {
            //print("inside if");
            getConversion(convertFrom: localeFormatter.locale.currencyCode!, convertTo: "", total: String(total));
        }
        else {
            //print("inside else");
            getConversion(convertFrom: localeFormatter.locale.currencyCode!, convertTo: currencyCodes[exchangeToPicker.selectedRow(inComponent: 0)], total: String(total));
        }
        
        //print("after:", currencyCodes);
        //print("total:",total);
        
        
    }
        
        
    
    
    @IBAction func calculateTip(_ sender: Any) {
        updateTip();
    }
    
    @IBAction func billAmountTextFieldChanged(_ sender: Any) {
        
        defaults.set(billAmountTextField.text!, forKey: "Bill Amount");
        
        defaults.set(Date(), forKey:"LastTimeBillAmountChanged");
        
        //defaults.synchronize();
        
        updateTip();
    }
    
    @IBAction func peopleStepperChanged(_ sender: Any){
        peopleCountLabel.text = String(Int(peopleStepper.value));
        
        updateTip();
    }
    
    func animateNavBar(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.tipCalcNavBar.alpha = 1;
        }, completion: { (true) in
            self.animateBillAmount()
        });
    }
    
    func animateBillAmount(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.billAmountLabel.alpha = 1;
            self.billAmountTextField.alpha = 1;
        }, completion: { (true) in
            self.animateTipControl()
        });
    }
    
        
    func animateTipControl(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.tipPercLabel.alpha = 1;
            self.tipControl.alpha = 1;
        }, completion: {(true) in
            self.animatePeople()
        });
    }
    
    func animatePeople(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.peopleLabel.alpha = 1;
            self.peopleStepper.alpha = 1;
            self.peopleCountLabel.alpha = 1;
        }, completion: {(true) in
            self.animateTip()
        });
    }
    
    func animateTip(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.tipPPLabel.alpha = 1;
            self.tipPPAmountLabel.alpha = 1;
            self.tipLabel.alpha = 1;
            self.tipAmountLabel.alpha = 1;
        }, completion: {(true) in
            self.animateTotal()
        });
    }
        
    func animateTotal(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.totalPPLabel.alpha = 1;
            self.totalPPAmountLabel.alpha = 1;
            self.totalLabel.alpha = 1;
            self.totalAmountLabel.alpha = 1;
        }, completion: {(true) in
            self.animateCurrencyExchangerLabel()
        });
    }
    
    func animateCurrencyExchangerLabel(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.currencyExchangeLabel.alpha = 1;
        }, completion: {(true) in
            self.animateExchangeTo()
        });
    }
    
    func animateExchangeTo(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.exchangeToLabel.alpha = 1;
            self.exchangeToPicker.alpha = 1;
        }, completion: {(true) in
            self.animateTotalExchange()
        });
    }
    
    func animateTotalExchange(){
        UIView.animate(withDuration: self.animationTime, animations: {
            self.totalDiffCurrLabel.alpha = 1;
            self.totalAmountDiffCurrLabel.alpha = 1;
        }, completion: {(true) in
            self.billAmountTextField.becomeFirstResponder()
        });
    }
    
    func fetchConversionFromServerOLD(convertFrom: String, convertTo: String, amount: String, completion: @escaping () -> Void){ // Before Swift 5.5
        
        self.currencyCodes = [];
        
        // Link to their website https://exchangerate.host/#/
        
        guard var urlComponents = URLComponents(string: "https://api.exchangerate.host/latest") else {
            print("Link does not work, Exited!");
            return;
        };
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "from", value: convertFrom),
            URLQueryItem(name: "to", value: convertTo), // Need to get it from picker view
            URLQueryItem(name: "amount", value: amount),
            URLQueryItem(name: "places", value: "2"),
            URLQueryItem(name: "base", value: convertFrom)
        ]
    
        print(urlComponents.url!);
        
        let request = URLRequest(url: urlComponents.url!);
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
        
            if(error != nil) {
                print("Error:",error as Any);
                
            }
            else {
                if let content = data {
                    do {
                        let JSONCurrencyRateObject = try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject;
                        
                        //print(JSONCurrencyRateObject);
                    
                        if let rates = JSONCurrencyRateObject!["rates"] as? NSDictionary {
                            
                            //print(rates);
                            
                            for (countryCode, value) in rates {
                        
                                DispatchQueue.main.async {
                                    self.currencyCodes.append(countryCode as! String);
                                    if((countryCode as! String) == convertTo){
                                        self.convertedValue = value as? Double ?? 0;
                                    }
                                }
                            }
                            completion();
                        }
                    }
                }
            }
        }
        task.resume();
        
    }
    
    func getConversion(convertFrom: String, convertTo: String, total: String){
        
        if(defaults.string(forKey: "ConverterModeSwitchState") == "On") {
            
            fetchConversionFromServerOLD(convertFrom: convertFrom, convertTo: convertTo, amount: total) {
                DispatchQueue.main.async { [self] in
                    
                    currencyCodes = Array(Set(currencyCodes));
                    currencyCodes.sort();
                    
                    exchangeToPicker.reloadComponent(0);
                    
                    foreignFormatter.currencySymbol = getSymbol(forCurrencyCode: convertTo);
                    foreignFormatter.numberStyle = .currency;
                    
                    totalAmountDiffCurrLabel.text = foreignFormatter.string(from: (convertedValue as NSNumber));
                    
                    if(convertTo == ""){
                        updateTip();
                    }
                }
                

            }
        }
        
    }
    
    
    func refreshCurrencyExchangerView(){
        let convertermode = defaults.string(forKey: "ConverterModeSwitchState");
        if(convertermode != nil){
            if(convertermode == "On"){
                currencyExchangeLabel.isHidden = false;
                exchangeToLabel.isHidden = false;
                exchangeToPicker.isHidden = false;
                totalDiffCurrLabel.isHidden = false;
                totalAmountDiffCurrLabel.isHidden = false;
            }
            else{
                currencyExchangeLabel.isHidden = true;
                exchangeToLabel.isHidden = true;
                exchangeToPicker.isHidden = true;
                totalDiffCurrLabel.isHidden = true;
                totalAmountDiffCurrLabel.isHidden = true;
            }
        }
        else {
            currencyExchangeLabel.isHidden = true;
            exchangeToLabel.isHidden = true;
            exchangeToPicker.isHidden = true;
            totalDiffCurrLabel.isHidden = true;
            totalAmountDiffCurrLabel.isHidden = true;
        }
        
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(currencyCodes.count);
        return currencyCodes.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return currencyCodes[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if(currencyCodes.count == 0){
            return NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor:exchangeToLabel.textColor!]);
        }
        else {
            return NSAttributedString(string: String(currencyCodes[row]), attributes: [NSAttributedString.Key.foregroundColor:exchangeToLabel.textColor!]);
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTip();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConfiguredSettings();
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

}


