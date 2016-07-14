//
//  SettingsViewController.swift
//  ShowerTime
//
//  Created by Teddy Liang on 7/13/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var showerFlowRateField: UITextField!
    @IBOutlet weak var amountWaterUsedField: UITextField!
    @IBOutlet weak var waterBillField: UITextField!
    @IBOutlet weak var priceGallonLabel: UILabel!
    @IBOutlet weak var showerTimeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let roundedPriceGallon = round(100*(roundedWaterBill/roundedAmountWaterUsed))/100
        priceGallonLabel.text = "\(roundedPriceGallon)"

    }


}