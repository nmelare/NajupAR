//
//  PopOverTableViewDelegate.swift
//  NajupAR
//
//  Created by Paula Leite on 20/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

class PopOverTableViewDelegate: NSObject, UITableViewDelegate {
    var blocks = ["2x2", "2x4"]
    var imageBlocks = [UIImage(named: "block_icon_2x2"), UIImage(named: "block_icon_2x4")]
    var blockName: String!
    weak var viewController: ViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(blocks[indexPath.row])
        
        if(indexPath.row == 0) {
            viewController?.sceneView.addBlock2x2()
        } else {
            viewController?.sceneView.addBlock2x4()
        }
        
    }
    
    func config(viewController: ViewController) {
        self.viewController = viewController
    }
}
