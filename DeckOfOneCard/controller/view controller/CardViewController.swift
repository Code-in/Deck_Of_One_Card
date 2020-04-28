//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadCard()
    }
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        LoadCard()
    } // EoF
    
    func LoadCard() {
        CardController.fetchCard() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    let value = card.value.lowercased()
                    let suit = card.suit.lowercased()
                    self?.cardLabel.text = "\(value.capitalized) of \(suit.capitalized)"
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            } // EoDQ
        }
    }
    
    
    func fetchImageAndUpdateViews(for card: Card) {
        
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cardImage.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }  // EoF
    
    
}
