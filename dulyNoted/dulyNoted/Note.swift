//  Note.swift
//  dulyNoted
//
//  Created by Alex McCall.
//  Copyright © 2020 Alex McCall. All rights reserved.
//
//  This struct creates the Note(s)

import Foundation
struct Note:Codable {
    
    var text:String
    var date:Date

    //locally saving data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes").appendingPathExtension("nlist")
    
    static func loadData() -> [Note]? {
        guard let codedNotes = try? Data(contentsOf: ArchiveURL) else {return nil}
            let decoder = PropertyListDecoder()
            return try? decoder.decode(Array<Note>.self, from: codedNotes)
        }
    static func saveToFile(notes : [Note]){
        let encoder = PropertyListEncoder()
        let codedNotes = try? encoder.encode(notes)
        try? codedNotes?.write(to: ArchiveURL, options: .noFileProtection)
    }
    static func loadSampleNote()->[Note]{
        let notes = [Note(text: "Hello, hello...", date: Date()),
        Note(text: "Another one...", date: Date())]
        return notes
    }
    
}
