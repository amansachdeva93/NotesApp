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
    var entity: NoteEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        
        lblTitle.text = entity?.title?.capitalized
        lblTime.text = "\(entity?.time ?? 0.0)"
        lblStatus.text = "Pending"
        imgCross.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDelete)))
        
    }
    
    @objc func actionDelete()
    {
        crossTapped!(entity ?? NoteEntity())
    }
}
