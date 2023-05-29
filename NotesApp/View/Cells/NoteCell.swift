//
//  NoteCell.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var imgCross: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var crossTapped:((_ tappedItem: NoteEntity)->())?
    var tickTapped:((_ tappedItem: NoteEntity)->())?
    var entity: NoteEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func actionCheck(_ sender: Any) {
        entity?.status = !(entity?.status ?? false)
        tickTapped!(entity ?? NoteEntity())
    }
    
    func configure() {
        
        lblStatus.isHidden = false
        imgCross.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDelete)))
        
        //setting time format and Pending status for past entries.
        lblTime.text =  entity?.time
        let time = entity?.time?.timeTo24Format()
        let currentHour  = Calendar.current.component(.hour, from: Date())
        let currentMinute  = Calendar.current.component(.minute, from: Date())
        
        let splitColon = time?.split(separator: ":")
        let savedHour = Int(splitColon?[0] ?? "1")
        let savedMinute = Int(splitColon?[1] ?? "1")
        
        if savedHour ?? 0 < currentHour
        {
            lblStatus.text = "Pending"
            lblTitle.textColor = .red
        }
        else if (savedHour ?? 0) == currentHour
        {
            if (savedMinute ?? 0) < currentMinute
            {
                lblStatus.text = "Pending"
                lblTitle.textColor = .red
            }
            else
            {
                lblStatus.isHidden = true
                lblTitle.textColor = UIColor.label
            }
        }
        else
        {
            lblStatus.isHidden = true
            lblTitle.textColor = UIColor.label
        }
        
            //status checking for adding checkbox tick
        if (entity?.status ?? false)
        {
            btnCheckbox.setImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            let attributedText = NSAttributedString(
                string: (entity?.title ?? "").capitalized,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            lblTitle.attributedText = attributedText
        }
        else
        {
            btnCheckbox.setImage(UIImage(named: "uncheckdark"), for: UIControl.State.normal)
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "YourStringHere")
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            lblTitle.attributedText = attributeString
            
            lblTitle.text = entity?.title?.capitalized
        }
    }
    
    @objc func actionDelete()
    {
        crossTapped!(entity ?? NoteEntity())
    }
}
