//
//  GameViewController.swift
//  SuperSpaceMan3D
//
//  Created by ZhangBo on 15/6/21.
//  Copyright (c) 2015年 ZhangBo. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var spotLight : SCNNode!
    
    
    func setupFloor() ->SCNNode {
        var floorNode = SCNNode()
        var floor = SCNFloor()
        floorNode.geometry = floor
        floorNode.geometry!.firstMaterial!.diffuse.contents = "Floor"
        return floorNode
    }
    
    
    func createStartingText()->SCNNode {
        
        
        let startText = SCNText(string: "Start!", extrusionDepth: 5)
        startText.chamferRadius = 0.5
        startText.flatness = 0.3
        startText.font = UIFont(name: "Copperplate", size: 30)
        startText.firstMaterial?.specular.contents = UIColor.blueColor()
        startText.firstMaterial?.shininess = 0.4

        
        let textNode = SCNNode(geometry: startText)
        textNode.scale = SCNVector3Make(0.75, 0.75, 0.75)
        textNode.position = SCNVector3Make(200, 0, 500)
        
        return textNode
        
    }
    
    
    
    func setupLighting(scene:SCNScene){
        
        
        var ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light!.type = SCNLightTypeAmbient
        ambientLight.light!.color = UIColor(white: 0.3, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLight)
        
        
        var lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeSpot
        lightNode.light!.color = UIColor(white: 0.8, alpha: 1)
        lightNode.position = SCNVector3Make(0, 80, 30)
        lightNode.rotation = SCNVector4Make(1, 0, 0,Float(-M_1_PI/2.8))
        lightNode.light!.spotInnerAngle = 0
        lightNode.light!.spotOuterAngle=50
        lightNode.light!.shadowColor = UIColor.blackColor()
        lightNode.light!.zFar = 500
        lightNode.light!.zNear = 50
        
        scene.rootNode.addChildNode(lightNode)
        
        spotLight = lightNode
    }
    
    
    
    func createMainScene () ->SCNScene {
        var mainScene = SCNScene(named: "art.scnassets/hero.dae")
        setupLighting(mainScene!)
        return mainScene!
    }


    override func viewDidLoad() {
        
        
        
        
        
        super.viewDidLoad()
        
        
        let mainScene = createMainScene()
        

        mainScene.rootNode.addChildNode(setupFloor())
        mainScene.rootNode.addChildNode(createStartingText())
        
        
        
        let sceneView = self.view as! SCNView
        sceneView.scene = mainScene
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        
        
        
        var globe = Obstacle.GlobeNode()
        mainScene.rootNode.addChildNode(globe)

        
        var pyramind = Obstacle.PyramidNode()

        mainScene.rootNode.addChildNode(pyramind)
        
        
        var box = Obstacle.BoxNode()

        mainScene.rootNode.addChildNode(box)
        
        var tube = Obstacle.TubeNode()
        mainScene.rootNode.addChildNode(tube)
        
        var cylinder = Obstacle.CylinderNode()
        mainScene.rootNode.addChildNode(cylinder)
        
        
        var torus = Obstacle.TorusNode()
        mainScene.rootNode.addChildNode(torus)
        
    }
    

    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
