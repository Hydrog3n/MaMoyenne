//
//  ViewController.swift
//  MaMoyenne
//
//  Created by Loic on 19/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var noteField: UITextField!
    
    @IBAction func addNote(sender: AnyObject) {
        if !noteField.text.isEmpty {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveNSUserDefault(value:AnyObject, key:NSString) {
        var userSettings = NSUserDefaults.standardUserDefaults()
        userSettings.objectForKey(key)
        userSettings.synchronize()
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if segue.identifier == "mySegue"{
//            let vc = segue.destinationViewController as TableViewController
//            vc.colorString = colorLabel.text
//            vc.delegate = self
//        }
//    }


}

