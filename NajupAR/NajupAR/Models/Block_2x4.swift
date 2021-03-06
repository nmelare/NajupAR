//
//  Block_2x4.swift
//  NajupAR
//
//  Created by Nathalia Melare on 18/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import SceneKit

class Block_2x4: SCNNode {
    
    var block2x2: Block_2x2!
    var maskBlock2x4: UInt32 = 0x1 << 1
    
    override init() {
        super.init()
        loadModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel() {
        let nodeContainer = SCNNode()
        guard let block = SCNScene(named: "art.scnassets/Block_2x4/block_2x4.obj") else {
            NSLog("Scene 2x4 not found")
            return
        }
        for child in block.rootNode.childNodes {
            nodeContainer.addChildNode(child)
        }
        addChildNode(nodeContainer)
    }
    
    func setPosition() {
         self.physicsBody?.categoryBitMask = Int(maskBlock2x4)
     }
}

