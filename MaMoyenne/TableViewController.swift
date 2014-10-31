//
//  TableViewController.swift
//  MaMoyenne
//
//  Created by Loic on 20/10/2014.
//  Copyright (c) 2014 Loic. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIAlertViewDelegate {
    
    //var listeNotes:Array<Int> = []
    var listeMatieres:Array<NSString> = []
    var viewC = ViewController ()
    
    @IBAction func ButtonAlert(sender: UIBarButtonItem) {
        // afficher les message sur l'alert
        let alert = UIAlertController(title: "Ajouter une nouvelle note", message:"", preferredStyle: UIAlertControllerStyle.Alert)
        //ajout bouton annuler
        alert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
        // bouton ajouter dans l'alert
        let AddAction = UIAlertAction(title: "Ajouter", style: UIAlertActionStyle.Default) { (action) in
            let noteField = alert.textFields![0] as UITextField
            if let note = noteField.text.toInt() {
//                self.listeNotes.append(note)
                self.viewC.ajoutNote(note)
                self.tableView.reloadData()
                self.viewC.saveList("listeNotes")
            }
        }
        alert.addAction(AddAction)
    
        // ajout d'un champs text
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Note"
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
        var section = 0
        for matiere in listeMatieres {
            var occ = 0
            for mat in listeMatieres {
                if (mat.isEqualToString(mat)) {
                    occ++
                    if occ == 2 {
                        section++
                    }
                }
            }
        }
        return 1    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.viewC.listeNotes.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for (index,value) in enumerate(listeMatieres) {
            return listeMatieres[index]
        }
        return "Section"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notes", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = "\(self.viewC.listeNotes[indexPath.row])/20"
        return cell
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
