//
//  PowerUpsVM.swift
//  TibberPowerUpsChallance
//
//  Created by Waleerat Gottlieb on 2022-03-02.
//

import Foundation
import Apollo

class PowerUpsVM: ObservableObject {
    @Published var powerUpsItems: [Response.PowerUpModel] = []
    @Published var isError: Bool = false
    @Published var selectedRow: Response.PowerUpModel?
    
   
    
    init() {
        fetch()
    }
    
    func fetch() {
       Network.share.apollo.fetch(query: PowerUpQueryQuery()) { result in
           switch result {
            case .success(let graphQLResult) :
               if let items = graphQLResult.data?.assignmentData {
                   for item in items {
                       self.powerUpsItems.append(Response.PowerUpModel(item.resultMap as NSDictionary))
                   }
               } else if let errors = graphQLResult.errors {
                       print("GraphQL errors \(errors)")
               }
            case .failure(let error) :
                print("Failure! Error : \(error)")
            }
        }
    }
    
    func getPowerUpItems(isConnected: Bool) -> [Response.PowerUpModel]{
        return self.powerUpsItems.filter{ $0.connected == isConnected }
    }
}
