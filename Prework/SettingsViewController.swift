//
//  SettingsViewController.swift
//  Prework
//
//  Created by Chaturved Sumanth Lakkaraju on 22/12/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var settingsNavBar: UINavigationBar!
    
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    
    @IBOutlet weak var defaultTipsLabel: UILabel!
    
    
    @IBOutlet weak var defaultTip1Label: UILabel!
    @IBOutlet weak var defaultTip1TextField: UITextField!
    
    
    @IBOutlet weak var defaultTip2Label: UILabel!
    @IBOutlet weak var defaultTip2TextField: UITextField!
    
    @IBOutlet weak var defaultTip3Label: UILabel!
    @IBOutlet weak var defaultTip3TextField: UITextField!
    
    
    @IBOutlet weak var defaultTipSelLabel: UILabel!
    @IBOutlet weak var defaultTipSelCtrl: UISegmentedControl!
    
    let tip1Default: Double = 15;
    let tip2Default: Double = 18;
    let tip3Default: Double = 20;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setConfiguredSettings();
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setConfiguredSettings(){
        refreshColorMode();
        refreshDefaultTips();
        refreshDefaultTipsSelector();
    }
    
    
    @IBAction func changeDefaultTip(_ sender: Any) {
        let selectedindex = defaultTipSelCtrl.selectedSegmentIndex;
        
        defaults.set(selectedindex, forKey: "DefaultTipSelection");
        //defaults.synchronize();
        
    }
    
    @IBAction func defaultTipTextFieldChanged(){
        
        let tip1 = (Double(defaultTip1TextField.text!) ?? tip1Default);
        let tip2 = (Double(defaultTip2TextField.text!) ?? tip2Default);
        let tip3 = (Double(defaultTip3TextField.text!) ?? tip3Default);
        
        let tips =  [tip1, tip2, tip3];
        
        defaults.set(tips, forKey: "defaultTips");
        
        //defaults.synchronize();
        
        refreshDefaultTipsSelector();
        
    }
    
    
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        
        if(darkModeSwitch.isOn){
            setColorsforDarkMode();
            defaults.set("On", forKey: "DarkModeSwitchState");
        }
        else {
            setColorsforLightMode();
            defaults.set("Off", forKey: "DarkModeSwitchState");
        }
        
        //defaults.synchronize();
    }
    
    func setColorsforDarkMode(){
        
        view.backgroundColor = UIColor.black;
        settingsNavBar.barTintColor = UIColor.black;
        settingsNavBar.setTitleVerticalPositionAdjustment(1, for: UIBarMetrics.default);
        
        darkModeLabel.textColor = UIColor.orange;
        
        defaultTipsLabel.textColor = UIColor.yellow;
        
        defaultTip1Label.textColor = UIColor.green;
        defaultTip1TextField.keyboardAppearance = UIKeyboardAppearance.dark;
        defaultTip2Label.textColor = UIColor.green;
        defaultTip2TextField.keyboardAppearance = UIKeyboardAppearance.dark;
        defaultTip3Label.textColor = UIColor.green;
        defaultTip3TextField.keyboardAppearance = UIKeyboardAppearance.dark;
        
        defaultTipSelLabel.textColor = UIColor.yellow;
        defaultTipSelCtrl.backgroundColor = UIColor.white;
        defaultTipSelCtrl.selectedSegmentTintColor = UIColor.systemPink;
        
        
    }
    
    func setColorsforLightMode(){
        
        view.backgroundColor = UIColor.white;
        
        settingsNavBar.barTintColor = nil;
        settingsNavBar.setTitleVerticalPositionAdjustment(1, for: UIBarMetrics.default);
        
        darkModeLabel.textColor = UIColor.black;
        
        defaultTipsLabel.textColor = UIColor.systemPink;
        
        defaultTip1Label.textColor = UIColor.black;
        defaultTip1TextField.keyboardAppearance = UIKeyboardAppearance.default;
        defaultTip2Label.textColor = UIColor.black;
        defaultTip1TextField.keyboardAppearance = UIKeyboardAppearance.default;
        defaultTip3Label.textColor = UIColor.black;
        defaultTip1TextField.keyboardAppearance = UIKeyboardAppearance.default;
        
        defaultTipSelLabel.textColor = UIColor.black;
        defaultTipSelCtrl.backgroundColor = UIColor.white;
        defaultTipSelCtrl.selectedSegmentTintColor = UIColor.systemPink;
        
    }
    
    func refreshColorMode(){
        let colormode = defaults.string(forKey: "DarkModeSwitchState");
        
        if(colormode != nil){
            if(colormode == "On"){
                darkModeSwitch.setOn(true, animated: true)
                setColorsforDarkMode();
            }
            else{
                darkModeSwitch.setOn(false, animated: true)
                setColorsforLightMode();
            }
        }
        else {
            setColorsforLightMode();
        }
    }
    
    func refreshDefaultTips(){
        
        let tips = defaults.array(forKey: "defaultTips");
        
        if(tips != nil){
            defaultTip1TextField.text = "\(tips?[0] ?? tip1Default)";
            defaultTip2TextField.text = "\(tips?[1] ?? tip2Default)";
            defaultTip3TextField.text = "\(tips?[2] ?? tip3Default)";
        }
        
    }
    
    func refreshDefaultTipsSelector(){
        let tips = defaults.array(forKey: "defaultTips");
        let selectedindex = defaults.integer(forKey: "DefaultTipSelection");
        
        
        if(tips != nil){
            defaultTipSelCtrl.setTitle("\(tips?[0] ?? tip1Default)%", forSegmentAt: 0);
            defaultTipSelCtrl.setTitle("\(tips?[1] ?? tip2Default)%", forSegmentAt: 1);
            defaultTipSelCtrl.setTitle("\(tips?[2] ?? tip3Default)%", forSegmentAt: 2);
        }
        
        
        defaultTipSelCtrl.selectedSegmentIndex = selectedindex;
            
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
