//
//  ViewController.swift
//  MaMoyenne
//
//  Created by Loic on 19/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let reglageUtilisateurs = NSUserDefaults.standardUserDefaults()
    var moyenne = 0
    var nbNotes = 0
    
    @IBOutlet weak var noteField: UITextField!
    
    @IBOutlet weak var infoMoyenne: UILabel!
    @IBAction func addNote(sender: AnyObject) {
        if let note = noteField.text.toInt() {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        if var listeNotes = reglageUtilisateurs.valueForKey("listeNote") as? Array<Int> {
            var total = 0
            nbNotes = listeNotes.count
            for note in listeNotes {
                total = total + note
            }
            if nbNotes > 0 {
                moyenne = total/nbNotes
            }
        }
        infoMoyenne.text = "\(nbNotes) Note(s). \(moyenne) de moyenne"
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "addNote"{
            let TableVC = segue.destinationViewController as TableViewController
            
        }
    }


}

