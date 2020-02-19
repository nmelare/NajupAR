//
//  TestARSCNView.swift
//  NajupAR
//
//  Created by Nathalia Melare on 17/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import ARKit

class TestARSCNView: ARSCNView, ARSCNViewDelegate {
    
    func setup() {
        delegate = self
    }
    
    func vai() {
        print("Vai")
    }
    
    func volta() {
        print("Volta")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor.name == "Anchor for object placement" {
            let block = Block_2x2()
            node.addChildNode(block)
        }
    }
}
