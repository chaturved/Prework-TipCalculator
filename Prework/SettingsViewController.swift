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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        
        if(darkModeSwitch.isOn){
            setColorsforDarkMode();
            defaults.set("On", forKey: "DarkModeSwitchState");
        }
        else {
            setColorsforLightMode();
            defaults.set("Off", forKey: "DarkModeSwitchState");
        }
    }
    
    func setColorsforDarkMode(){
        
        view.backgroundColor = UIColor.black;
        settingsNavBar.barTintColor = UIColor.black;
        darkModeLabel.textColor = UIColor.white;
        
    }
    
    func setColorsforLightMode(){
        
        view.backgroundColor = UIColor.white;
        settingsNavBar.barTintColor = nil;
        darkModeLabel.textColor = UIColor.black;
        
    }
    
    func refreshColorMode(){
        let colormode = defaults.string(forKey: "DarkModeSwitchState");
        
        if(colormode != nil){
            if(colormode == "On"){
                darkModeSwitch.setOn(true, animated: true)
                setColorsforDarkMode();
            }
            else{
                darkModeSwitch.setOn(false, animated: false)
                setColorsforLightMode();
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        refreshColorMode();
    }
    
}
