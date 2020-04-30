//  DetailViewController.swift
//  dulyNoted
//
//  Created by Alex McCall.
//  Copyright © 2020 Alex McCall. All rights reserved.
//
//  This is the DetailViewController which allows editing and saving data in the detail view.

import UIKit

class DetailViewController: UITableViewController, UITextViewDelegate {
    
    var notes:Note?
    
    @IBOutlet weak var textFieldText: UITextView!
    @IBOutlet weak var dateFieldDate: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if let note = notes{
            textFieldText.text = note.text
            dateFieldDate.date = note.date
        }
        addDoneButtonOnKeyboard()
    }
    
    //a function to add the "Done" button to the keyboard
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = UIColor .orange
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textFieldText.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        textFieldText.resignFirstResponder()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveSegue" else {return}
        let name = textFieldText.text ?? ""
        let date = dateFieldDate.date
        notes = Note(text: name, date: date)
    }
    
    
}
