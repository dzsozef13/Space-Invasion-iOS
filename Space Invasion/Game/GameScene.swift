//
//  GameScene.swift
//  Space Invasion
//
//  Created by Punk József Ádám on 2018. 01. 05.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
		
	var player = SKSpriteNode()
	
	var playerSteering = 0
	var playerHealth = 0
	var playerfireSpeed = 0
	
	var starfield:SKEmitterNode!
	
	var gameIsPaused = 0
	
	var scoreLabel:SKLabelNode!
	var scoreMultiplierLabel:SKLabelNode!
	var bestScoreLabel:SKLabelNode!
	var xpLabel:SKLabelNode!
	
	var heart01:SKSpriteNode!
	var heart02:SKSpriteNode!
	var heart03:SKSpriteNode!
	var heart04:SKSpriteNode!
	var heart05:SKSpriteNode!
	var heart06:SKSpriteNode!
	var heart07:SKSpriteNode!
	var heart08:SKSpriteNode!
	var heart09:SKSpriteNode!
	
	var background:SKSpriteNode!
	
	var controlLeftButton = SKSpriteNode()
	var controlRightButton = SKSpriteNode()
	let controlLeftButtonTex = SKTexture(imageNamed: "controlButton")
	let controlRightButtonTex = SKTexture(imageNamed: "controlButton")
	
	var restartButton = SKSpriteNode()
    let restartButtonTex = SKTexture(imageNamed: "spaceship01")
//    var quitButton = SKSpriteNode()
//    let quitButtonTex = SKTexture(imageNamed: "redBackButton")
	
	var fireTimer:Timer!
	var alienTimer:Timer!
	var asteroidTimer:Timer!
	var scoreTimer:Timer!
	var stageTimer:Timer!
	var enableFireTimer:Timer!
	var gameOverTimer:Timer!
	var movePlayerTimer:Timer!
	
	var gameMode = UserDefaults().integer(forKey: "GameMode")
	
	var selectedSpaceship = UserDefaults().integer(forKey: "SelectedSpaceship")

	
	var lives = 3
	
	var score = 0 {
		didSet {
			scoreLabel.text = "\(score)"
			scoreLabel.fontName = "boldp"
		}
	}
	
	var scoreMultiplier = 1 {
		didSet {
			scoreMultiplierLabel.text = "*\(scoreMultiplier)"
			scoreMultiplierLabel.fontName = "boldp"
		}
	}
	
	var expeiencePoints = UserDefaults().integer(forKey: "ExperiencePoints")
	var highScore = UserDefaults().integer(forKey: "HighScore")
	var lastScore = UserDefaults().integer(forKey: "LastScore")

	var addScoreFrequency:TimeInterval = 0.25
	var alienSpeed:TimeInterval = 6.0
	var alienFrequency:TimeInterval = 1.5
//	var asteroidSpeed:TimeInterval = 10
//	var asteroidFrequency:TimeInterval = 3
	
	var fireSpeed:TimeInterval = 1
	var fireFrequency:TimeInterval = 1
	var isFiringOn = 1
	
	var playerPositionY = 0
	var playerPositionX = 0

//	var playerPositionX = 0
//	var playerSensibility = 150
	
	var possibleAliens = ["alien01", "alien02", "alien03"]
	
	let alienCategory:UInt32 = 0x1 << 1
	let photonTorpedoCategory:UInt32 = 0x1 << 0
	let playerCategory:UInt32 = 0x1 << 1
	
	let motionManager = CMMotionManager()
	var yAcceleration:CGFloat = 0
	var direction:CGFloat = 0
	
//gameplay...............................

	override func didMove(to view: SKView) {
	
    	let notificationCenter = NotificationCenter.default
    	notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    	notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)

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

		self.addChild(starfield)
		starfield.zPosition = -1

		background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
		background.zPosition = -2
		
		self.addChild(background)
		
//scorelabel..............................

		scoreLabel = SKLabelNode(text: "0")
		scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + 750)
		scoreLabel.zPosition = 3
		scoreLabel.fontSize = 100
		scoreLabel.fontColor = UIColor.white
		scoreLabel.fontName = "boldp"
		
		score = 0
	
		self.addChild(scoreLabel)
		
		scoreMultiplierLabel = SKLabelNode(text: "*1")
		scoreMultiplierLabel.position = CGPoint(x: frame.midX, y: frame.midY + 660)
		scoreMultiplierLabel.zPosition = 3
		scoreMultiplierLabel.fontSize = 50
		scoreMultiplierLabel.fontColor = UIColor.white
		scoreMultiplierLabel.fontName = "boldp"
	
		self.addChild(scoreMultiplierLabel)
		
//lives...............................

		heart01 = SKSpriteNode(imageNamed: "heart")
			heart01.position = CGPoint(x: screenWidth * 0.1, y: screenHeight - 150)
			heart01.zPosition = 3
			self.addChild(heart01)
		heart02 = SKSpriteNode(imageNamed: "heart")
			heart02.position = CGPoint(x: screenWidth * 0.2, y: screenHeight - 150)
			heart02.zPosition = 3
			self.addChild(heart02)
		heart03 = SKSpriteNode(imageNamed: "heart")
			heart03.position = CGPoint(x: screenWidth * 0.3, y: screenHeight - 150)
			heart03.zPosition = 3
			self.addChild(heart03)
		heart04 = SKSpriteNode(imageNamed: "heart")
			heart04.position = CGPoint(x: screenWidth * 0.4, y: screenHeight - 150)
			heart04.zPosition = 3
			self.addChild(heart04)
		heart05 = SKSpriteNode(imageNamed: "heart")
			heart05.position = CGPoint(x: screenWidth * 0.5, y: screenHeight - 150)
			heart05.zPosition = 3
			self.addChild(heart05)
		heart06 = SKSpriteNode(imageNamed: "heart")
			heart06.position = CGPoint(x: screenWidth * 0.6, y: screenHeight - 150)
			heart06.zPosition = 3
			self.addChild(heart06)
		heart07 = SKSpriteNode(imageNamed: "heart")
			heart07.position = CGPoint(x: screenWidth * 0.7, y: screenHeight - 150)
			heart07.zPosition = 3
			self.addChild(heart07)
		heart08 = SKSpriteNode(imageNamed: "heart")
			heart08.position = CGPoint(x: screenWidth * 0.8, y: screenHeight - 150)
			heart08.zPosition = 3
			self.addChild(heart08)
		heart09 = SKSpriteNode(imageNamed: "heart")
			heart09.position = CGPoint(x: screenWidth * 0.9, y: screenHeight - 1500)
			heart09.zPosition = 3
			self.addChild(heart09)


		
		
		if lives == 1 {
			heart02.isHidden = true
			heart03.isHidden = true
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 2 {
			heart03.isHidden = true
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 3 {
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 4 {
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 5 {
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 6 {
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 7 {
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 8 {
			heart09.isHidden = true
		}
		
//controls............................

		controlLeftButton = SKSpriteNode(texture: controlLeftButtonTex)
        controlLeftButton.position = CGPoint(x: frame.midX - 270, y: frame.midY)
        controlLeftButton.zPosition = 1
        self.addChild(controlLeftButton)
		
        controlRightButton = SKSpriteNode(texture: controlRightButtonTex)
        controlRightButton.position = CGPoint(x: frame.midX + 270, y: frame.midY)
        self.addChild(controlRightButton)
        controlRightButton.zPosition = 1
		
//		quitButton = SKSpriteNode(texture: quitButtonTex)
//        quitButton.position = CGPoint(x: screenWidth - 80, y: frame.midY + 750)
//        controlLeftButton.zPosition = 4
//        self.addChild(quitButton)
		
//player..............................
	
		if selectedSpaceship == 1 {
			player = SKSpriteNode(imageNamed: "spaceship01")
		}
		
		if selectedSpaceship == 2 {
			player = SKSpriteNode(imageNamed: "spaceship02")
		}
		
		if selectedSpaceship == 3 {
			player = SKSpriteNode(imageNamed: "spaceship03")
		}
		
		if selectedSpaceship == 4 {
			player = SKSpriteNode(imageNamed: "spaceship04")
		}
		
		if selectedSpaceship == 5 {
			player = SKSpriteNode(imageNamed: "spaceship05")
		}
		
		if selectedSpaceship == 6 {
			player = SKSpriteNode(imageNamed: "spaceship06")
		}
		
		if selectedSpaceship == 7 {
			player = SKSpriteNode(imageNamed: "spaceship07")
		}
		
		if selectedSpaceship == 8 {
			player = SKSpriteNode(imageNamed: "spaceship08")
		}
		
		playerPositionX = Int(frame.midX)
		playerPositionY = Int(frame.midY - 600)
		
		player.position = CGPoint(x: playerPositionX, y: playerPositionY)

		player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
		player.physicsBody?.isDynamic = true
	
		player.physicsBody?.categoryBitMask = playerCategory
		player.physicsBody?.contactTestBitMask = alienCategory
		player.physicsBody?.collisionBitMask = 0

		self.addChild(player)
		
		self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		self.physicsWorld.contactDelegate = self
	
//motion..............................
		
		motionManager.accelerometerUpdateInterval = 0
		motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
			if let accelerometerData = data {
				let acceleration = accelerometerData.acceleration
				self.yAcceleration = CGFloat(acceleration.x) * 0.75 + self.yAcceleration * 0.25
			}
		}
		
//timers..............................
		
		fireTimer = Timer.scheduledTimer(timeInterval: fireFrequency, target: self, selector: #selector(fireTorpedo), userInfo: nil, repeats: true)
		alienTimer = Timer.scheduledTimer(timeInterval: alienFrequency, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
		scoreTimer = Timer.scheduledTimer(timeInterval: addScoreFrequency, target: self, selector: #selector(addScore), userInfo: nil, repeats: true)
		stageTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(nextStage), userInfo: nil, repeats: true)
		enableFireTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(enableFire), userInfo: nil, repeats: false)
	
	}
	
	@objc func appMovedToBackground() {
        // do whatever event you want
        stopTimers()
    }
	
    @objc func appMovedToForeground() {
        // do whatever event you want
        startTimers()
    }
	
	@objc func addScore() {
		
		score += 1 * scoreMultiplier
		
	}
	
	@objc func nextStage() {
		
		alienTimer.invalidate()
		
		alienSpeed = alienSpeed * 0.9
			if alienSpeed <= 1.5 { alienSpeed = 1.5 }
		
		alienFrequency = alienFrequency * 0.9
			if alienFrequency <= 0.3 { alienFrequency = 0.3 }
		
		alienTimer = Timer.scheduledTimer(timeInterval: alienFrequency, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
		
	}
	
	@objc func addAlien() {
		
		possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
		
		let alien = SKSpriteNode(imageNamed: possibleAliens[0])
		let randomAlienPosition = GKRandomDistribution(lowestValue: 100, highestValue: 980)
		let alienPositionX = CGFloat(randomAlienPosition.nextInt())
		
		alien.position = CGPoint(x: alienPositionX, y: 2200)
		alien.zPosition = 0
		
		alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
		alien.physicsBody?.isDynamic = true
		
		alien.physicsBody?.categoryBitMask = alienCategory
		alien.physicsBody?.contactTestBitMask = photonTorpedoCategory
		alien.physicsBody?.collisionBitMask = 0
		
		self.addChild(alien)
		
		let animationDuration:TimeInterval = alienSpeed
		var actionArray = [SKAction]()
		
		actionArray.append(SKAction.move(to: CGPoint(x: alienPositionX, y: -alien.size.height / 2), duration: TimeInterval(animationDuration)))
		actionArray.append(SKAction.removeFromParent())
		
		alien.run(SKAction.sequence(actionArray))
		
	}
	
	
	@objc func movePlayerLeft() {
	
		player.position.x = player.position.x - 1
		if player.position.x < 100 { player.position = CGPoint(x: 100, y: player.position.y)}
		if player.position.x > screenWidth - 100 { player.position = CGPoint(x: screenWidth - 100, y: player.position.y)}
		
	}
	
	@objc func movePlayerRight() {
	
		player.position.x = player.position.x + 1
		if player.position.x < 100 { player.position = CGPoint(x: 100, y: player.position.y)}
		if player.position.x > screenWidth - 100 { player.position = CGPoint(x: screenWidth - 100, y: player.position.y)}
		
	}
	
	
	
	@objc func enableFire() {
	
		isFiringOn = 1
		
	}
	
	@objc func disableShooting() {
	
		isFiringOn = 0
		
	}
	
	@objc func stopTimers() {
	
		fireTimer.invalidate()
		alienTimer.invalidate()
		scoreTimer.invalidate()
		stageTimer.invalidate()
		enableFireTimer.invalidate()
		
	}
	
	@objc func startTimers() {
	
		fireTimer = Timer.scheduledTimer(timeInterval: fireFrequency, target: self, selector: #selector(fireTorpedo), userInfo: nil, repeats: true)
		alienTimer = Timer.scheduledTimer(timeInterval: alienFrequency, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
		scoreTimer = Timer.scheduledTimer(timeInterval: addScoreFrequency, target: self, selector: #selector(addScore), userInfo: nil, repeats: true)
		stageTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(nextStage), userInfo: nil, repeats: true)
		enableFireTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(enableFire), userInfo: nil, repeats: false)
		
	}
	
	
	@objc func gameOver() {
		
		/*restartButton = SKSpriteNode(texture: restartButtonTex)
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY)
        restartButton.zPosition = 4
        self.addChild(restartButton)
		
		quitButton = SKSpriteNode(texture: quitButtonTex)
        quitButton.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2 - 200 )
        quitButton.zPosition = 4
        self.addChild(quitButton)
		
		bestScoreLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "HighScore")))
		bestScoreLabel.position = CGPoint(x: screenWidth / 2, y: screenHeight - 400)
		bestScoreLabel.zPosition = 3
		bestScoreLabel.fontSize = 75
		bestScoreLabel.fontColor = UIColor.white
		bestScoreLabel.fontName = "boldp"
		
		self.addChild(bestScoreLabel)
		
		xpLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "ExperiencePoints")))
		xpLabel.position = CGPoint(x: screenWidth / 2, y: screenHeight - 600)
		xpLabel.zPosition = 3
		xpLabel.fontSize = 75
		xpLabel.fontColor = UIColor.white
		xpLabel.fontName = "boldp"
		
		self.addChild(xpLabel)*/
		
		lives = 0
		scoreMultiplier = 0
		
		let transition:SKTransition = SKTransition.fade(withDuration: 0)
		let scene:SKScene = GameOverScene(size: self.size)
		self.view?.presentScene(scene, transition: transition)
		
	}

//touch detection...............................

//	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

//		if isFiringOn == 1 {
//			fireTorpedo()
//		}

//	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

			if node == restartButton {
			
				let transition:SKTransition = SKTransition.fade(withDuration: 0)
				let scene:SKScene = GameScene(size: self.size)
				self.view?.presentScene(scene, transition: transition)
			
			}

//            if node == quitButton {
//
//				if gameIsPaused == 0 {
//					stopTimers()
//					gameIsPaused = 1
//				}
//				else {
//					startTimers()
//					gameIsPaused = 0
//				}
//
//            }
			
			if node == controlLeftButton {
			
				direction = -10
				
			}
			
			if node == controlRightButton {
			
				direction = 10

			}
        }
    }
	
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

			if node == controlLeftButton {
				if direction == -10 {
					direction = 0
				}
			}
			
			if node == controlRightButton {
			
				if direction == +10 {
					direction = 0
				}
			}
		}
	}
	
//firing................................

	@objc func fireTorpedo() {
	
		if isFiringOn == 1 {

//			self.run(SKAction.playSoundFileNamed("Torpedo.mp3", waitForCompletion: false))

				let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
				torpedoNode.position = CGPoint(x: player.position.x, y: frame.midY - 590 + player.size.height / 2 )

				torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
				torpedoNode.physicsBody?.isDynamic = true
	
				torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
				torpedoNode.physicsBody?.contactTestBitMask = alienCategory
				torpedoNode.physicsBody?.collisionBitMask = 0
				torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
	
				self.addChild(torpedoNode)
	
				let animationDuration:TimeInterval = fireSpeed
		
				var actionArray = [SKAction]()
	
				actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: 2000), duration: TimeInterval(animationDuration)))
				actionArray.append(SKAction.removeFromParent())
	
				torpedoNode.run(SKAction.sequence(actionArray))
			
			
		}
	}
	
//contact detection................................

	func didBegin(_ contact: SKPhysicsContact) {

		var firstBody:SKPhysicsBody
		var secondBody:SKPhysicsBody
	
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		}else{
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}
	
		if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
			torpedoDidCollideWithAlien(torpedo: firstBody.node as! SKSpriteNode, alien: secondBody.node as! SKSpriteNode)
		}
	
		if (firstBody.categoryBitMask & alienCategory) != 0 && (secondBody.categoryBitMask & playerCategory) != 0 {
			playerDidCollideWithAlien(player: secondBody.node as! SKSpriteNode, alien: firstBody.node as! SKSpriteNode)	}
		
	}

	func torpedoDidCollideWithAlien (torpedo:SKSpriteNode, alien:SKSpriteNode) {

		let explosion = SKEmitterNode(fileNamed: "Explosion2")!
		explosion.position = alien.position
		self.addChild(explosion)

//		self.run(SKAction.playSoundFileNamed("Explosion.mp3", waitForCompletion: false))

		torpedo.removeFromParent()
		alien.removeFromParent()
	
		self.run(SKAction.wait(forDuration: 2)) {
			explosion.removeFromParent()
		}

		score += 10
		
		scoreMultiplier = scoreMultiplier + 1
	}

	func playerDidCollideWithAlien (player:SKSpriteNode, alien:SKSpriteNode) {

		let explosion1 = SKEmitterNode(fileNamed: "Explosion1")!
		explosion1.position = player.position
		self.addChild(explosion1)
		
		let explosion2 = SKEmitterNode(fileNamed: "Explosion2")!
		explosion2.position = alien.position
		self.addChild(explosion2)
	
		alien.removeFromParent()
		
		lives = lives - 1
		
		checkLives()
		
		if lives == 0 {
		
			UserDefaults().set(score, forKey: "LastScore")
			expeiencePoints = expeiencePoints + score
			saveExperiencePoints()
		
			let explosionPlayer = SKEmitterNode(fileNamed: "Explosion1")!
			explosionPlayer.position = alien.position
			self.addChild(explosionPlayer)
		
			player.removeFromParent()
		
			scoreTimer.invalidate()
			alienTimer.invalidate()
			stageTimer.invalidate()
		
			disableShooting()
		
			gameOverTimer = Timer.scheduledTimer(timeInterval: alienSpeed, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)

			self.run(SKAction.wait(forDuration: 2)) {
			explosion1.removeFromParent()
			explosionPlayer.removeFromParent()

			}
		
			if score > UserDefaults().integer(forKey: "HighScore") {
				saveHighScore()
			}
		}
	}
	
	func saveExperiencePoints() {
	
		UserDefaults().set(expeiencePoints, forKey: "ExperiencePoints")
	
	}
	
	func saveHighScore() {
	
		UserDefaults().set(score, forKey: "HighScore")
		
	}
	
	func checkLives() {
	
		if lives == 0 {
			heart01.isHidden = true
			heart02.isHidden = true
			heart03.isHidden = true
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 1 {
			heart02.isHidden = true
			heart03.isHidden = true
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 2 {
			heart03.isHidden = true
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 3 {
			heart04.isHidden = true
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 4 {
			heart05.isHidden = true
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 5 {
			heart06.isHidden = true
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 6 {
			heart07.isHidden = true
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 7 {
			heart08.isHidden = true
			heart09.isHidden = true
		}
		
		if lives == 8 {
			heart09.isHidden = true
		}
		


	}
	
	
	
	
//palyer movement.............................

	override func didSimulatePhysics() {
	
		player.position.x = player.position.x + direction
	
		if player.position.x < 100 { player.position = CGPoint(x: 100, y: player.position.y)}
		if player.position.x > screenWidth - 100 { player.position = CGPoint(x: screenWidth - 100, y: player.position.y)}
	
	}

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
	
}


