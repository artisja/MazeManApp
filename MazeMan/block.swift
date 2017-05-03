//
//  block.swift
//  MazeMan
//
//  Created by Artis, Justin (CONT) on 4/8/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import Foundation
import SpriteKit

class Block {
    var blockInstance: SKSpriteNode
    var xPos: Int
    var yPos: Int
    
    init() {
       blockInstance = SKSpriteNode(imageNamed: "block.png")
        self.xPos = 0
        self.yPos = 0
    }
    
    init(xPosition: Int,yPosition: Int) {
        self.xPos = xPosition
        self.yPos = yPosition
        blockInstance = SKSpriteNode(imageNamed: "block.png")
        blockInstance.position = CGPoint(x: self.xPos, y: self.yPos)
//        blockInstance.physicsBody  = SKPhysicsBody(rectangleOf: CGSize(width: blockInstance.frame.width, height: blockInstance.frame.height))
//        blockInstance.physicsBody?.affectedByGravity = false
    }
    
    init(position: Int) {
        self.xPos = 0
        self.yPos = 0
        blockInstance = SKSpriteNode(imageNamed: "block.png")
        blockInstance.position = CGPoint(x: position, y: 0)
        blockInstance.physicsBody  = SKPhysicsBody(rectangleOf: CGSize(width: blockInstance.frame.width, height: blockInstance.frame.height))
        blockInstance.physicsBody?.affectedByGravity = false
    }
}
