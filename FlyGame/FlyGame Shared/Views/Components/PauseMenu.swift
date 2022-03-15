//
//  PauseMenu.swift
//  FlyGame
//
//  Created by Caroline Taus on 14/03/22.
//

import Foundation
import SpriteKit

class PauseMenu: SKNode {
    
    var buttonsContainer: SKShapeNode = SKShapeNode(rectOf: .screenSize(widthMultiplier: 0.5, heighMultiplier: 0.8), cornerRadius: 20)
    var bg: SKSpriteNode = SKSpriteNode(color: .black, size: .screenSize())
    weak var gameDelegate: GameLogicDelegate?
    
    lazy var retryButton: SKButtonNode = {
        let but = SKButtonNode(image: SKSpriteNode(imageNamed: "recomecarBotao")) {
            self.gameDelegate?.retryGame()
        }
        return but
    }()
    lazy var homeButton: SKButtonNode = {
        let but = SKButtonNode(image: SKSpriteNode(imageNamed: "menuBotao")) {
            self.gameDelegate?.goToHome()
        }
        return but
    }()
    lazy var resumeButton: SKButtonNode = {
        let but = SKButtonNode(image: SKSpriteNode(imageNamed: "continuarBotao")) {
            self.gameDelegate?.resumeGame()
        }
        return but
    }()
    lazy var soundButton: SKButtonNode = {
        let but = SKButtonNode(image: SKSpriteNode(imageNamed: "somBotao")) {
            self.gameDelegate?.sound()
        }
        return but
    }()
    
    lazy var musicButton: SKButtonNode = {
        let but = SKButtonNode(image: SKSpriteNode(imageNamed: "musicaBotao")) {
            self.gameDelegate?.music()
        }
        return but
    }()
    
    override init() {
        super.init()
        addChild(bg)
        addChild(buttonsContainer)
        buttonsContainer.addChild(homeButton)
        buttonsContainer.addChild(retryButton)
        buttonsContainer.addChild(soundButton)
        buttonsContainer.addChild(musicButton)
        buttonsContainer.addChild(resumeButton)
        
        homeButton.setScale(bg.size.width * 0.00023)
        retryButton.setScale(bg.size.width * 0.00023)
        soundButton.setScale(bg.size.width * 0.00023)
        musicButton.setScale(bg.size.width * 0.00023)
        resumeButton.setScale(bg.size.width * 0.00026)
                
        buttonsContainer.lineWidth = 0
        setPositions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
   
    func setPositions() {
        resumeButton.zPosition = 4
        resumeButton.position = CGPoint(x: 0, y: buttonsContainer.frame.size.height * 0.15)
        
        bg.zPosition = 3
        bg.alpha = 0.45
        
        homeButton.zPosition = 4
        homeButton.position = CGPoint(x: -buttonsContainer.frame.size.width/3, y: -resumeButton.position.y*1.4)
        
        retryButton.zPosition = 4
        retryButton.position = CGPoint(x: -buttonsContainer.frame.size.width/9, y: -resumeButton.position.y*1.4)
        
        soundButton.zPosition = 4
        soundButton.position = CGPoint(x: buttonsContainer.frame.size.width/9, y: -resumeButton.position.y*1.4)
        
        musicButton.zPosition = 4
        musicButton.position = CGPoint(x: buttonsContainer.frame.size.width/3, y: -resumeButton.position.y*1.4)
    }
    
   
    
}