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
    
    
    func createMainScene () ->SCNScene {
        var mainScene = SCNScene(named: "art.scnassets/hero.dae")
        return mainScene!
    }
    
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
        textNode.position = SCNVector3Make(200, 0, 1000)
        
        return textNode
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainScene = createMainScene()
        mainScene.rootNode.addChildNode(setupFloor())
        mainScene.rootNode.addChildNode(createStartingText())
        mainScene.rootNode.addChildNode(Obstacle.PyramidNode())


        let sceneView = self.view as! SCNView
        sceneView.scene = mainScene
        
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
        


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
