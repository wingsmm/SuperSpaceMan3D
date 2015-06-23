//
//  GameView.swift
//  SuperSpaceMan3D
//
//  Created by ZhangBo on 15/6/23.
//  Copyright (c) 2015年 ZhangBo. All rights reserved.
//

import Foundation
import SceneKit

class GameView : SCNView {
    
    var touchCount:Int?
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touchCount = event.allTouches()
        self.touchCount = touchCount?.count
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchCount = 0
    }
    
}