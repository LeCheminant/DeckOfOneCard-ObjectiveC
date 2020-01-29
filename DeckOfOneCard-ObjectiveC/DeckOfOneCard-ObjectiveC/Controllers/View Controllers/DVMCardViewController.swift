//
//  DVMCardViewController.swift
//  DeckOfOneCard-ObjectiveC
//
//  Created by Jacob LeCheminant on 1/28/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

import Foundation
import UIKit

class DVMCardViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet var suitLabel: UILabel!
    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var drawCardButton: UIButton!
    
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCards()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Action
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        print("Hi")
        self.fetchCards()
    }
    
    
    func fetchCards() {
        DVMCardController.drawANewCard(1) { (cards) in
            
            if let cards = cards {
                DVMCardController.fetchCardImage(cards[0]) { (cardImage) in
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }
    
    func updateViews(card: DVMCard, image: UIImage) {
        self.cardImageView.image = image
        self.suitLabel.text = card.suit
    }
}
