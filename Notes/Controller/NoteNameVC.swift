//
//  ViewController.swift
//  Notes
//
//  Created by Alex Stroia on 6/5/18.
//  Copyright © 2018 Alex Stroia. All rights reserved.
//

import UIKit
import RealmSwift

class NoteNameVC: UIViewController {
    
    //MARK - Initialize REALM
    let realm = try! Realm()
    
    
    @IBOutlet weak var textField: UITextField!
    var notesArray: Results<Note>!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromRealm()
    }
    
    @IBAction func Tap(_ sender: UIButton) {
        if (textField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            textField.placeholder = "Textfield is empty"
        } else {
            let note = Note()
            note.name = textField.text!
            note.registredDate =  "\(Date())"
            saveToRealm(note: note)
            textField.resignFirstResponder()
        }
        updateUIAfterEdit()
    }
    
    private func updateUIAfterEdit() {
        textField.text = ""
        view.endEditing(true)
    }
    
    private func update() {
        if let indexPath = tableView.indexPathForSelectedRow {
            notesArray[indexPath.row].setValue("New Name", forKey: "name")
        }
    }
    
    private func saveToRealm(note: Note? = nil) {
        do {
            try realm.write {
                realm.add(note!)
                print("Added with succes!")
            }
        } catch {
            print("\(error)")
        }
        
        tableView.reloadData()
    }
    
    private func deleteFromRealm(note: Note) {
        do {
            try realm.write {
                realm.delete(note)
                print("Deleted with succes!")
            }
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    //MARK - Fetch the data of type Note from the database
    private func loadFromRealm() {
        notesArray = realm.objects(Note.self)
        tableView.reloadData()
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        let buttonPressedPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPressedPosition)
        let objItem = notesArray[indexPath!.row]
        deleteFromRealm(note: objItem)
    }
}

extension NoteNameVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].name ?? "Invalid name"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToData", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NotesTableVC
        if let indexPath = tableView.indexPathForSelectedRow {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

