//
//  Obstacle.swift
//  SuperSpaceMan3D
//
//  Created by ZhangBo on 15/6/21.
//  Copyright (c) 2015年 ZhangBo. All rights reserved.
//

import Foundation
import SceneKit

class Obstacle {
    
    
    /**
    金字塔
    */
    
    class  func PyramidNode() -> SCNNode {
        
        let pyramid = SCNPyramid(width: 10.0, height: 20.0, length: 10.0)
        let pyramidNode = SCNNode(geometry: pyramid)
        
        let position = SCNVector3Make(0, 0, -100)
        pyramidNode.position = position
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
        
        
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blueColor()
        pyramidNode.geometry?.firstMaterial?.specular.contents = UIColor.blueColor()
        pyramidNode.geometry?.firstMaterial?.shininess = 1.0
        
        
        
        pyramidNode.physicsBody = SCNPhysicsBody()
        pyramidNode.physicsBody?.type = .Dynamic
        pyramidNode.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        pyramidNode.physicsBody?.collisionBitMask = ColliderType.all
        
        
        pyramidNode.name = "pyramid"
        
        // Spin around the Y-Axis
        
        let rotation = CABasicAnimation(keyPath: "rotation")
        rotation.fromValue = NSValue(SCNVector4:SCNVector4Make(0, 0, 0, 0))
        rotation.toValue = NSValue(SCNVector4:SCNVector4Make(0, 1, 0, Float(2.0 * M_PI)))
        rotation.duration = 5
        rotation.repeatCount = .infinity
        pyramidNode.addAnimation(rotation, forKey: "rotation")
        
        return pyramidNode
    }
    
    
    /**
    球体
    */
    class func GlobeNode() -> SCNNode {
        
        let globe = SCNSphere(radius: 15.0)
        let globeNode = SCNNode(geometry: globe)
        globeNode.position = SCNVector3Make(20, 40, -50)
        globeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
        
        
        globeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earthDiffuse.jpg")
        globeNode.geometry?.firstMaterial?.ambient.contents = UIImage(named: "earthAmbient.jpg")
        globeNode.geometry?.firstMaterial?.specular.contents = UIImage(named: "earthSpecular.jpg")
        globeNode.geometry?.firstMaterial?.normal.contents = UIImage(named: "earthNormal.jpg")
        globeNode.geometry?.firstMaterial?.diffuse.mipFilter = SCNFilterMode.Linear
        
        
        globeNode.physicsBody = SCNPhysicsBody()
        globeNode.physicsBody?.type = .Dynamic
        globeNode.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        globeNode.physicsBody?.collisionBitMask = ColliderType.all
        
        globeNode.name = "globe"
        
        let rotation = CABasicAnimation(keyPath: "rotation")
        
        // Spin around the Y-Axis
        rotation.fromValue = NSValue(SCNVector4:SCNVector4Make(0, 0, 0, 0))
        rotation.toValue =  NSValue(SCNVector4:SCNVector4Make(0, 1, 0, Float(2.0*M_PI)))
        rotation.duration = 10
        rotation.repeatCount = .infinity
        globeNode.addAnimation(rotation, forKey: "rotation")
        
        let moveGlobeUp = SCNAction.moveByX(0.0, y: 10.0, z: 0.0, duration: 1.0)
        let moveGlobeDown = SCNAction.moveByX(0.0, y: -10.0, z: 0.0, duration: 1.0)
        let sequence = SCNAction.sequence([moveGlobeUp, moveGlobeDown])
        let repeateSequence = SCNAction.repeatActionForever(sequence)
        globeNode.runAction(repeateSequence)
        
        
        
        return globeNode
    }
    
    
    /**
    箱子
    */
    
    class  func BoxNode() -> SCNNode {
        
        let box = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brownColor()
        boxNode.position = SCNVector3Make(0, 10, -20)
        
        var materials = [SCNMaterial]()
        let boxImage = "boxSide"
        for i in 1...6 {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: boxImage + String(i))
            materials.append(material)
        }
        
        boxNode.geometry?.materials = materials
        
        boxNode.physicsBody = SCNPhysicsBody()
        boxNode.physicsBody?.type = .Dynamic
        boxNode.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        boxNode.physicsBody?.collisionBitMask = ColliderType.all
        
        
        
        
        
        
        boxNode.name = "box"
        
        // Spin around the z-Axis
        let rotation = CABasicAnimation(keyPath: "rotation")
        
        rotation.fromValue = NSValue(SCNVector4:SCNVector4Make(0, 0, 0, 0))
        rotation.toValue =  NSValue(SCNVector4:SCNVector4Make(0, 0, 1, Float(2.0*M_PI)))
        rotation.duration = 10
        rotation.repeatCount = .infinity
        boxNode.addAnimation(rotation, forKey: "rotation")
        
        
        
        return boxNode
        
    }
    
    /**
    金属管
    */
    
    
    class  func TubeNode() -> SCNNode {
        
        
        let tube = SCNTube(innerRadius: 10, outerRadius: 14, height: 20)
        let tubeNode = SCNNode(geometry: tube)
        tubeNode.position = SCNVector3Make(-10, 0, -75)
        tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
        
        
        
        tubeNode.physicsBody = SCNPhysicsBody(type: .Dynamic, shape: nil)
        //        tubeNode.physicsBody?.type = .Dynamic
        tubeNode.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        tubeNode.physicsBody?.collisionBitMask = ColliderType.all
        
        
        tubeNode.name = "tube"
        
        let rotation = CABasicAnimation(keyPath: "rotation")
        // Spin around the Z-Axis
        rotation.fromValue = NSValue(SCNVector4:SCNVector4Make(0, 0, 0, 0))
        rotation.toValue =  NSValue(SCNVector4:SCNVector4Make(0, 0, 1, Float(2.0*M_PI)))
        rotation.duration = 5
        rotation.repeatCount = .infinity
        tubeNode.addAnimation(rotation, forKey: "rotation")
        
        
        
        return tubeNode
        
    }
    /*
    圆柱体
    */
    
    class  func CylinderNode() -> SCNNode {
        
        let cylinderNode = SCNNode(geometry:SCNCylinder(radius: 3, height: 12))
        cylinderNode.position = SCNVector3Make(14, 0, -25)
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellowColor()
        cylinderNode.geometry?.firstMaterial?.specular.contents = UIColor.yellowColor()
        cylinderNode.geometry?.firstMaterial?.shininess = 0.5
        
        
        
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellowColor()
        cylinderNode.geometry?.firstMaterial?.specular.contents = UIColor.yellowColor()
        cylinderNode.geometry?.firstMaterial?.shininess = 0.5
        
        
        cylinderNode.name = "cylinder"
        
        let scaleToZero = SCNAction.scaleTo(0.0, duration: 0)
        let scaleUp = SCNAction.scaleTo(1.0, duration: 5)
        let opacityToZero = SCNAction.fadeOutWithDuration(5)
        
        let sequence = SCNAction.sequence([scaleToZero, scaleUp])
        let repeateSequence = SCNAction.repeatAction(sequence, count: 10)
        cylinderNode.runAction(repeateSequence)
        
        
        
        return cylinderNode
        
    }
    
    /**
    金属圈
    */
    
    class  func TorusNode() -> SCNNode {
        
        let torus = SCNTorus(ringRadius: 12, pipeRadius: 5)
        let torusNode = SCNNode(geometry: torus)
        torusNode.position = SCNVector3Make(50, 10, -50)
        torusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.redColor()
        torusNode.geometry?.firstMaterial?.specular.contents = UIColor.blackColor()
        torusNode.geometry?.firstMaterial?.shininess = 0.75
        
        
        torusNode.physicsBody = SCNPhysicsBody()
        torusNode.physicsBody?.type = .Dynamic
        torusNode.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        torusNode.physicsBody?.collisionBitMask = ColliderType.all
        
        
        return torusNode
        
    }
    
    
    
    
}
