import SwiftUI

class Score: ObservableObject {
    @Published var score: Int = 0
}

struct GameView: View {
    
    let columns:[GridItem] =  [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible())]
    
    let operators: [String] = ["plus.circle", "minus.circle", "multiply.circle"]
    
    
    @State private var operatorID: Int = 0
    @State private var currentValue: Int = 0
    @State private var goalValue: Int = Int.random(in: 20...40)
    @State private var isGameOver = false
    @State private var timeRemaining = 30 
    let timer  = Timer.publish(every:1,  on: .main, in: .common).autoconnect()
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
    
    @ObservedObject var score = Score()
    
    var body: some View {
        
        GeometryReader{ geometry in 
            
            VStack {
                Spacer()
                VStack {
                    Text("Timer: \(timeRemaining)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .onReceive(timer) {_ in 
                            updateTimer()
                        }
                    
                    HStack{
                        Text("Goal: \(goalValue)")
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
                            winCondition()
                        }
                        
                    } // ForEach closing
                    
                } // LazyVGrid closing
                
                .padding(.top)
                
                Text("Score: \(score.score)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Spacer()
                
            } // VStack    
            
        }
    }
    
    func countRemainingNumbers() {
        var count = 0
        for i in setup {
            if i.isEmpty {
                count += 1
            }
            if count == 0 && currentValue != goalValue {
                 timeRemaining = 0
            }
                
        }
    }
    
    
    func winCondition() {
        if currentValue == goalValue {
            score.score += 1
            timeRemaining += 5
            goalValue = Int.random(in: 20...40)
            currentValue = 0
            operatorID = 0
        
        setup = ["\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square",
                   "plus.circle",
                   "\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square",
                   "\(Int.random(in:1...9)).square"
        ]
            
        }
    }
    
    func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else if timeRemaining <= 0 {
            isGameOver = true
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

