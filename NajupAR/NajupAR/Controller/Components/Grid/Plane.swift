//
//  Plane.swift
//  NajupAR
//
//  Created by Julia Santos on 20/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class Plane: SCNNode {
    var planeGeometry: SCNPlane
    var planeAnchor: ARPlaneAnchor
    var planeNode: SCNNode
    var maskPlane2x4: UInt32 = 0x1 << 2
    var block2x2: Block_2x2!
    var block2x4: Block_2x4!
    
    
    init(_ anchor: ARPlaneAnchor){
        
        self.planeAnchor = anchor
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let grid = UIImage(named: "plane_grid.png")
        let material = SCNMaterial()
        material.diffuse.contents = grid
        self.planeGeometry.materials = [material]
        self.planeGeometry.firstMaterial?.transparency = 0.5
        self.planeNode = SCNNode(geometry: planeGeometry)
        self.planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        
        super.init()
        self.addChildNode(planeNode)
//        Posicionando o objeto 2mm abaixo da origem do plano
        self.position = SCNVector3(anchor.center.x, -0.002, anchor.center.z)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0), options: nil))
        self.physicsBody?.isAffectedByGravity = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ anchor: ARPlaneAnchor) {
        self.planeAnchor = anchor
        self.planeGeometry.width = CGFloat(anchor.extent.x)
        self.planeGeometry.height = CGFloat(anchor.extent.z)
        self.position = SCNVector3Make(anchor.center.x, -0.002, anchor.center.z)
    }
    
    func setPosition() {
         self.physicsBody?.categoryBitMask = Int(maskPlane2x4)
        self.physicsBody?.collisionBitMask = Int(block2x2.maskBlock2x2) | Int(block2x4.maskBlock2x4)
     }

    
}
