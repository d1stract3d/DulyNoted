//  ViewController.swift
//  dulyNoted
//
//  Created by Alex McCall.
//  Copyright © 2020 Alex McCall. All rights reserved.
//
//  This is the MVC which loads the data and populates the table cells.

import UIKit

class MainViewController: UITableViewController {

    var notes:[Note]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let savedNotes = Note.loadData() {
            notes = savedNotes
        } else {
            notes = Note.loadSampleNote()
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.orange
    }

    //Table View data source functions // total sections in table // defaulted to one
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // total rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    //function displaying the data in the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as!TableViewCell
        
        let note = notes[indexPath.row]
        cell.updateUI(note)
        cell.showsReorderControl = true
        return cell
    }
    //this function displays the edit button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
    }
        Note.saveToFile(notes: notes)
    }
    
    //this function allows for reordering of the notes array
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.notes[sourceIndexPath.row]
        notes.remove(at: sourceIndexPath.row)
        notes.insert(movedObject, at: destinationIndexPath.row)
    }

    //NAVIGATION
    //This segue returns the user to the MVC from the DVC if save is tapped
    @IBAction func unwindToMain(segue:UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else {return}
        let sourceVC = segue.source as! DetailViewController
        if let note = sourceVC.notes{
            //save from editing a row
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                //saving from a new row
            } else {
                let newIndexPath = IndexPath(row: notes.count, section: 0)
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            Note.saveToFile(notes: notes)
        }
    }
    //This segue takes you to the DVC if the user taps a note to edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navCon = segue.destination as! UINavigationController
            let detailVC = navCon.topViewController as! DetailViewController
            detailVC.notes = note
        }
    }
}
