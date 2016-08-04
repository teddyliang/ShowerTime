//
//  SettingsViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
class SettingsViewController: UIViewController {

    @IBOutlet weak var showerFlowRateField: UITextField!
    @IBOutlet weak var amountWaterUsedField: UITextField!
    @IBOutlet weak var waterBillField: UITextField!
    @IBOutlet weak var priceGallonLabel: UILabel!
    @IBOutlet weak var showerTimeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let hi = NSUserDefaults.standardUserDefaults()
        let hello = hi.doubleForKey("goalShower")
        showerTimeField.text = String(hello)
        let hihi = NSUserDefaults.standardUserDefaults()
        let hellohello = hihi.doubleForKey("showerFlow")
        showerFlowRateField.text = String(hellohello)
        let hihihi = NSUserDefaults.standardUserDefaults()
        let hellohellohello = hihihi.doubleForKey("roundedPrice")
        priceGallonLabel.text = String(hellohellohello)
        let hihihihi = NSUserDefaults.standardUserDefaults()
        let hellohellohellohello = hihihihi.doubleForKey("waterBillUsed")
        amountWaterUsedField.text = String(hellohellohellohello)
        let hihihihihi = NSUserDefaults.standardUserDefaults()
        let hellohellohellohellohello = hihihihihi.doubleForKey("waterBillAmount")
        waterBillField.text = String(hellohellohellohellohello)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func firstCalculatePriceGallon(sender: AnyObject) {
        guard let amountWaterUsed1 = Double(amountWaterUsedField.text!)
            else{
                return
            }
        guard let waterBill1 = Double(waterBillField.text!)
            else{
                return
        }
        let roundedAmountWaterUsed1 = round(100*amountWaterUsed1)/100
        let roundedWaterBill1 = round(100*waterBill1)/100
        var roundedPriceGallon1 = round(100*(roundedWaterBill1/roundedAmountWaterUsed1))/100
        priceGallonLabel.text = "\(roundedPriceGallon1)"
        
    }
    @IBAction func calculatePriceGallon(sender: AnyObject) {
        guard let amountWaterUsed = Double(amountWaterUsedField.text!)
            else{
                return
            }
        guard let waterBill = Double(waterBillField.text!)
            else{
                return
        }
        let roundedAmountWaterUsed = round(100*amountWaterUsed)/100
        let roundedWaterBill = round(100*waterBill)/100
        let roundedPriceGallon = round(1000*(roundedWaterBill/roundedAmountWaterUsed))/1000
        priceGallonLabel.text = "\(roundedPriceGallon)"
        let checking = NSUserDefaults.standardUserDefaults()
        checking.setDouble(roundedPriceGallon, forKey: "roundedPrice")

    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func confirmButton(sender: AnyObject) {
        if let isDouble = Double(showerTimeField.text!){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(round(Double(showerTimeField.text!)!), forKey: "goalShower")
            showerTimeField.text! = String(round(Double(showerTimeField.text!)!))
        }
        else{
            showerTimeField.text = ""
        }
        if let isDouble = Double(showerFlowRateField.text!){
            let check = NSUserDefaults.standardUserDefaults()
            let roundedFlowRate = round(100*Double(showerFlowRateField.text!)!)/100
            check.setDouble(roundedFlowRate,forKey: "showerFlow")
            showerFlowRateField.text! = String(roundedFlowRate)
        }
        else{
            showerFlowRateField.text = ""
        }
        if let isDouble = Double(amountWaterUsedField.text!){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(round(Double(amountWaterUsedField.text!)!), forKey: "waterBillUsed")
            amountWaterUsedField.text! = String(round(Double(amountWaterUsedField.text!)!*100)/100)
        }
        else{
            amountWaterUsedField.text = ""
        }
        if let isDouble = Double(waterBillField.text!){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setDouble(round(Double(waterBillField.text!)!), forKey: "waterBillAmount")
            waterBillField.text! = String(round(Double(waterBillField.text!)!*100)/100)
        }
        else{
            waterBillField.text = ""
        }
//        if let isDouble = Double(showerTimeField.text!){
//        let targetTime = Int(showerTimeField.text!)
//        let goalShowerTime = NSUserDefaults.standardUserDefaults()
//        goalShowerTime.setInteger(targetTime!,forKey: "timeOfShower")
//        }
//        else {
//            showerTimeField.text = ""
//        }
    }
    


}