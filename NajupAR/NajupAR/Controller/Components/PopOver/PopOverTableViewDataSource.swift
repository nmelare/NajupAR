//
//  PopOverViewController.swift
//  NajupAR
//
//  Created by Nathalia Melare on 18/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.


import UIKit

class PopOverTableViewDataSource: NSObject, UITableViewDataSource {

    var blocks = ["block_2x2", "block_2x4"]
    var imageBlocks = [UIImage(named: "block_icon_2x2"), UIImage(named: "block_icon_2x4")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverTableViewCell") as? PopOverTableViewCell {
            cell.imageIcon.image = imageBlocks[indexPath.row]
            cell.labelIcon.text = blocks[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}
