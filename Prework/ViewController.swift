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
    
    let refreshTime: Double = 600;
    
    let tip1Default: Double = 15;
    let tip2Default: Double = 18;
    let tip3Default: Double = 20;
    
    let animationTime: Double = 0.6;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setConfiguredSettings(){
        refreshColorMode();
        refreshDefaultTips();
        refreshBillAmount();
        
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
        
    }
    
    func refreshBillAmount(){
        
        let lastdate = defaults.object(forKey: "LastTimeBillAmountChanged");
        
        
        if(lastdate != nil){
            
            let diff = -1 * Date().distance(to: lastdate as! Date);
            
            if(diff >= refreshTime) {
                billAmountTextField.text = "";
                updateTip();
                refreshAnimation();
            }
            else{
                billAmountTextField.text = defaults.string(forKey: "Bill Amount");
                updateTip();
            }
        }
        else {
            refreshAnimation();
        }
        
    }
    
    func updateTip(){
        
        let bill = Double(billAmountTextField.text!) ?? 0;
        
        let tips = defaults.array(forKey: "defaultTips") ?? [tip1Default, tip2Default, tip3Default];
        
        let people = Double(peopleCountLabel.text!) ?? 1.0;
        
            
        let tip = ((tips[tipControl.selectedSegmentIndex] as! Double) / 100) * bill ;
        
        
        
            
        let total = bill + tip;
        let totalPP = total / people;
        let tipPP = tip / people;
        
        
            
        let currentRegion = Locale.current;
        
        tipPPAmountLabel.text = String(format: "%@%@", currentRegion.currencySymbol!, ((round(tipPP * 100) / 100.0) as NSNumber).description(withLocale: currentRegion));
        
        totalPPAmountLabel.text = String(format: "%@%@", currentRegion.currencySymbol!, ((round(totalPP * 100) / 100.0) as NSNumber).description(withLocale: currentRegion));
            
        tipAmountLabel.text = String(format: "%@%@", currentRegion.currencySymbol!, ((round(tip * 100) / 100.0) as NSNumber).description(withLocale: currentRegion));
        
        totalAmountLabel.text = String(format: "%@%@", currentRegion.currencySymbol!, ((round(total * 100) / 100.0) as NSNumber).description(withLocale: currentRegion));
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
            self.billAmountTextField.becomeFirstResponder()
        });
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


