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
            
            VStack {
                Spacer()
                VStack {
                    Text("Timer: 0000")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    HStack{
                        Text("Goal: 50")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .background(.indigo)
                            .cornerRadius(25)
                        
                        Text("Current: 20")
                        //.font(.title)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .background(.indigo)
                            .cornerRadius(25)
                        
                    }
                    .padding(20)
                }
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        
                        ZStack {
                            
                            //  Create buttons                      
                            Circle()
                                .foregroundColor(.cyan)
                                .frame(width: geometry.size.width/3 - 15, 
                                       height:geometry.size.width/3 - 15)
                            
                            if i != 4 {
                                // Loops through and puts framed number on button/circle                        
                                Image(systemName: setup[i])
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white) 
                            } else {
                                Image(systemName: operators[0])
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.indigo) 
                            }
                            
                        } // ZStack closing bracket
                        
                    } // ForEach closing
                    
                } // LazyVGrid closing
                
                .padding(.top)
                
                Text("Score: 000")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
            } // VStack    
            
        }
    }
}

