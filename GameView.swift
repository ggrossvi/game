import SwiftUI

struct GameView: View {
    
    let columns:[GridItem] =  [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible())]
    
    let operators: [String] = ["plus.circle", "minus.circle", "multiply.circle"]
    
    //    Create array of random numbers
    
    @State private var setup: [String] = ["\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square",
                                          "plus.circle",
                                          "\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square",
                                          "\(Int.random(in:1...9)).square"
                                        ]
    var body: some View {
        
        GeometryReader{ geometry in 
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(0..<9) { i in
                    
                    ZStack {
                        
                        //  Create buttons                      
                        Circle()
                            .foregroundColor(.cyan)
                            .frame(width: geometry.size.width/3 - 15, 
                               height:geometry.size.height/3 - 15)
                        
                        // Loops through and puts framed number on button/circle                        
                        Image(systemName: setup[i])
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white) 
                            
                    }
                    
                    
                    
                    
                }
            }
        }
    }
}
