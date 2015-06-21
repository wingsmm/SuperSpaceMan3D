//
//  GameViewController.m
//  SuperSpaceMan3D_OC
//
//  Created by ZhangBo on 15/6/21.
//  Copyright (c) 2015年 ZhangBo. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController



-(SCNScene *)createMainScene
{
    SCNScene * mainScene = [SCNScene  sceneNamed:@"art.scnassets/hero.dae"];
    return mainScene;
}


-(SCNNode *)setupFloor
{
    SCNNode * floorNode = [SCNNode node];
    SCNFloor * floor = [SCNFloor floor];
    floorNode.geometry = floor;
    floorNode.geometry.firstMaterial.diffuse.contents = @"Floor";
    return floorNode;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SCNScene * mainScene =  [self createMainScene];
    [mainScene.rootNode addChildNode:[self setupFloor]];
    SCNView * sceneView = (SCNView *)self.view;
    sceneView.scene = mainScene;
    
    sceneView.showsStatistics = true;
    sceneView.allowsCameraControl = true;
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
