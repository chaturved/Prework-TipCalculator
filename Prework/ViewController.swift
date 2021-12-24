//
//  ViewController.swift
//  Prework
//
//  Created by Chaturved Sumanth Lakkaraju on 21/12/21.
//

import UIKit

let defaults = UserDefaults.standard;

class ViewController: UIViewController {
    
    @IBOutlet weak var tipCalcNavBar: UINavigationBar!
    
    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setConfigureSettings();
    }
    
    func setConfigureSettings(){
        refreshColorMode();
        refreshBillAmount();
        
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
    }
    
    func setColorsforDarkMode(){
        view.backgroundColor = UIColor.black;
        tipCalcNavBar.barTintColor = UIColor.black;
        
        billAmountLabel.textColor = UIColor.white;
        
        tipLabel.textColor = UIColor.white;
        tipAmountLabel.textColor = UIColor.white;
        
        tipControl.backgroundColor = UIColor.white;
        tipControl.selectedSegmentTintColor = UIColor.green;
        
        totalLabel.textColor = UIColor.white;
        totalAmountLabel.textColor = UIColor.white;
    }
    
    func setColorsforLightMode(){
        view.backgroundColor = UIColor.white;
        tipCalcNavBar.barTintColor = nil;
        
        billAmountLabel.textColor = UIColor.black;
        billAmountTextField.backgroundColor = UIColor.white;
        
        tipLabel.textColor = UIColor.black;
        tipAmountLabel.textColor = UIColor.black;
        
        tipControl.backgroundColor = UIColor.white;
        tipControl.selectedSegmentTintColor = UIColor.yellow;
        
        totalLabel.textColor = UIColor.black;
        totalAmountLabel.textColor = UIColor.black;
        
    }
    
    func refreshBillAmount(){
        
        let lastdate = defaults.object(forKey: "LastTimeBillAmountChanged");
        
        
        if(lastdate != nil){
            
            let refreshTime = Double(600);
            let diff = -1 * Date().distance(to: lastdate as! Date);
            
            if(diff >= refreshTime) {
                billAmountTextField.text = "";
                updateTip();
            }
            else{
                billAmountTextField.text = defaults.string(forKey: "Bill Amount");
                updateTip();
            }
        }
        
    }
    
    func updateTip(){
        
        let bill = Double(billAmountTextField.text!) ?? 0;
        let tipPercentages = [0.15, 0.18, 0.20];
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        
        let total = bill + tip;
        
        tipAmountLabel.text = String(format: "$%.2f", tip);
        totalAmountLabel.text = String(format: "$%.2f", total);
        
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        updateTip();
    }
    
    @IBAction func billAmountTextFieldChanged(_ sender: Any) {
        
        defaults.set(billAmountTextField.text!, forKey: "Bill Amount");
        
        defaults.set(Date(), forKey:"LastTimeBillAmountChanged");
        
        defaults.synchronize();
        
        updateTip();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        setConfigureSettings();
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    

}

