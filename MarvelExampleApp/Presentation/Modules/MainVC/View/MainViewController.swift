//
//  ViewController.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 11/16/18.
//  Copyright © 2018 AirDev. All rights reserved.
//

import UIKit

class MainViewController: TableController {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        bind(model: MainInfoComicsModel.self, toCell: MainInfoTableViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

