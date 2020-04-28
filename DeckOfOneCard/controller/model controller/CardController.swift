//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Pete Parks on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit.UIImage

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping(Result <Card, CardError>) -> Void) {
        guard let finalURL = self.baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                // Thrown an error from the URLSession
                return completion(.failure(.thrownError(error)))
            }
            // Failed to get th data from URLSession
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                if let card = topLevelObject.cards.first {
                    return completion(.success(card))
                } else {
                    return completion(.failure(.noData))
                }
            } catch let decodingError {
                return completion(.failure(.thrownError(decodingError)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping(Result<UIImage, CardError>) -> Void) {
        let cardImageURL = card.image
        
        URLSession.shared.dataTask(with: cardImageURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
            
        }.resume()
    } // EoF
    
}  // EoC


