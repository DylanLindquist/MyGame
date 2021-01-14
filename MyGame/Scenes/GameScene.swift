//
//  GameScene.swift
//  MyGame
//
//  Created by Lindquist, Dylan on 1/12/21.
//

import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate
{
    private var colorMask : Int = 0b0000
    
    private let scoreNode : SKLabelNode = SKLabelNode(fontNamed: "Copperplate-Bold")
    
    private var score : Int = -0
    {
        didSet
        {
            scoreNode.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) -> Void
    {
        //Add Score
        scoreNode.zPosition = 2
        scoreNode.position.x = 120
        scoreNode.position.y = 385
        scoreNode.fontSize = 20
        addChild(scoreNode)
        score = 0 //Force update of display.
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) -> Void
    {
        guard let touch = touches.first else { return }
        
        let currentColor = assignColorAndBitmask()
        
        let width = Int(arc4random() % 50)
        let height = Int(arc4random() % 50)
        let location = touch.location(in: self)
        
        let node : SKSpriteNode
        
        node = SKSpriteNode(color: currentColor, size: CGSize(width: width, height: height))
        
        node.position = location
        
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        node.physicsBody?.contactTestBitMask = UInt32(colorMask)
        
        addChild(node)
    }
    
    private func assignColorAndBitmask() -> UIColor
    {
        let colors : [UIColor] = [.red, .blue, .green, .orange, .white, .magenta, .yellow]
        let randomIndex = Int(arc4random()) % colors.count
        
        colorMask = randomIndex + 1
        
        return colors[randomIndex]
    }
    //Checks for contact
    func didBegin(_ contact : SKPhysicsContact) -> Void
    {
        guard let first = contact.bodyA.node else { return }
        guard let second = contact.bodyB.node else { return }
        
        collisionBetween(first, and: second)
    }
    
    //Distinguishes color
    private func collisionBetween(_ nodeOne : SKNode, and nodeTwo : SKNode) -> Void
    {
        if (nodeOne.physicsBody?.contactTestBitMask == nodeTwo.physicsBody?.contactTestBitMask)
        {
            annihilate(deadNode: nodeOne)
            annihilate(deadNode: nodeTwo)
        }
    }
    //Takes node out
    private func annihilate(deadNode : SKNode) -> Void
    {
        deadNode.removeFromParent()
    }
}
