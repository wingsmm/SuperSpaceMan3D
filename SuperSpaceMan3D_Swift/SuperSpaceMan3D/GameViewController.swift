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
import CoreMotion


class GameViewController: UIViewController ,SCNSceneRendererDelegate{
    
    var spotLight : SCNNode!
    var cameraNode: SCNNode!
    var spaceManNode: SCNNode!

    var motionManager: CMMotionManager!
    let spacemanSpeed = 50

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    func setupSpaceMan(scene:SCNScene) -> SCNNode {
        var spaceManScene = SCNScene(named: "art.scnassets/hero.dae")
        var spaceManNode = spaceManScene!.rootNode.childNodeWithName("hero", recursively: false)
        spaceManNode!.name = "hero"
        spaceManNode!.position = SCNVector3Make(0, 0, 200)
        spaceManNode!.rotation = SCNVector4Make(0, 1, 0, Float(M_PI))
        scene.rootNode.addChildNode(spaceManNode!)
        
        return spaceManNode!
    }

    
    func setupCameras(scene:SCNScene) {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.zFar = 500
        cameraNode.position = SCNVector3(x: 0.0, y: 50.0, z: 100)
        cameraNode.rotation = SCNVector4(x: 1.0, y: 0.0, z: 0.0, w: Float(-M_PI_4*0.5))
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func setupObstacles(scene:SCNScene) {
        
        
        var globe = Obstacle.GlobeNode()
        scene.rootNode.addChildNode(globe)
        
        var pyramind = Obstacle.PyramidNode()
        scene.rootNode.addChildNode(pyramind)
        
        var box = Obstacle.BoxNode()
        scene.rootNode.addChildNode(box)
        
        var tube = Obstacle.TubeNode()
        scene.rootNode.addChildNode(tube)
        
        var cylinder = Obstacle.CylinderNode()
        scene.rootNode.addChildNode(cylinder)
        
        var torus = Obstacle.TorusNode()
        scene.rootNode.addChildNode(torus)

    }

    
    
    func createMainScene () ->SCNScene {
        var mainScene = SCNScene()
        setupLighting(mainScene)
        setupCameras(mainScene)
        spaceManNode = setupSpaceMan(mainScene)
        setupObstacles(mainScene)

        return mainScene
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let mainScene = createMainScene()
        
        mainScene.rootNode.addChildNode(setupFloor())
        mainScene.rootNode.addChildNode(createStartingText())
        
        let sceneView = self.view as! SCNView
        sceneView.scene = mainScene
        
        sceneView.showsStatistics = true
//        sceneView.allowsCameraControl = true
        sceneView.pointOfView = cameraNode

        
        sceneView.delegate = self

        setupAccelerometer()

        
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
    
    
    
    
    //MARK - SCNSceneRendererDelegate Function
    func renderer(aRenderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: NSTimeInterval) {
        
        let gameView =  view as! GameView
        let moveDistance = Float(10.0)
        let moveSpeed = NSTimeInterval(1.0)
        
        let currentX =  spaceManNode.position.x
        let currentY =  spaceManNode.position.y
        let currentZ =  spaceManNode.position.z
        
        if gameView.touchCount == 1 {
            //            spaceManNode.physicsBody?.applyForce(SCNVector3Make(currentX, currentY, currentZ - moveDistance), impulse: true);
            let action = SCNAction.moveTo(SCNVector3Make(currentX, currentY, currentZ - moveDistance), duration: moveSpeed);
            spaceManNode.runAction(action)
            
        }
        else if gameView.touchCount == 2 {
            let action = SCNAction.moveTo(SCNVector3Make(currentX, currentY, currentZ + moveDistance), duration: moveSpeed)
            spaceManNode.runAction(action)
        }
        else if gameView.touchCount == 4 {
            let action = SCNAction.moveTo(SCNVector3Make(0, 0, 0), duration: moveSpeed)
            spaceManNode.runAction(action)
        }
        
        
        positionCameraWithSpaceman()
        
    }
    
    
    func positionCameraWithSpaceman()
    {
        //follow the camera
        let spaceman =  spaceManNode.presentationNode()
        var spacemanPosition = spaceman.position
        let cameraDamping:Float = 0.3
        
        var targetPosition =  SCNVector3Make(spacemanPosition.x, 30.0, spacemanPosition.z + 20.0)
        var cameraPosition =  cameraNode.position
        var cameraXPos = cameraPosition.x * (1.0 - cameraDamping) + targetPosition.x *
        cameraDamping
        var cameraYPos = cameraPosition.y * (1.0 - cameraDamping) + targetPosition.y *
        cameraDamping
        var cameraZPos = cameraPosition.z * (1.0 - cameraDamping) + targetPosition.z *
        cameraDamping
        cameraPosition = SCNVector3(x: cameraXPos, y: cameraYPos, z: cameraZPos)
        cameraNode.position = cameraPosition
        spotLight.position = SCNVector3(x: spacemanPosition.x, y: 90, z: spacemanPosition.z +
            40.0)
        spotLight.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(-M_PI/2.8))
    }
    
    
    
    
    func setupAccelerometer() {
        
        motionManager = CMMotionManager()
        
        if  motionManager.accelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 1/60.0
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                (data, error) in
                
                let currentX =  self.spaceManNode.position.x
                let currentY =  self.spaceManNode.position.y
                let currentZ =  self.spaceManNode.position.z
                
                // Moving right?
                if data.acceleration.y < -0.20 {
                    
                    var destinationX = (Float(data.acceleration.y) * Float( self.spacemanSpeed) + Float(currentX))
                    var destinationY = Float(currentY)
                    var destinationZ = Float(currentZ)
                    
                    self.motionManager.accelerometerActive == true
                    let action = SCNAction.moveTo(SCNVector3Make(destinationX, destinationY, destinationZ), duration: 1)
                    self.spaceManNode.runAction(action)
                    
                }
                else if data.acceleration.y > 0.20 {
                    var destinationX = (Float(data.acceleration.y) * Float(self.spacemanSpeed) + Float(currentX))
                    var destinationY = Float(currentY)
                    var destinationZ = Float(currentZ)
                    
                    self.motionManager.accelerometerActive == true
                    let action = SCNAction.moveTo(SCNVector3Make(destinationX, destinationY, destinationZ), duration: 1)
                    self.spaceManNode.runAction(action)
                    
                }
            }
        }
    }

    
}
