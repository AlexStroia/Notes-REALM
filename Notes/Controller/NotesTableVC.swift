//
//  NotesTableVC.swift
//  Notes
//
//  Created by Alex Stroia on 6/5/18.
//  Copyright © 2018 Alex Stroia. All rights reserved.
//

import UIKit
import RealmSwift

class NotesTableVC: UITableViewController {
    
    let realm = try! Realm()
    var currentNote: Note? { didSet {
        loadItems()
        }}
    var itemArray: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarBtn()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArray![indexPath.row].name ?? "No data"
        return cell
    }
    
    //MARK - UPDATED FUNC inside the tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if let item = item Array?[indexPath.row] {
        //            do {
        //                try realm.write {
        //                    item.name = "UPDATED NAME"
        //                }
        //            } catch {
        //                print("\(error)")
        //            }
        //        }
    }
    
    private func initBarBtn() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleSelection))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    @objc func handleSelection() {
        var textField = UITextField()
        let alertController = UIAlertController(title: "ADD", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            do {
                try self.realm.write {
                    let item = Item()
                    item.name = textField.text!
                    item.date = "\(Date())"
                    self.currentNote?.items.append(item)
                    self.tableView.reloadData()
                    print("Added with succes")
                }
            } catch {
                print("Error thrown: \(error)")
            }
        }
        alertController.addTextField { (text) in
                textField = text
            }
            alertController.addAction(action)
            present(alertController, animated: true)
        }
    }
    
    
    extension NotesTableVC {
        fileprivate func loadItems() {
            itemArray = currentNote?.items.sorted(byKeyPath: "name", ascending: true)
        }
        
        fileprivate func deleteItem(indexPath: IndexPath) {
            if let item = itemArray?[indexPath.row]  {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
}
