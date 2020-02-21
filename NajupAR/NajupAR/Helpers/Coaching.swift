//
//  Coaching.swift
//  NajupAR
//
//  Created by Nathalia Melare on 17/02/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import ARKit

class Coaching: ARCoachingOverlayView, ARCoachingOverlayViewDelegate {
    
    private weak var sceneView: TestARSCNView!
    private weak var viewController: ViewController!
    
    func setup(sceneView: TestARSCNView, viewController: ViewController) {
        self.sceneView = sceneView
        self.viewController = viewController
    }
    
    func addCoaching() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        session = sceneView.session
        delegate = self
        
        setActivatesAutomatically()
        setGoal(goal: .horizontalPlane)
        
        sceneView.addSubview(self)
        setupCenter()
    }
    
    private func setupCenter() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
            centerYAnchor.constraint(equalTo: sceneView.centerYAnchor),
            widthAnchor.constraint(equalTo: sceneView.widthAnchor),
            heightAnchor.constraint(equalTo: sceneView.heightAnchor)
        ])
    }
    
    /// - Tag: CoachingActivatesAutomatically
    private func setActivatesAutomatically() {
        activatesAutomatically = true
    }
    
    /// - Tag: CoachingGoal
    private func setGoal(goal: ARCoachingOverlayView.Goal) {
        self.goal = goal
    }
    
    // MARK: - Callbacks
    /// - Tag: Coaching Activate
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        viewController.disableView()
    }
    
    /// - Tag: Coaching Deactivate
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        viewController.enableView()
    }
    
    /// - Tag: Coaching
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
    }
}
