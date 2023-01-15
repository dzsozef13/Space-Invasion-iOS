//
//  OptionsScene.swift
//  Space Invasion
//
//  Created by Punk József on 2018. 03. 28.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
		
	var creditsLabel:SKSpriteNode!
	
	var starfield:SKEmitterNode!
	
    var background:SKSpriteNode!
	
	override func didMove(to view: SKView) {
	
		if screenWidth == 828 /* iPhone XR */ {
			
			self.size.width = 1080
			self.size.height = 2337
			screenWidth = 1080
			screenHeight = 2337
			
		}
		
		if screenWidth == 1125 /* iPhone X, XS */ {
			
			self.size.width = 1080
			self.size.height = 2339
			screenWidth = 1080
			screenHeight = 2339
			
		}
		
		if screenWidth == 1242 /* iPhone 6+,7+,8+ */ {
			
			self.size.width = 1080
			self.size.height = 1920
			screenWidth = 1080
			screenHeight = 1920
			
		}
	
		if screenWidth == 750 /* iPhone 6,7,8 */ {
			
			self.size.width = 1080
			self.size.height = 1920
			screenWidth = 1080
			screenHeight = 1920
			
		}

	
	
//starfiled..............................
	
		starfield = SKEmitterNode(fileNamed: "Starfield")
		starfield.position = CGPoint(x: screenWidth / 2, y: screenHeight)
		starfield.advanceSimulationTime(10)
		starfield.zPosition = -2
		
		self.addChild(starfield)
	
		background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
		background.zPosition = -3
	
		self.addChild(background)
	
//credits label

		creditsLabel = SKSpriteNode(imageNamed: "credits")
		creditsLabel.position = CGPoint(x: screenWidth / 2 , y: -2500)
		creditsLabel.zPosition = -1

		self.addChild(creditsLabel)

		let animationDuration:TimeInterval = 30
		var actionArray = [SKAction]()

		actionArray.append(SKAction.move(to: CGPoint(x: screenWidth / 2, y: 5000), duration: TimeInterval(animationDuration)))
		creditsLabel.run(SKAction.sequence(actionArray))

	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		let transition:SKTransition = SKTransition.fade(withDuration: 0)
		let scene:SKScene = MenuScene(size: self.size)
		self.view?.presentScene(scene, transition: transition)
	
	}
}

