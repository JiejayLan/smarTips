//
//  ViewController.swift
//  tipcalculator
//
//  Created by Jie Lan on 2018/6/3.
//  Copyright © 2018年 Jie Lan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipName: UILabel!
    @IBOutlet weak var eachName: UILabel!
    @IBOutlet weak var totalame: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var peopleslider: UISlider!
    @IBOutlet weak var eachBillLabel: UILabel!
    
    let lightBackground = UIColor(red: 86/255, green: 103/255, blue: 186/255, alpha: 1)
    let lightMaxslider = UIColor.white
    let lightText = UIColor.white
    let darkBackground = UIColor(red: 35/255, green: 42/255, blue: 54/255, alpha: 1)
    let darkMaxslider = UIColor.white
    let darkText = UIColor.white
    
    //Use locale specific currency and currency thousands separator.
    func formatOutput(double: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        var output = "NULL"
        let formattedTipAmount = formatter.string(from: double as NSNumber)
        output = formattedTipAmount!
        
        return output
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // keyboard is always visible and the bill amount is always the first responder.
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //invisible the keyboard when you tap
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    //update the tips and total bill
    @IBAction func calculatetip(_ sender: Any){
        let tipPercentage = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill*tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let number = Int(peopleslider.value)
        let eachAmount = total/Double(number)
        
        tipLabel.text = formatOutput(double: tip)
        totalLabel.text=formatOutput(double: total)
        eachBillLabel.text = formatOutput(double: eachAmount)
        
        //store the default bill and time
        let date: Double = NSDate().timeIntervalSince1970
        let defaults = UserDefaults.standard
        defaults.set(date, forKey: "preDate")
        defaults.set(bill, forKey: "preBill")
        defaults.synchronize()
    }
    
    //update tip when slider changes
    @IBAction func sliderchange(_ sender: UISlider) {
        let people=Int(sender.value)
        peopleLabel.text=String(format: "%d",people)
        calculatetip(1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //update the tip percentage
        let defaults = UserDefaults.standard
        let percentSetting = defaults.integer(forKey: "tip_percent")
        tipControl.selectedSegmentIndex = percentSetting
        
        //update the theme
        let theme = defaults.integer(forKey: "theme")
        
        if theme == 0 {
            //update color
            self.view.backgroundColor = lightBackground
            tipControl.backgroundColor=lightBackground
            tipControl.tintColor = lightText
            tipName.textColor=lightText
            tipLabel.textColor = lightText
            totalLabel.textColor = lightText
            eachName.textColor=lightText
            eachBillLabel.textColor=lightText
            totalame.textColor=lightText
            peopleLabel.textColor=lightText
            peopleslider.tintColor=lightText
            peopleslider.maximumTrackTintColor=lightMaxslider
            
            //change background
            image2.isHidden=true
            image1.isHidden=false
        }
        else{
            //update color
            self.view.backgroundColor = darkBackground
            tipControl.backgroundColor=darkBackground
            tipControl.tintColor = darkText
            tipName.textColor=darkText
            tipLabel.textColor = darkText
            totalLabel.textColor = darkText
            eachName.textColor=darkText
            eachBillLabel.textColor=darkText
            totalame.textColor=darkText
            peopleLabel.textColor=darkText
            peopleslider.tintColor=darkText
            peopleslider.maximumTrackTintColor=darkMaxslider
            
            //change background
            image2.isHidden=false
            image1.isHidden=true
        }

        //restore the bill in 10 minutes
        let bill = defaults.double(forKey: "preBill")
        let date1 = defaults.double(forKey: "preDate")
        let date: Double = NSDate().timeIntervalSince1970
        if(date1 - date < 600){
            if(bill==0){
                billField.text = String()
            }
            else{
                billField.text = String(format: "%0.2f", bill)
            }
        }
        calculatetip(1)
    }
    
}

