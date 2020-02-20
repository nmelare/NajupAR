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

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: TestARSCNView!
    @IBOutlet var tableViewPopOver: UITableView!
    var tableViewPopOverDataSource = PopOverTableViewDataSource()
    var tableViewPopOverDelegate = PopOverTableViewDelegate()
    let button = UIButton()
    var planes = [ARPlaneAnchor: Plane]()
    var plane:  Plane!
    
    let coaching = Coaching()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func setup() {
        addButton()
        setGesture()
        setupCoaching()
        setupScene()
        setupTable()
    }
    
    func setupScene() {
        sceneView.setup()
        sceneView.config(viewController: self)
    }
    
    func setupTable() {
        tableViewPopOver.isHidden = true
        tableViewPopOver.dataSource = tableViewPopOverDataSource
        tableViewPopOver.delegate = tableViewPopOverDelegate
        tableViewPopOverDelegate.config(viewController: self)
    }
    
    func setupCoaching() {
        coaching.setup(sceneView: sceneView, viewController: self)
        coaching.addCoaching()
    }
    
    func addButton() {
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.frame = CGRect(x: self.view.frame.width/2 - 25, y: self.view.frame.height/2 + 320, width: 50, height: 50)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        sceneView.addSubview(button)
    }
    
    func disableView() {
        print("disableView")
        button.isHidden = true
        tableViewPopOver.isHidden = true
    }
    
    func disableTableView() {
        tableViewPopOver.isHidden = true
    }
    
    func enableView() {
        print("enableView")
        button.isHidden = false
    }
    
    func setGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(gesture)
    }
    
    func addPlane(node: SCNNode, anchor: ARPlaneAnchor) {
        let plane = Plane(anchor)
        planes[anchor] = plane
        node.addChildNode(plane)
        
    }
    
    func updatePlane(anchor: ARPlaneAnchor) {
        if let plane = planes[anchor] {
            plane.update(anchor)
        }
    }
    
    
    // MARK: - Delegate functions
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
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
    
    @objc func pressButton(_ sender: Any) {
        tableViewPopOver.isHidden = false
    }
    
     
    
}
