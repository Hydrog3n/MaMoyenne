//
//  ViewController.swift
//  MaMoyenne
//
//  Created by Loic on 19/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    let reglageUtilisateurs = NSUserDefaults.standardUserDefaults()
    var moyenne = 0
    var nbNotes = 0
    var listeNotes:Array<Int> = []
    @IBOutlet weak var noteField: UITextField!
    
    @IBOutlet weak var infoMoyenne: UILabel!
    @IBAction func addNote(sender: UIButton) {
        
        if let note = noteField.text.toInt() {
            if (note <= 20 && note >= 0){
                listeNotes.append(note)
                ajoutNote(listeNotes)
                updateAffichage()
                saveList()
            }
                
            else {
                // afficher les message sur l'alert
                var alert : UIAlertView = UIAlertView(title: "Votre note est Invalide !", message: "Comprise entre 0 et 20",       delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        noteField.text = ""
        noteField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        if var list:Array<Int> = reglageUtilisateurs.valueForKey("listeNote") as? Array<Int> {
            ajoutNote(list)
        }
        updateAffichage()
        saveList()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "afficheListe"{
            var TableVC = segue.destinationViewController as TableViewController
            TableVC.listeNotes = listeNotes
            println(TableVC.listeNotes)
        }
    }
    
    func ajoutNote(list : Array<Int>) {
        listeNotes = list
        var total = 0
        nbNotes = listeNotes.count
        for note in listeNotes {
            total = total + note
        }
        if nbNotes > 0 {
            moyenne = total/nbNotes
        }
        
    }
    func updateAffichage() {
        infoMoyenne.text = "\(nbNotes) Note(s). \(moyenne) de moyenne"
    }
    func saveList() {
        reglageUtilisateurs.setObject(listeNotes, forKey: "listeNote")
        reglageUtilisateurs.synchronize()
    }
    
}

