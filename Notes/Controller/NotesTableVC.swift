//
//  NotesTableVC.swift
//  Notes
//
//  Created by Alex Stroia on 6/5/18.
//  Copyright © 2018 Alex Stroia. All rights reserved.
//

import UIKit
import CoreData

class NotesTableVC: UITableViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarBtn()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
  //      cell.textLabel?.text = itemArray[indexPath.row].name
        return cell
    }
    
    private func initBarBtn() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleSelection))
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    @objc func handleSelection() {
        var textField = UITextField()
        let alertController = UIAlertController(title: "ADD", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        alertController.addTextField { (text) in
            textField = text
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

//TODO: LOAD,SAVE ITEMS, DEPENDING ON THE DESCRIPTION

extension NotesTableVC {
    fileprivate func saveToCoreData() {

    }
    
    fileprivate func loadFromCoreData() {
        
    }
}
