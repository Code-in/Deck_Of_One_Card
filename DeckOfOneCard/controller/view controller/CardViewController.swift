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
    }
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        
        CardController.fetchCard() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            } // EoDQ
        }
    } // EoF
    
    
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
