//
//  TaskList.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import UIKit

class TaskList: UIViewController {
    
    let coreDataViewModel = CoreDataViewModel()
    
    @IBOutlet weak var lblNoEntries: UILabel!
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var viewBlack: UIView!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var tableNotes: UITableView!
    @IBOutlet weak var lblFab: UIImageView!
    
    var list: [NoteEntity] = [] {
        didSet {
            self.tableNotes.reloadData()
        }
    }
    var entryToDelete : NoteEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadList()
    }
    
    func addGestures()
    {
        lblFab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionAddNote)))
    }
    
    @objc func actionAddNote()
    {
        performSegue(withIdentifier: "addTask", sender: self)
    }
    
    func loadList()
    {
        list.removeAll()
        coreDataViewModel.noteList.removeAll()
        coreDataViewModel.fetchList()
        list.append(contentsOf: coreDataViewModel.noteList)
        tableNotes.reloadData()
        
        if coreDataViewModel.noteList.isEmpty
        {
            lblNoEntries.isHidden = false
        }
    }
}

//Handling TableView Delegates.
extension TaskList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NoteCell
        cell.entity = list[indexPath.row]
        cell.configure()
        cell.crossTapped = {[self] noteItem in
            entryToDelete = noteItem
            showWarningAlert()
        }
        cell.tickTapped = {[self] noteItem in
            coreDataViewModel.updateNote(entity: noteItem){_ in
                print("updated")
                loadList()
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension TaskList
{
    @IBAction func actionOk(_ sender: Any) {
        
        coreDataViewModel.deleteNote(entity: entryToDelete ?? NoteEntity()){title in
            print("deleted.")
        }
        loadList()
        hideWarningAlert()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        hideWarningAlert()
    }
    
    func hideWarningAlert()
    {
        viewBlack.isHidden = true
        viewPopUp.isHidden = true
    }
    
    func showWarningAlert()
    {
        lblWarning.text = "Do you want to delete \"\(entryToDelete?.title ?? "")\", this action can’t be undone.  "
        viewBlack.isHidden = false
        viewPopUp.isHidden = false
        
    }
}


