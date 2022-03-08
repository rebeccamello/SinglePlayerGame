//
//  GameScene.swift
//  FlyGame Shared
//
//  Created by Nathalia do Valle Papst on 07/03/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var currentPosition: CGFloat = 3
    
    lazy var scenarioImage: SKSpriteNode = {
        var scenario = SKSpriteNode()
        scenario = SKSpriteNode(imageNamed: "Cenário")
        
        return scenario
    }()
    
    lazy var gameLogic: GameSceneController = {
        let g = GameSceneController()
        g.gameDelegate = self
        return g
    }()
    
    lazy var playerNode: SKSpriteNode = {
        var bug = SKSpriteNode(imageNamed: "Mosca")
        bug.name = "Mosca"
        bug.setScale(0.8)
        bug.physicsBody = SKPhysicsBody(rectangleOf: bug.size)
        bug.physicsBody?.affectedByGravity = false // faz continuar a colisao mas sem cair
        bug.physicsBody?.isDynamic = true // faz reconhecer a colisao
        bug.physicsBody!.contactTestBitMask = bug.physicsBody!.collisionBitMask
        bug.physicsBody?.restitution = 0.4
        
        let texture: [SKTexture] = [SKTexture(imageNamed: "mosca0.png"),
                                    SKTexture(imageNamed: "mosca1.png"),
                                    SKTexture(imageNamed: "mosca2.png"),
                                    SKTexture(imageNamed: "mosca3.png"),
                                    SKTexture(imageNamed: "mosca4.png"),
                                    SKTexture(imageNamed: "mosca5.png")]
        for t in texture{
            t.filteringMode = .nearest
        }
        let idleAnimation = SKAction.animate(with: texture, timePerFrame: 0.04)
        let loop = SKAction.repeatForever(idleAnimation)
        bug.run(loop)
        
        return bug
    }()
    
    lazy var enemyNode: SKSpriteNode = {
        var enemy = SKSpriteNode(imageNamed: "Comoda")
        enemy.name = "Enemy"
        enemy.setScale(0.7)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.affectedByGravity = false // faz continuar a colisao mas sem cair
        enemy.physicsBody?.isDynamic = true // faz reconhecer a colisao
        enemy.physicsBody!.contactTestBitMask = enemy.physicsBody!.collisionBitMask
        enemy.physicsBody?.restitution = 0.4
        return enemy
    }()
    
    lazy var background: SKSpriteNode = {
        var bg = SKSpriteNode(imageNamed: "bg")
        return bg
    }()
    
    class func newGameScene() -> GameScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        removeAllChildren()
        removeAllActions()
        
//        self.addChild(scenarioImage)
        scenarioImage.size.width = self.size.width
        scenarioImage.size.height = self.size.height
        scenarioImage.position = CGPoint(x: scenarioImage.size.width/2, y: scenarioImage.size.height/2)
        
        self.addChild(playerNode)
        self.addChild(enemyNode)
        
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = .up
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        
        self.view?.addGestureRecognizer(swipeUp)
        self.view?.addGestureRecognizer(swipeDown)
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
        gameLogic.startUp()
        physicsWorld.contactDelegate = self
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        self.setUpScene()
        playerNode.position = CGPoint(x: size.width/4, y: size.height/2)
        enemyNode.position = CGPoint(x: size.width - enemyNode.size.width/2, y: enemyNode.size.height)
    }
       
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if contact.bodyB.node?.name == "Mosca" {
            collisionBetween(player: nodeA, enemy: nodeB)
        }
    }
    
    func collisionBetween(player: SKNode, enemy: SKNode) {
        gameLogic.tearDown()
        let scene = GameOverScene.newGameScene()
        view?.presentScene(scene)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        guard
            let swipeGesture = gesture as? UISwipeGestureRecognizer,
            let direction = swipeGesture.direction.direction
        else { return }
        
        gameLogic.movePlayer(direction: direction, position: Int(currentPosition))
    }
}

extension GameScene: GameLogicDelegate {
    func resumeGame() {
        print("resume")
    }
    
    func pauseGame() {
        print("pause")
    }
    
    func gameOver() {
        print("gameOver")
    }
    
    func obstacleSpeed(speed: CGFloat) {
        enemyNode.position.x -= speed
    }
    
    func movePlayer(position: Int) {
        print(position)
        playerNode.position.y = CGFloat(position) * (size.height / 6)
        currentPosition = CGFloat(position)
    }
}

enum Direction {
    case up, down
}

extension UISwipeGestureRecognizer.Direction {
    var direction: Direction? {
        switch self {
        case .up:
            return Direction.up
            
        case .down:
            return Direction.down
            
        default:
            return nil
        }
    }
}
