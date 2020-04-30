//  TableViewCell.swift
//  dulyNoted
//
//  Created by Alex McCall.
//  Copyright © 2020 Alex McCall. All rights reserved.
//
//  This class creates the table-view cells and populates them

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    
    func updateUI(_ note:Note){
      let dF = DateFormatter()
        dF.dateStyle = .short
        dF.timeStyle = .short
         
        let date = note.date
     
        noteTitle.text = note.text
        noteDate.text = dF.string(from: date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
