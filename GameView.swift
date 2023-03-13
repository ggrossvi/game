import SwiftUI

struct GameView: View {
    
    let columns:[GridItem] =  [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible())]
    
    let operators: [String] = ["plus.circle", "minus.circle", "multiply.circle"]
    
    
    @State private var operatorID: Int = 0
    @State private var currentValue: Int = 0
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
                        
                        Text("Current: \(currentValue)")
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
                                Image(systemName: operators[operatorID])
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.indigo) 
                                    .onTapGesture {
                                        selectOperator()
                                    }
                            }
                            
                        } // ZStack closing bracket
                        .onTapGesture {
                            let haptic = UIImpactFeedbackGenerator(style: .rigid)
                            haptic.impactOccurred()
                            let numberLabel = setup[i]
                            let numberValue = numberLabel.first?.wholeNumberValue
                            
                            performOperation(numberValue)
                        }
                        
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
    
    func performOperation (_ numberValue: Int?) {
        if operatorID == 0 {
            currentValue += numberValue!
        } else if operatorID == 1 {
            currentValue -= numberValue!
        } else if operatorID == 2 {
            currentValue = currentValue * numberValue! // finished at 24:12
        }
    }
    
    func selectOperator() {
        let haptic = UIImpactFeedbackGenerator(style: .rigid)
        haptic.impactOccurred()
        operatorID += 1
        if operatorID > 2 {
            operatorID = 0
        }
    }
}

