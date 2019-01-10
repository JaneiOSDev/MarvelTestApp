//
//  MainInfoTableViewCell.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell, CellConfigurable {

    private var model: Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var name: UILabel?
    
    //MARK: Configure
    func configure(with model: Any) {
        
        if let infoModel = model as? MainInfoComicsModel {
            name?.text = infoModel.name
        }
    }
    
}
