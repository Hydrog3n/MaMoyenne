//
//  TableViewController.swift
//  MaMoyenne
//
//  Created by Loic on 20/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIAlertViewDelegate {
    
    
    var viewC = ViewController ()
    var matiere:Array<NSString> = []
    @IBAction func ButtonAlert(sender: UIBarButtonItem) {
        // afficher les message sur l'alert
        let alert = UIAlertController(title: "Ajouter une nouvelle note", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        //ajout bouton annuler
        alert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
        // bouton ajouter dans l'alert
        let AddAction = UIAlertAction(title: "Ajouter", style: UIAlertActionStyle.Default) { (action) in
            let noteField = alert.textFields![0] as UITextField
            let matiereField = alert.textFields![1] as UITextField
            let note = (noteField.text as NSString).floatValue
            //On verifie si notefield est vide
            if !noteField.text.isEmpty{
                //on verifie si matierfield est vide
                if !matiereField.text.isEmpty{
                    if  (note >= 0 && note <= 20)  {
                        self.viewC.ajoutNote(note, matiere:matiereField.text)
                        self.tableView.reloadData()
                        self.viewC.saveList("listeNotes")
                        self.viewC.calculMoyenne()
                        self.viewC.updateAffichage()
                    } else {
                        self.viewC.alertError("Erreur d'ajout", msg: "La note est comprise entre 0 et 20")
                    }
                } else {
                    self.viewC.alertError("Erreur d'ajout", msg: "La matiere est vide")
                }
            } else {
                self.viewC.alertError("Erreur d'ajout", msg: "La note est vide")
            }
        }
        alert.addAction(AddAction)
        
        // ajout d'un champs text
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Note"
            textField.secureTextEntry = false
            textField.keyboardType = UIKeyboardType.DecimalPad
        })
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Matiere"
            textField.secureTextEntry = false
        })
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewC.listeNotes.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        matiere = Array(self.viewC.listeNotes.keys)
        var notes:Array<Float> = self.viewC.listeNotes[matiere[section]]!
        return notes.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let listeNotes = self.viewC.listeNotes
        let matiere = Array(listeNotes.keys)
        var nbNotes = listeNotes[matiere[section]]!.count
        var pluriel = self.viewC.pluriel(nbNotes)
        return  "\(matiere[section]) (\(nbNotes) Note\(pluriel))"
    }
    //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var listeNotes = self.viewC.listeNotes
        let matiere = Array(listeNotes.keys)
        var moyenne:Float = 0
        var notes:Array<Float> = self.viewC.listeNotes[matiere[section]]!
        var nbNotes = Float(notes.count)
        for note in notes {
            moyenne = moyenne + note
        }
        moyenne = moyenne/nbNotes
        let moyenneString = NSString(format: "%.2f", moyenne)
        return "Moyenne : \(moyenneString)/20"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notes", forIndexPath: indexPath) as UITableViewCell
        
        var notes:Array<Float> = self.viewC.listeNotes[matiere[indexPath.section]]!
        cell.textLabel?.text = "\(notes[indexPath.row])/20"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var matiere = Array(self.viewC.listeNotes.keys)
            var listeNotes = self.viewC.listeNotes
            self.viewC.listeNotes[matiere[indexPath.section]]!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],withRowAnimation: UITableViewRowAnimation.Automatic)
            if self.viewC.listeNotes[matiere[indexPath.section]]?.count == 0 {
                self.viewC.listeNotes.removeValueForKey(matiere[indexPath.section])!
            }
            self.viewC.saveList("listeNotes")
            tableView.reloadData()
            self.viewC.calculMoyenne()
            self.viewC.updateAffichage()
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    
    }
    }
    */
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    let reglageUtilisateurs = NSUserDefaults.standardUserDefaults()
    
}
