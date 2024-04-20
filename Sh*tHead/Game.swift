//
//  Game.swift
//  Sh*tHead
//
//  Created by Or Zino on 24/04/2024.
//

import SwiftUI

struct Game: View {
    var body: some View {

            VStack() {
  
                NavigationView {
                    
                    ZStack{

                        Image("Background")
                            VStack {
                                NavigationLink(destination: ContentView()) {
                                    Image("logo")
                                }.navigationBarTitle("")
                                .navigationBarHidden(true)
                            }
                        
                        
                        }
                
//                Button(action: {
//                    
//                    
//                }) {
//                    Image("logo")
//                }
            }
                
        }
    }
}

#Preview {
    Game()
}
