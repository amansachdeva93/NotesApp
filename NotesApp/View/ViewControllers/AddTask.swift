//
//  AddTask.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import UIKit

class AddTask: UIViewController {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfAMPM: UITextField!
    
    let coreDataViewModel = CoreDataViewModel()
    var timeString: String?

    func selectTime() //handling time selection bottom sheet
    {
        DatePicker.selectDate(title: "Select Time", cancelText: "Cancel",datePickerMode: .time,selectedDate: Date(), minDate: nil, minuteInterval: 1, didSelectDate: { [self](selectedDate) in
            timeString = String(selectedDate.dateString(DateFormates.hhmma.rawValue))
            let t1 = timeString!.replacingOccurrences(of: "AM", with: " ").replacingOccurrences(of: "PM", with: " ")
            self.tfTime.text = t1
            self.tfAMPM.text = self.timeString!.contains("P") ? "PM" : "AM"
        })
    }
   
    //MARK:- IBActions
    @IBAction func actionSelectTime(_ sender: Any) {
        selectTime()
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        if (tfTime.text?.count ?? 0 > 0) && tfAMPM.text?.count ?? 0 > 0 && tfTitle.text?.count ?? 0 > 0
        {
            coreDataViewModel.addNote(title: (tfTitle.text ?? ""), time: timeString ?? "")
            { isSaved in
                if isSaved
                {
                    showAlert(msg: "Note Saved.")
                    { toDismiss in
                        self.navigationController?.popViewController(animated: true)
                    }
                  
                }
                print("something went wrong while saving.")
            }
        }
        else
        {
            showAlert(msg: "Please fill all the fields."){ toDismiss in
                
            }
        }
    }
  
    @IBAction func actionCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(msg: String, completion: @escaping (_ toDismiss : Bool) -> ()) {
        let alert = UIAlertController(title: msg, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { x in
            completion(true)
           
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
