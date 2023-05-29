//
//  ViewController.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        animateLabel()
    }
    
    func animateLabel()
    {
        lblHeading.alpha = 0.0
        self.lblHeading.transform =
        CGAffineTransformMakeTranslation(0, 1000)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear,  animations: { [self] in
            self.lblHeading.alpha = 1.0
            self.lblHeading.transform =
            CGAffineTransformMakeTranslation(0, 0)
        })
    }

    @IBAction func actionAddTask(_ sender: Any) {
        performSegue(withIdentifier: "addTask", sender: self)
    }
    
    @IBAction func actionLoadList(_ sender: Any) {
        performSegue(withIdentifier: "loadList", sender: self)
    }
}

