//
//  ViewController.swift
//  DialPad
//
//  Created by SmartNet-MacBookPro on 9/27/18.
//  Copyright © 2018 kartheek.in. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DialPadDelegate {

    @IBOutlet weak var dialPad: DialPad!
    
    @IBOutlet weak var txtNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dialPad.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    MARK: - DialPadDelegate
    
    func dialPadNumberDidChange(_ number: String?) {
        txtNumber.text = number
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

