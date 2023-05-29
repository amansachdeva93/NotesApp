//
//  TaskList.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import UIKit

class TaskList: UIViewController {

    let coreDataViewModel = CoreDataViewModel()
    
    @IBOutlet weak var viewBlack: UIView!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var tableNotes: UITableView!
    var list: [NoteEntity] = [] {
        didSet {
            self.tableNotes.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataViewModel.fetchList()
        list.append(contentsOf: coreDataViewModel.noteList)
        tableNotes.rowHeight = UITableView.automaticDimension
        tableNotes.estimatedRowHeight = 150
        print(String(coreDataViewModel.noteList.count))
 }
}

extension TaskList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NoteCell
        cell.entity = list[indexPath.row]
        cell.configure()
        cell.crossTapped = {[self] noteItem in
            coreDataViewModel.deleteNote(entity: noteItem){_ in
                print("deleted.")
                showWarningAlert()
               
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
        list.removeAll()
        list.append(contentsOf: coreDataViewModel.noteList)
        coreDataViewModel.fetchList()
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
        viewBlack.isHidden = false
        viewPopUp.isHidden = false
    }
}


