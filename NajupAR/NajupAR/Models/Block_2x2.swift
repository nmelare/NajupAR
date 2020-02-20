//
//  Block_2x2.swift
//  NajupAR
//
//  Created by Nathalia Melare on 18/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import SceneKit

class Block_2x2: SCNNode {
    var maskBlock2x2: UInt32 = 0x1 << 0
    var block2x4: Block_2x4!
    
    override init() {
        super.init()
        loadModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel() {
        let nodeContainer = SCNNode()
        guard let block = SCNScene(named: "art.scnassets/Block_2x2/block_2x2.obj") else {
            NSLog("Scene 2x2 not found")
            return
        }
        for child in block.rootNode.childNodes {
//            child.name = ""
            nodeContainer.addChildNode(child)
        }
        addChildNode(nodeContainer)
    }
    
    func setPosition() {
        self.physicsBody?.categoryBitMask = Int(maskBlock2x2)
        self.physicsBody?.contactTestBitMask = Int(block2x4.maskBlock2x4)
    }
    
}
