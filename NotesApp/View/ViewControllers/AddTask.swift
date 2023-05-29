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
    
    override func viewDidLoad() {
        super.viewDidLoad()
   }
    
    @IBAction func actionSelectTime(_ sender: Any) {
        selectTime()
    }
   
    func selectTime()
    {
       
        let currentDateTime: Date? = Date()
        DatePicker.selectDate(title: "Select Time", cancelText: "Cancel",datePickerMode: .time,selectedDate: currentDateTime!, minDate: nil, minuteInterval: 1, didSelectDate: { [weak self](selectedDate) in
            let timeString = String(selectedDate.dateString(DateFormates.hhmma.rawValue))
            let t1 = timeString.replacingOccurrences(of: "AM", with: " ").replacingOccurrences(of: "PM", with: " ")
            self?.tfTime.text = t1
            self?.tfAMPM.text = timeString.contains("P") ? "PM" : "AM"
            print(selectedDate)
           /// self?.arrivalTime = selectedDate
            //self?.startTimeField.text = selectedDate.dateString(DateFormates.hhmma.rawValue)
        })
    }
   
    @IBAction func actionAdd(_ sender: Any) {
        if (tfTime.text?.count ?? 0 > 0) && tfAMPM.text?.count ?? 0 > 0 && tfTitle.text?.count ?? 0 > 0
        {
            coreDataViewModel.addNote(title: (tfTitle.text ?? ""), time: 0.0)
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
