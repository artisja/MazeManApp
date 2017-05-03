//
//  GameScene.swift
//  MazeMan
//
//  Created by Artis, Justin (CONT) on 4/4/17.
//  Copyright © 2017 Artis, Justin (CONT). All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var caveMan = SKSpriteNode(imageNamed: "caveman.png")
    let block = SKSpriteNode(imageNamed: "block.png")
    var dinoOne = SKSpriteNode(imageNamed: "dino1.png")
    var dinoTwo = SKSpriteNode(imageNamed: "dino2.png")
    var dinoThree = SKSpriteNode(imageNamed: "dino3.png")
    var dinoFour = SKSpriteNode(imageNamed: "dino4.png")
    var ground = SKNode()
    var waterOne = SKSpriteNode(imageNamed: "water.png")
    var waterTwo = SKSpriteNode(imageNamed: "water.png")
    var messageBar = SKLabelNode(text: "Welcome to MazeMan!")
    var statusPanel = SKSpriteNode(imageNamed: "game-status-panel.png")
    var fireBall = SKSpriteNode(imageNamed:"fire.png")
    var rock = SKSpriteNode(imageNamed: "rock.png")
    var leftBoarder = SKNode()
    var rightBoarder = SKNode()
    var upperBoarder = SKNode()
    var dinoThreeSet : [SKAction] = []
    var prevAction = 0
    var ifWater = false
    var starCount:Int = 0
    var rockCount:Int = 10
    var heartCount:Int = 3
    var energyCount:Int = 100
    var foodObject = SKSpriteNode(imageNamed: "food.png")
    var starObject = SKSpriteNode(imageNamed: "star.png")
    var star = SKSpriteNode(imageNamed: "star.png")
    var heart = SKSpriteNode(imageNamed: "heart.png")
    var rockSign = SKSpriteNode(imageNamed: "rock.png")
    var energyBar = SKSpriteNode(imageNamed: "battery.png")
    var randomFoodSpots = [CGPoint(x: 100, y: 765),CGPoint(x: 300, y: 500),CGPoint(x: 340, y: 562),CGPoint(x: 755, y: 145),CGPoint(x: 850, y: 180)]
    var randomStarSpots = [CGPoint(x: 100, y: 650),CGPoint(x: 900, y: 200),CGPoint(x: 340, y: 778),CGPoint(x: 155, y: 445),CGPoint(x: 150, y: 380),CGPoint(x: 900, y: 290),CGPoint(x: 900, y: 500)]
    var dinoTwoSpots = [CGPoint(x: 100, y: 200),CGPoint(x: 600, y: 600),CGPoint(x: 700, y: 562),CGPoint(x: 800, y: 145)]
    var spots = [(100,350),(145,700),(168,850),(100,455),(250,356),(234,600),(900,850),(790,356),(740,679),(220,870),(800,433),(455,886),(423,708),(425,456),(955,686),(653,256),(800,733),(653,856),(632,798),(655,686),(601,186),(632,550),(835,686),(855,386),(805,786),(895,286),(700,800),(350,850)]
    var blockCount = 0
    var isMaxBlocks = true
    
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        //add Boarders
        leftBoarder.position = CGPoint(x: 0, y: 500)
        leftBoarder.physicsBody?.categoryBitMask = PhysicsCategory.boarderLeft.rawValue
        leftBoarder.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurThree.rawValue
        leftBoarder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        leftBoarder.physicsBody?.isDynamic = false
        addChild(leftBoarder)
        
        
        rightBoarder.position = CGPoint(x: self.frame.width, y: 500)
        rightBoarder.physicsBody?.categoryBitMask = PhysicsCategory.boarderRight.rawValue
        rightBoarder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        rightBoarder.physicsBody?.isDynamic = false
        addChild(rightBoarder)
        
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 2*self.frame.width, height: 1))
        ground.physicsBody?.isDynamic = false
        addChild(ground)

        upperBoarder.position = CGPoint(x: 0, y: self.frame.height)
        upperBoarder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        upperBoarder.physicsBody?.isDynamic = false
        addChild(upperBoarder)
        
        var count = 0
        var variables = [Block]()
        var topPosition = 35
        
        count = 0
        while count < 21
        {
            var newBlock = Block()
            newBlock.blockInstance.position = CGPoint(x: topPosition, y: 1000)
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            topPosition = topPosition + 65
            count = count + 1
        }
        
        for item in variables {
            addChild(item.blockInstance)
        }
        variables.removeAll()
        
        topPosition = 35
        count = 0
        while count < 21
        {
            var newBlock = Block()
            newBlock.blockInstance.position = CGPoint(x: topPosition, y: 950)
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            topPosition = topPosition + 65
            count = count + 1
        }
        
        for item in variables {
            addChild(item.blockInstance)
        }
        variables.removeAll()
         count = 0
        
        //Swipe Gestures
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeftGesture.direction = .left
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeDownGesture.direction = .down
        self.view?.gestureRecognizers = [swipeUpGesture,swipeDownGesture,swipeLeftGesture,swipeRightGesture]

        //SK Nodes
        var startPosition = 50
        
        while  count < 4
        {
            var newBlock = Block(position: startPosition)
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            startPosition = startPosition + 10
            count = count + 1
        }
        
        for item in variables
        {
            addChild(item.blockInstance)
        }
        
        variables.removeAll()
        
        
      
        
        //randomize dinosaur position
      
        
        count = 0
        var  blockSize = CGSize()
        while count < 3
        {
            var newBlock = Block(position: startPosition + 200)
            blockSize = newBlock.blockInstance.size
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            startPosition = startPosition + 10
            count = count + 1
        }
        
        for item in variables {
            addChild(item.blockInstance)
        }
        
        variables.removeAll()
        
        
        if Int(arc4random_uniform(10)) > 5{
            ifWater = true
        }
        
        
        //add water one blocks
        waterOne.size = blockSize
        waterOne.yScale = 1.0
        waterOne.xScale = 0.6
        waterOne.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: waterOne.frame.width, height: waterOne.frame.height))
        waterOne.position = CGPoint(x: startPosition + 350, y: 0)
        waterOne.physicsBody?.affectedByGravity = false
        waterOne.physicsBody?.isDynamic = false
        addChild(waterOne)
        

        startPosition = startPosition + 450
        count = 0
        while  count < 9
        {
            var newBlock = Block(position: startPosition)
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            startPosition = startPosition + 35
            count = count + 1
        }
        
        for item in variables
        {
           addChild(item.blockInstance)
        }
        
        variables.removeAll()
        
        //add water one blocks
        waterTwo.size = blockSize
        waterTwo.yScale = 1.0
        waterTwo.xScale = 0.6
        waterTwo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: waterOne.frame.width, height: waterOne.frame.height))
        waterTwo.position = CGPoint(x: startPosition + 215, y: 0)
        waterTwo.physicsBody?.affectedByGravity = false
        waterTwo.physicsBody?.isDynamic = false
        addChild(waterTwo)
        
        startPosition = startPosition + 215 + 50
        count = 0
        while  count < 4
        {
            var newBlock = Block(position: startPosition)
            newBlock.blockInstance.setScale(0.5)
            variables.append(newBlock)
            startPosition = startPosition + 35
            count = count + 1
        }
        
        for item in variables
        {
            addChild(item.blockInstance)
        }
        
        variables.removeAll()
        
        
        Timer.scheduledTimer(withTimeInterval:1.0 , repeats: isMaxBlocks) { (Timer) in
            if self.blockCount == 15{
                self.isMaxBlocks = false
            }
            if self.isMaxBlocks{
            self.blockChain()
            self.blockCount = self.blockCount + 1
            }
        }
        
        //dinosaurs
        if ifWater{
            dinoOne.position = CGPoint(x:  waterOne.position.x , y: 200)
        }else{
            dinoOne.position = CGPoint(x: waterTwo.position.x , y: 200)
        }
        dinoOne.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dinoOne.frame.width, height:dinoOne.frame.height))
        dinoOne.physicsBody?.affectedByGravity = false
        dinoOne.physicsBody?.isDynamic = false
        addChild(dinoOne)
        
        
        dinoTwo.position = dinoTwoSpots[Int(arc4random_uniform(UInt32(dinoTwoSpots.count)))]
        dinoTwo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dinoTwo.frame.width, height:dinoTwo.frame.height))
        dinoTwo.physicsBody?.affectedByGravity = false
        dinoTwo.physicsBody?.isDynamic = false
        addChild(dinoTwo)
        
        dinoThree.position = CGPoint(x: 100, y: 900)
        dinoThree.setScale(0.2)
        dinoThree.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dinoThree.frame.width, height: dinoThree.frame.height))
        dinoThree.physicsBody?.affectedByGravity = false
        addChild(dinoThree)
        
        
        dinoFour.position = CGPoint(x: 100, y: 900)
        dinoFour.setScale(0.05)
        dinoFour.physicsBody?.affectedByGravity = false
        addChild(dinoFour)
        
        caveMan.position = CGPoint(x: 50, y: 200)
        caveMan.setScale(0.10)
        caveMan.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: caveMan.frame.width, height: caveMan.frame.height))
        caveMan.physicsBody?.affectedByGravity = true
        caveMan.physicsBody?.isDynamic = true
        addChild(caveMan)
        
        //status panel and message bar
        statusPanel.yScale = 0.30
        statusPanel.xScale = 1.5
        statusPanel.position = CGPoint(x: 700, y: 975)
        messageBar.position = CGPoint(x: 700, y:975)
        messageBar.text = "Welcome to MazeMan!"
        addChild(statusPanel)
        addChild(messageBar)


        
        //Game Tokens
        heart.position = CGPoint(x: 30, y: 950)
        heart.setScale(0.3)
        addChild(heart)
        rockSign.position = CGPoint(x: 100, y: 950)
        rockSign.setScale(0.3)
        addChild(rockSign)
        energyBar.position = CGPoint(x: 150, y: 950)
        energyBar.setScale(0.15)
        addChild(energyBar)
        star.position = CGPoint(x: 210, y: 950)
        star.setScale(0.50)
        addChild(star)
        
        
        //Labels
        var heartLabel = SKLabelNode(text: "\(heartCount)")
        var energyLabel = SKLabelNode(text: "\(energyCount)")
        var rockLabel = SKLabelNode(text: "\(rockCount)")
        var starLabel = SKLabelNode(text: "\(starCount)")
        
        heartLabel.position = heart.position
        energyLabel.position = energyBar.position
        rockLabel.position = rock.position
        starLabel.position = star.position
        addChild(heartLabel)
        addChild(energyLabel)
        addChild(rockLabel)
        addChild(starLabel)

        //Add food and star objectes
        foodObject.position =  randomFoodSpots[Int(arc4random_uniform(UInt32(randomFoodSpots.count)))]
        foodObject.setScale(0.5)
        foodObject.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: foodObject.frame.width, height: foodObject.frame.height))
        foodObject.physicsBody?.affectedByGravity = false
        foodObject.physicsBody?.isDynamic = false
        addChild(foodObject)
        
        starObject.position =  randomStarSpots[Int(arc4random_uniform(UInt32(randomStarSpots.count)))]
        starObject.setScale(0.7)
        starObject.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: starObject.frame.width, height: starObject.frame.height))
        starObject.physicsBody?.affectedByGravity = false
        starObject.physicsBody?.isDynamic = false
        addChild(starObject)
        
        dinoActions()
        applyBitMask()

    }
    
    func swiped(gesture: UIGestureRecognizer) -> Void {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left :
                let toTheLeft = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 2.0)
                caveMan.run(toTheLeft)
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.down:
                let downTown = SKAction.move(by: CGVector(dx: 0, dy: 100), duration: 2.0)
                caveMan.run(downTown)
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.right:
                let toTheRight = SKAction.move(by: CGVector(dx: 100, dy: 0), duration: 2.0)
                caveMan.run(toTheRight)
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.up:
                let upAndAway = SKAction.move(by: CGVector(dx: 0, dy:500), duration: 0.5)
                caveMan.run(upAndAway)
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    func applyBitMask(){
        
        caveMan.physicsBody?.categoryBitMask = PhysicsCategory.caveman.rawValue
        caveMan.physicsBody?.contactTestBitMask = PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurTwo.rawValue | PhysicsCategory.star.rawValue
        caveMan.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurTwo.rawValue | PhysicsCategory.star.rawValue
    
        block.physicsBody?.categoryBitMask = PhysicsCategory.block.rawValue
        block.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue

        dinoOne.physicsBody?.categoryBitMask = PhysicsCategory.dinosaurOne.rawValue
        dinoOne.physicsBody?.contactTestBitMask = PhysicsCategory.caveman.rawValue | PhysicsCategory.food.rawValue | PhysicsCategory.rock.rawValue
        dinoOne.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue | PhysicsCategory.rock.rawValue | PhysicsCategory.food.rawValue

        dinoTwo.physicsBody?.categoryBitMask = PhysicsCategory.dinosaurTwo.rawValue
        dinoTwo.physicsBody?.contactTestBitMask = PhysicsCategory.caveman.rawValue | PhysicsCategory.food.rawValue | PhysicsCategory.rock.rawValue
        dinoTwo.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue | PhysicsCategory.rock.rawValue | PhysicsCategory.food.rawValue
        
        dinoThree.physicsBody?.categoryBitMask = PhysicsCategory.dinosaurThree.rawValue
        dinoThree.physicsBody?.collisionBitMask = PhysicsCategory.boarderLeft.rawValue | PhysicsCategory.boarderRight.rawValue | PhysicsCategory.rock.rawValue
        dinoThree.physicsBody?.contactTestBitMask = PhysicsCategory.boarderLeft.rawValue | PhysicsCategory.boarderRight.rawValue | PhysicsCategory.block.rawValue | PhysicsCategory.rock.rawValue
        
        
        foodObject.physicsBody?.categoryBitMask = PhysicsCategory.food.rawValue
        foodObject.physicsBody?.contactTestBitMask = PhysicsCategory.caveman.rawValue
        foodObject.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue
        
        starObject.physicsBody?.categoryBitMask = PhysicsCategory.star.rawValue
        starObject.physicsBody?.contactTestBitMask = PhysicsCategory.caveman.rawValue
        starObject.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue
        
//        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
//        ground.physicsBody?.contactTestBitMask = PhysicsCategory.ground.rawValue
        ground.physicsBody?.collisionBitMask = PhysicsCategory.caveman.rawValue | PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.block.rawValue
        
        leftBoarder.physicsBody?.categoryBitMask = PhysicsCategory.boarderLeft.rawValue
        leftBoarder.physicsBody?.contactTestBitMask = PhysicsCategory.dinosaurThree.rawValue
        leftBoarder.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurThree.rawValue
        
        rightBoarder.physicsBody?.categoryBitMask = PhysicsCategory.boarderRight.rawValue
        rightBoarder.physicsBody?.contactTestBitMask = PhysicsCategory.dinosaurThree.rawValue
        rightBoarder.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurThree.rawValue
        
        upperBoarder.physicsBody?.categoryBitMask = PhysicsCategory.borderTop.rawValue
        upperBoarder.physicsBody?.contactTestBitMask = PhysicsCategory.dinosaurThree.rawValue
        upperBoarder.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurThree.rawValue
    }
    
    func dinoActions() -> Void {
        
        //dino one movements
        let upAction = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 3.0)
        let pause = SKAction.move(by: CGVector(dx: 0, dy: 0), duration: 3)
        let downAction = SKAction.move(by: CGVector(dx: 0, dy: -200 ), duration: 2)
        let dinoOneSet = SKAction.sequence([upAction,downAction])
        let repeater = SKAction.repeatForever(dinoOneSet)
        dinoOne.run(repeater)
        
        //dino two movements
        let rightAction = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let rotateAction = SKAction.customAction(withDuration: 0.0, actionBlock: { (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.dinoTwo.xScale = self.dinoTwo.xScale * -1
        })
        let leftAction = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let dinoTwoSet = SKAction.sequence([rotateAction,rightAction,rotateAction,leftAction])
        let repeatTwo = SKAction.repeatForever(dinoTwoSet)
        dinoTwo.run(repeatTwo)
        
        
        //dino three movements
        let up3Action = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 3.0)
        let down3Action = SKAction.move(by: CGVector(dx: 0, dy: -200 ), duration: 3.0)
        let right3Action = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let left3Action = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let flipAction = SKAction.customAction(withDuration: 0.0, actionBlock: { (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.dinoTwo.xScale = self.dinoTwo.xScale * -1
        })
        dinoThreeSet = [right3Action,left3Action,up3Action,down3Action]
        dinoThree.run(leftAction)
        
        
        //dino four movements
        let right4Action1 = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let right4Action2 = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let right4Action3 = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let right4Action4 = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)
        let right4Action5 = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 3.0)

        let left4Action1 = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let left4Action2 = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let left4Action3 = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let left4Action4 = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        let left4Action5 = SKAction.move(by: CGVector(dx: -200, dy: 0), duration: 3.0)
        

        let dinoFourSet = SKAction.sequence([right4Action1,right4Action2,right4Action3,right4Action4,right4Action5, left4Action1,left4Action2,left4Action3,left4Action4,left4Action5])
        let dino4Repeat = SKAction.repeatForever(dinoFourSet)
        dinoFour.run(dino4Repeat)
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(arc4random_uniform(10))
        , repeats: true) { (Timer) in
            self.dropFire()
            self.drinkFireBall()
        }
        }
    
    func drinkFireBall(){
        fireBall.removeFromParent()
    }
    
    func dropFire(){
        fireBall.position = dinoFour.position
        fireBall.physicsBody?.affectedByGravity = true
        addChild(fireBall)
    }
    
    func dinoThreeRandomAction(rand:Int,actionArray:[SKAction]) -> Void {
        var randNum = rand
        prevAction = rand
        dinoThree.removeAllActions()
        while prevAction == randNum {
            randNum = Int(arc4random_uniform(4))
        }
        let flipAction = SKAction.customAction(withDuration: 0.0, actionBlock: { (node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.dinoTwo.xScale = self.dinoTwo.xScale * -1
        })
       
        dinoThree.run(flipAction)
        var repeater = SKAction.repeatForever(actionArray[randNum])
        dinoThree.run(repeater)
    
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.categoryBitMask == PhysicsCategory.caveman.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurTwo.rawValue {
            
            updateMessageBar(messageNumber: 2)
            caveMan.removeAllActions()
            print("contactOne")
            
        }else if contact.bodyB.categoryBitMask == PhysicsCategory.caveman.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurOne.rawValue {
            
            updateMessageBar(messageNumber: 3)
            print("Contact")
            
        }else if contact.bodyB.categoryBitMask == PhysicsCategory.food.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.caveman.rawValue {
            
            foodObject.removeFromParent()
            updateMessageBar(messageNumber: 1)
            foodObject.position = randomFoodSpots[Int(arc4random_uniform(UInt32(randomFoodSpots.count)))]
            newFood()
            
        }else if contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurTwo.rawValue | PhysicsCategory.dinosaurThree.rawValue && contact.bodyB.categoryBitMask == PhysicsCategory.food.rawValue{
            
            foodObject.removeFromParent()
            updateMessageBar(messageNumber: 1)
            foodObject.position = randomFoodSpots[Int(arc4random_uniform(UInt32(randomFoodSpots.count)))]
            Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false, block: {_ in
                self.newFood()
            })
            
        }else if (contact.bodyB.categoryBitMask == PhysicsCategory.caveman.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.star.rawValue) || (contact.bodyB.categoryBitMask == PhysicsCategory.star.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.caveman.rawValue){
            
            starObject.removeFromParent()
            starObject.position = randomStarSpots[Int(arc4random_uniform(UInt32(randomStarSpots.count)))]
                self.newStar()
            starCount = starCount + 1
            updateMessageBar(messageNumber: 5)
            
        }else if (contact.bodyB.categoryBitMask == PhysicsCategory.rock.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurTwo.rawValue) ||  contact.bodyB.categoryBitMask == PhysicsCategory.dinosaurTwo.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.caveman.rawValue {
         updateMessageBar(messageNumber: 3)
            if contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurTwo.rawValue {
                dinoTwo.removeFromParent()
                Timer.scheduledTimer(withTimeInterval: TimeInterval(arc4random_uniform(5)), repeats: false, block: { (Timer) in
                    self.addChild(self.dinoTwo)
                })
            }else if contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurThree.rawValue{
                dinoThree.removeFromParent()
                
                Timer.scheduledTimer(withTimeInterval: TimeInterval(arc4random_uniform(5)), repeats: false, block: { (Timer) in
                    self.addChild(self.dinoThree)
                })
            }else if contact.bodyA.categoryBitMask == PhysicsCategory.dinosaurOne.rawValue{
               dinoOne.removeFromParent()
               Timer.scheduledTimer(withTimeInterval: TimeInterval(arc4random_uniform(5)), repeats: false, block: { (Timer) in
                    self.addChild(self.dinoOne)
                })
            }
        }else if (contact.bodyB.categoryBitMask == PhysicsCategory.dinosaurThree.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.boarderLeft.rawValue) {
            //add dinosaur three contacts
            dinoThreeRandomAction(rand: Int(arc4random_uniform(3)), actionArray: dinoThreeSet)
            
        } else if (contact.bodyB.categoryBitMask == PhysicsCategory.dinosaurThree.rawValue && contact.bodyA.categoryBitMask == PhysicsCategory.boarderRight.rawValue){
            dinoThreeRandomAction(rand: Int(arc4random_uniform(3)), actionArray: dinoThreeSet)
        }
    }
    

    func newStar (){
        addChild(starObject)
    }
    
    
    func newFood() -> Void {
        addChild(foodObject)
    }
    
    
    func throwRock(location: CGPoint){
        var thrower = SKAction.move(by: CGVector(dx: location.x, dy: location.y), duration: 5.0)
        rock.run(thrower)
        rock.position = caveMan.position
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(caveMan.position)
        rock.setScale(0.5)
        rock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock.frame.width, height: rock.frame.height))
        rock.physicsBody?.affectedByGravity = false
        rock.physicsBody?.categoryBitMask = PhysicsCategory.rock.rawValue
        rock.physicsBody?.collisionBitMask = PhysicsCategory.dinosaurTwo.rawValue | PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurThree.rawValue
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.dinosaurTwo.rawValue | PhysicsCategory.dinosaurOne.rawValue | PhysicsCategory.dinosaurThree.rawValue
        addChild(rock)
        rockCount = rockCount - 1
        rock.position = caveMan.position
        throwRock(location: (touches.first?.preciseLocation(in: self.view))!)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
            self.rock.removeFromParent()
        }
        rock.position = caveMan.position
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    //adds random blocks to screen
    func blockChain() -> Void {
        var count = 0
        var rand = Int(arc4random_uniform(4))
        var blocks: [Block] = []
        var randBlock: Block
        var spot:(Int,Int)
        
        while count < 1
        {
            spot = spots[rand]
            spots.remove(at: rand)
            randBlock = Block(xPosition: spot.0 , yPosition: spot.1)
            blocks.append(randBlock)
            count = count + 1
            rand = Int(arc4random_uniform(4))
        }
        
        for item in blocks {
            item.blockInstance.setScale(0.5)
            addChild(item.blockInstance)
        }

    }
    
    func updateMessageBar(messageNumber: Int) -> Void {
        if messageNumber == 1 {
            messageBar.text = "Food: Nom nom nom"
        }else if messageNumber == 2{
            messageBar.text = "A Change of Heart"
        }else if messageNumber == 3{
            messageBar.text = "Enemy Killed"
        }else if messageNumber == 4{
            messageBar.text = "She's American"
        }else if messageNumber == 5{
            messageBar.text = "Bravo, you’ve got the star"
        }else{
            messageBar.text = "Welcome to MazeMan!"
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    enum PhysicsCategory : UInt32 {
        case caveman = 1
        case block   = 8
        case dinosaurOne = 12
        case dinosaurTwo = 16
        case dinosaurThree = 20
        case boarderLeft = 24
        case boarderRight = 28
        case rock = 32
        case food = 36
        case star = 40
        case randBlock = 44
        case borderTop = 48
    }

}
