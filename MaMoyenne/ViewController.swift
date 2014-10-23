//
//  ViewController.swift
//  MaMoyenne
//
//  Created by Loic on 19/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    //Variables de la classe
    let reglageUtilisateurs = NSUserDefaults.standardUserDefaults()
    var moyenne = 0
    var listeNotes:Array<Int> = []
    var listeMatieres:Array<NSString> = []
    
    //Variables du design
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var infoMoyenne: UILabel!
    
    //Functions d'action depuis l'interface
    @IBAction func addNote(sender: UIButton) {
        //On debale l'optionnel si c'est un entier
        if let note = noteField.text.toInt() {
            //On verifie que ce soit entre 0 et 20
            //Ajout de la note dans la liste, mise à jour de l'affichage et sauvegarde de la liste
            if (note <= 20 && note >= 0){
                ajoutNote(note)
                updateAffichage()
                saveList()
            }
            else {
                // afficher les message sur l'alert
                var alert : UIAlertView = UIAlertView(title: "Votre note est Invalide !", message: "Comprise entre 0 et 20",       delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        //Vidange des champs
        noteField.text = ""
        noteField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Reccuptération de la liste de note dans la sauvegarde
        //Remplisage du tableau et mise à jour de la moyenne
        if var list:Array<Int> = reglageUtilisateurs.valueForKey("listeNote") as? Array<Int> {
            listeNotes = list
            calculMoyenne()
        }
        //Mise a jour de l'affichage du nb de note de la moyenne sur le label
        updateAffichage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Au changement de la vue on transfere la liste de note
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "afficheListe"{
            var TableVC = segue.destinationViewController as TableViewController
            TableVC.listeNotes = listeNotes
            println(TableVC.listeNotes)
        }
    }
    
    //Ajout de la note dans la liste de la classe
    func ajoutNote(note:Int) {
        //ajout de la note dans la liste
        listeNotes.append(note)
        //calcul de la nouvelle moyenne
        calculMoyenne()
    }
    
    //Mise a jour de l'affichage dans le label
    func updateAffichage() {
        infoMoyenne.text = "\(listeNotes.count) Note(s). \(moyenne) de moyenne"
    }
    
    //Calcul de la moyenne
    func calculMoyenne() {
        for note in listeNotes {
            moyenne = moyenne + note
        }
        if listeNotes.count > 0 {
            moyenne = moyenne/listeNotes.count
        }
    }
    
    //Sauvegarde de la liste dans le NSUserDefault
    func saveList() {
        reglageUtilisateurs.setObject(listeNotes, forKey: "listeNote")
        reglageUtilisateurs.synchronize()
    }
}

