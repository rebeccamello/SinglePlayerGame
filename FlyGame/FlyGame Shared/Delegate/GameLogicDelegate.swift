//
//  GameLogicDelegate.swift
//  FlyGame
//
//  Created by Nathalia do Valle Papst on 07/03/22.
//

import Foundation
import SpriteKit

protocol GameLogicDelegate: AnyObject {
    func resumeGame()
    
    func drawScore(score: Int)
    
    func goToHome()
    
    func soundAction()
    
    func musicAction()
    
    func createObstacle(obstacle: Obstacle)
}


