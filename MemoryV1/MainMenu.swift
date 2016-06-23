//
//  MainMenu.swift
//  MemoryV1
//
//  Created by Teddy Marchildon on 6/17/16.
//  Copyright © 2016 Teddy Marchildon. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var playerTextField = UITextField(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width * 0.33 + 80, y: UIScreen.mainScreen().bounds.size.width * 0.35 + 180, width: 140, height: 40))
    var difficultyTextField = UITextField(frame: CGRect(x: UIScreen.mainScreen().bounds.size.width * 0.33 + 80, y: UIScreen.mainScreen().bounds.size.width * 0.35 + 250, width: 140, height: 40))
    let playerPickOptions = [GameModes.PlayerModes.Choose.rawValue, GameModes.PlayerModes.OnePlayer.rawValue, GameModes.PlayerModes.TwoPlayer.rawValue]
    let difficultyPickOptions = [GameModes.DifficultyModes.Choose.rawValue, GameModes.DifficultyModes.Regular.rawValue, GameModes.DifficultyModes.Hard.rawValue]
    var mainLabel: SKLabelNode!
    var toRecordScene: SKSpriteNode!
    var playButtonSprite: SKSpriteNode!
    var playButtonLabel: SKLabelNode!
    var modeLabel: SKLabelNode!
    var difficultyLabel: SKLabelNode!
    var recordLabel: SKLabelNode!
    
    var playerMode: GameModes.PlayerModes {
        if let text = playerTextField.text {
            switch text {
            case GameModes.PlayerModes.TwoPlayer.rawValue:
                return GameModes.PlayerModes.TwoPlayer
            default:
                return GameModes.PlayerModes.OnePlayer
            }
        } else {
            return GameModes.PlayerModes.OnePlayer
        }
    }
    
    var difficultyMode: GameModes.DifficultyModes {
        if let text = difficultyTextField.text {
            switch text {
            case GameModes.DifficultyModes.Hard.rawValue:
                return GameModes.DifficultyModes.Hard
            default:
                return GameModes.DifficultyModes.Regular
            }
        } else {
            return GameModes.DifficultyModes.Regular
        }
    }
    
    var cardsAndGameRegular: (cards: [SKSpriteNode], game: Game) = ([], Game())
    var cardsAndGameHard: (cards: [SKSpriteNode], game: Game) = ([], Game(difficulty: .Hard))
    var onePlayerScene: OnePlayerGameScene? = nil
    var twoPlayerScene: TwoPlayerGameScene? = nil
    var recordScene: HighscoresScene? = nil
    
    override func didMoveToView(view: SKView) {
        cardsAndGameRegular = LoadDataRegular.setUp()
        cardsAndGameHard = LoadDataHard.setUp()
        let playerPickerView: UIPickerView = UIPickerView()
        let difficultyPickerView: UIPickerView = UIPickerView()
        setTextField(playerTextField, inputView: playerPickerView)
        setTextField(difficultyTextField, inputView: difficultyPickerView)
        playerPickerView.tag = 1
        difficultyPickerView.tag = 2
        if let mainLabel = self.childNodeWithName("mainLabel") as? SKLabelNode, let modeLabel = self.childNodeWithName("modeLabel") as? SKLabelNode, let difficultyLabel = self.childNodeWithName("difficultyLabel") as? SKLabelNode, let playButtonSprite = self.childNodeWithName("playButtonSprite") as? SKSpriteNode, let toRecordLabel = self.childNodeWithName("recordsButtonSprite") as? SKSpriteNode {
            self.mainLabel = mainLabel
            self.modeLabel = modeLabel
            self.difficultyLabel = difficultyLabel
            self.toRecordScene = toRecordLabel
            self.playButtonSprite = playButtonSprite
            if let recordLabel = toRecordScene.childNodeWithName("recordsLabel") as? SKLabelNode, let playButtonLabel = playButtonSprite.childNodeWithName("playLabel") as? SKLabelNode {
                self.recordLabel = recordLabel
                self.playButtonLabel = playButtonLabel
            }
        }
        
        if let scene1 = OnePlayerGameScene(fileNamed:"OnePlayerGameScene") {
            scene1.scaleMode = .AspectFit
            self.onePlayerScene = scene1
        }
        
        if let scene2 = TwoPlayerGameScene(fileNamed:"TwoPlayerGameScene") {
            scene2.scaleMode = .AspectFit
            self.twoPlayerScene = scene2
        }
        
        if let recordScene = HighscoresScene(fileNamed: "HighscoresScene") {
            recordScene.scaleMode = .AspectFit
            self.recordScene = recordScene
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2 {
            return difficultyPickOptions.count
        } else {
            return playerPickOptions.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView.tag == 2 {
            return difficultyPickOptions[row]
        } else {
            return playerPickOptions[row]
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 2 {
            difficultyTextField.text = "\(difficultyPickOptions[row])"
        } else {
            playerTextField.text = "\(playerPickOptions[row])"
        }
        self.view?.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view?.endEditing(true)
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            if node == playButtonLabel || node == playButtonSprite {
                playButtonLabel.fontColor = .lightGrayColor()
                if playerMode == .TwoPlayer {
                    switch difficultyMode {
                    case .Hard:
                        twoPlayerScene?.cards = cardsAndGameHard.cards
                        twoPlayerScene?.game = cardsAndGameHard.game
                    default:
                        twoPlayerScene?.cards = cardsAndGameRegular.cards
                        twoPlayerScene?.game = cardsAndGameRegular.game
                    }
                    self.view?.presentScene(twoPlayerScene!, transition: SKTransition.pushWithDirection(.Left, duration: 0.5))
                } else {
                    switch difficultyMode {
                    case .Hard:
                        onePlayerScene?.cards = cardsAndGameHard.cards
                        onePlayerScene?.game = cardsAndGameHard.game
                    default:
                        onePlayerScene?.cards = cardsAndGameRegular.cards
                        onePlayerScene?.game = cardsAndGameRegular.game
                    }
                    self.view?.presentScene(onePlayerScene!, transition: SKTransition.pushWithDirection(.Left, duration: 0.5))
                }
                hideLabels()
            } else if node == recordLabel || node == toRecordScene {
                hideLabels()
                recordLabel.fontColor = .lightGrayColor()
                self.view?.presentScene(recordScene!, transition: SKTransition.pushWithDirection(.Left, duration: 0.5))
            }
        }
    }
    
    func hideLabels() {
        playerTextField.removeFromSuperview()
        difficultyTextField.removeFromSuperview()
    }
    
    func setTextField(field: UITextField, inputView: UIPickerView) {
        field.inputView = inputView
        field.font = UIFont.systemFontOfSize(20)
        field.borderStyle = UITextBorderStyle.RoundedRect
        field.delegate = self
        field.textAlignment = .Center
        field.textColor = UIColor(red: 0.0, green: 145/255.0, blue: 255/255.0, alpha: 1.0)
        field.text = "Choose..."
        inputView.dataSource = self
        inputView.delegate = self
        self.view?.addSubview(field)
    }
}
