//
//  ViewController.swift
//  NajupAR
//
//  Created by Nathalia Melare on 13/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: TestARSCNView!
    
    let popOverTableView = PopOverViewController()
    
    let coaching = Coaching()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        sceneView.delegate = self
        
        setupCoaching()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(gesture)
        
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.frame = CGRect(x: self.view.frame.width/2 - 25, y: self.view.frame.height/2 + 320, width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: Selector(("pressButton")), for: .touchUpInside)

        sceneView.addSubview(button)
    }
    
    func pressButton(_ sender: UIButton) {
        popOverTableView
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor.name == "Anchor for object placement" {
            let block = Block_2x2()
            node.addChildNode(block)
 
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    func setupCoaching() {
        coaching.setup(sceneView: sceneView)
        coaching.addCoaching()
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: sceneView)
        if let query = sceneView.raycastQuery(from: location, allowing: .estimatedPlane, alignment: .horizontal), let firstResult = sceneView.session.raycast(query).first {
            let anchor = ARAnchor(name: "Anchor for object placement", transform: firstResult.worldTransform)
            sceneView.session.add(anchor: anchor)
            print("Add anchor")
        } else {
            print("Warning: Object placement failed.")
        }
    }
    
}
