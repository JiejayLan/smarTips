//
//  settingViewController.swift
//  tipcalculator
//
//  Created by Jie Lan on 2018/6/4.
//  Copyright © 2018年 Wing. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {

    @IBOutlet weak var popup: UIVisualEffectView!
    @IBOutlet weak var theme: UISegmentedControl!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //update the default setting
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let percentIndex = defaults.integer(forKey: "tip_percent")
        tipControl.selectedSegmentIndex = percentIndex
        let colorIndex = defaults.integer(forKey: "theme")
        theme.selectedSegmentIndex = colorIndex
    }
    
    //update default setting when tip percentage change
    @IBAction func tipPercentageChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        let index = tipControl.selectedSegmentIndex
        
        defaults.set(index, forKey: "tip_percent")
        defaults.synchronize()
    }
    
    //update the theme setting when change the theme
    @IBAction func themecontrol(_ sender: Any) {
        let defaults = UserDefaults.standard
        let index = theme.selectedSegmentIndex
        defaults.set(index, forKey: "theme")
        let themeColor = defaults.integer(forKey: "theme")
        defaults.synchronize()
        
        // Assign theme selection
        switch themeColor {
        case 0...2:
            theme.selectedSegmentIndex = themeColor
        default:
            theme.selectedSegmentIndex = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popup.alpha=0;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //update button link to the app store
    @IBAction func updataButton(_ sender: Any) {
        let application=UIApplication.shared
        application.openURL(NSURL(string: "https://www.apple.com/ios/app-store/")! as URL);
    }
    
    //close button for the popup view
    @IBAction func close(_ sender: Any) {
        popup.alpha=0;
    }
    
    //more information button for the popup view
    @IBAction func open(_ sender: Any) {
        popup.transform=CGAffineTransform(scaleX: 0.4, y: 2.1)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {self.popup.transform = .identity}) {(success) in}
        popup.alpha=1;
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
