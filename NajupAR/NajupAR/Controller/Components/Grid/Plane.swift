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
    
    init(_ anchor: ARPlaneAnchor){
        
        self.planeAnchor = anchor
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        self.planeGeometry.firstMaterial?.transparency = 0.5
        self.planeNode = SCNNode(geometry: planeGeometry)
        self.planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        
        super.init()
        self.addChildNode(planeNode)
//        Posicionando o objeto 2mm abaixo da origem do plano
        self.position = SCNVector3(anchor.center.x, -0.002, anchor.center.z)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
