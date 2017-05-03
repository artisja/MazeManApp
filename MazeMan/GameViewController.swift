//
//  GameViewController.swift
//  MazeMan
//
//  Created by Artis, Justin (CONT) on 4/4/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.showsPhysics = true
        skView.presentScene(scene)
            }
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
