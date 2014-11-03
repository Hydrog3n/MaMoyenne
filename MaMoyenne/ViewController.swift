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
    var moyenne:Float = 0
    var nbNotes:Float = 0
    var listeNotes = [NSString: Array<Float>]()
    
    //Variables du design
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var infoMoyenne: UILabel!
    @IBOutlet weak var matiereField: UITextField!
    
    //Functions d'action depuis l'interface
    @IBAction func removeAllNote(sender: UIButton) {
        if( nbNotes != 0){
            let alert = UIAlertController(title: "Attention", message:"Vos notes vont être supprimés", preferredStyle: UIAlertControllerStyle.ActionSheet)
            // bouton annuler
            alert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
            
            let AddAction = UIAlertAction(title: "Supprimer", style: UIAlertActionStyle.Default) { (action) in
                self.listeNotes.removeAll(keepCapacity: false)
                self.saveList("listeNotes")
                self.calculMoyenne()
                self.updateAffichage()
            }
            alert.addAction(AddAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func addNote(sender: UIButton) {
        //On debale l'optionnel si c'est un entier
        //noteField.text.bridgeToObjectiveC().doubleValue
        let note = (noteField.text as NSString).floatValue
        
        //On verifie que la matiere ne soit pas vide
        if !matiereField.text.isEmpty {
            //On verifie que ce soit entre 0 et 20
            if (note <= 20 && note >= 0){
                //Ajout de la note dans la liste, mise à jour de l'affichage et sauvegarde de la liste
                ajoutNote(note, matiere:matiereField.text)
                calculMoyenne()
                updateAffichage()
                saveList("listeNotes")
                //saveList("listeMatieres")
            }
            else {
                // afficher les message sur l'alert
                alertError("Votre note est Invalide !", msg: "Comprise entre 0 et 20")
            }
        }
        else {
            alertError("Erreur d'ajout", msg: "La matiere est vide ou ne convient pas")
        }
        //Vidange des champs
        noteField.text = ""
        noteField.resignFirstResponder()
        matiereField.text = ""
        matiereField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if var list = reglageUtilisateurs.valueForKey("listeNotes") as? Dictionary<NSString,Array<Float>> {
            listeNotes = list
            calculMoyenne()
        }
        //Mise a jour de l'affichage du nb de note de la moyenne sur le label
        updateAffichage()
        println(listeNotes)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Reccuptération de la liste de note dans la sauvegarde
        //Remplisage du tableau et mise à jour de la moyenne
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Au changement de la vue on transfere la liste de note
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "afficheListe"{
            var TableVC = segue.destinationViewController as TableViewController
            //            TableVC.listeNotes = listeNotes
            //            TableVC.listeMatieres = listeMatieres
            //println(TableVC.listeNotes)
            TableVC.viewC = self
        }
    }
    
    //Ajout de la note dans la liste de la classe
    func ajoutNote(note:Float,matiere:NSString) {
        var matiere = matiere.lowercaseString
        matiere = matiere.capitalizedString
        //ajout de la note dans la liste
        if listeNotes[matiere] != nil {
            listeNotes[matiere]!.append(note)
        } else {
            listeNotes[matiere] = [note]
        }
        
        println(listeNotes)
        //calcul de la nouvelle moyenne
        //calculMoyenne()
    }
    
    //Mise a jour de l'affichage dans le label
    func updateAffichage() {
        let moyenneString = NSString(format: "%.2f", moyenne)
        infoMoyenne.text = "\(Int(nbNotes)) Note\(pluriel(Int(nbNotes))). \(moyenneString) de moyenne"
    }
    
    //Calcul de la moyenne
    func calculMoyenne() {
        moyenne = 0
        nbNotes = 0
        for matiere in listeNotes.keys {
            var notes = listeNotes[matiere]! as Array<Float>
            for note in notes {
                moyenne = moyenne + note
                nbNotes++
            }
        }
        if nbNotes > 0 {
            moyenne = moyenne/nbNotes
        }
    }
    
    //Sauvegarde de la liste dans le NSUserDefault
    func saveList(key:String) {
        reglageUtilisateurs.setObject(listeNotes, forKey: key)
        reglageUtilisateurs.synchronize()
    }
    
    //Generation d'une alerte pour signaler une erreur
    func alertError(title : String, msg : String){
        var alert : UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.ActionSheet)
        self.presentViewController(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    }
    
    func pluriel(nb: Int) -> NSString {
        var pluriel = ""
        if nb > 1 {
            pluriel = "s"
        }
        return pluriel
    }
    
}

