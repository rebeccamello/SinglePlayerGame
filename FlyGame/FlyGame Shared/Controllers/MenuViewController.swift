//
//  MenuViewController.swift
//  FlyGame
//
//  Created by Gui Reis on 24/03/22.
//

import class UIKit.UIViewController
import class SpriteKit.SKView

class MenuViewController: UIViewController {
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        let scene = MenuScene.newGameScene()
        
        let skView = SKView()
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        // skView.showsFPS = true
        // skView.showsNodeCount = true
        self.view = skView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterService.shared.setController(self)
        // Fazendo a autenticação com o Game Center
        GameCenterService.shared.autenticateUser {vct, score, error in
            if let error = error {
                print("ERRO GAME CENTER: \(error.description)")
                return
            }
            if let vct = vct {
                self.present(vct, animated: true)
                return
            }
            if let score = score {
                guard let scene = (self.view as? SKView)?.scene as? MenuScene else {return}
                scene.setScore(with: score)
            }
        }
    }
}
