//
//  TableController.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

class TableController: BaseViewController {
    
    @IBOutlet private(set) weak var tableView: UITableView!
    
    var viewModel: CollectionViewModel? {
        didSet {
            if tableView != nil {
                tableView.reloadData()
            }
        }
    }
    
    private var bindedPairs: [String : UITableViewCell.Type] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    func bind(model: Any.Type, toCell: UITableViewCell.Type) {
        bindedPairs[String(describing: model)] = toCell.self
    }
    
    func registerCells() {
        for value in bindedPairs.values {
            if let nib = value.self.nib {
                tableView.register(nib, forCellReuseIdentifier: value.self.identifier)
            } else {
                tableView.register(value.self, forCellReuseIdentifier: value.self.identifier)
            }
        }
    }
    
    func dequeueReusableCell(for item: Any, with indexPath: IndexPath) -> UITableViewCell {
        if let cellType = bindedPairs[String(describing: type(of: item))] {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellType.self.identifier, for: indexPath)
            (cell as? CellConfigurable)?.configure(with: item)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension TableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel?.sections[section] else {
            return 0
        }
        return section.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.sections[indexPath.section].items[indexPath.row] else {
            assertionFailure("item not available for given indexPath: section \(indexPath.section), row \(indexPath.row)")
            return UITableViewCell()
        }
        
        let cell = dequeueReusableCell(for: item, with: indexPath)
        return cell
    }
}

extension TableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel?.sections[indexPath.section].items[indexPath.row] as? Selectable {
            item.selectionClosure()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
