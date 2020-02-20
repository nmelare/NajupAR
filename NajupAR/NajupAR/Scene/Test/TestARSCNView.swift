//
//  TestARSCNView.swift
//  NajupAR
//
//  Created by Nathalia Melare on 17/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import ARKit

class TestARSCNView: ARSCNView, ARSCNViewDelegate {
    var tableViewPopOverDelegate = PopOverTableViewDelegate()
    weak var viewController: ViewController!
    var node: SCNNode!
    var selected: String!
    
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
        self.node = node
        
        if let planeAnchor = anchor as? ARPlaneAnchor{
            self.viewController.addPlane(node: node, anchor: planeAnchor)
        }
        
        if anchor.name == "Anchor for object placement" {
            if(self.selected == "2x2") {
                let block2x2 = Block_2x2()
                //self.scene.rootNode.addChildNode(block2x2)
                node.addChildNode(block2x2)
            } else if(self.selected == "2x4") {
                let block2x4 = Block_2x4()
                viewController.sceneView.scene.rootNode.addChildNode(block2x4)
                //self.scene.rootNode.addChildNode(block2x4)
                node.addChildNode(block2x4)
            }
            
        }
        
        
//
//        if anchor.name == "Anchor for object placement" {
//            let block = Block_2x2()
//            node.addChildNode(block)
//        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        self.node = node
        
        if let planeAnchor = anchor as? ARPlaneAnchor{
            self.viewController.updatePlane(anchor: planeAnchor)
        }
        
    }
    
    func addBlock2x2() {
        print("2x2")
        self.selected = "2x2"
        viewController.disableTableView()
    }
    
    func addBlock2x4() {
        print("2x4")
        self.selected = "2x4"
        viewController.disableTableView()
    }
    
    func config(viewController: ViewController) {
        self.viewController = viewController
    }

}
