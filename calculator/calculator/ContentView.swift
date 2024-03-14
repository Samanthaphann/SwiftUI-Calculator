//
//  ContentView.swift
//  calculator
//
//  Created by StudentAM on 3/1/24.
//

import SwiftUI


struct ContentView: View {
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    @State private var numberInput: String = "0"
    @State private var num1: String = "0"
    @State private var num2: String = "0"
    @State private var operation: String = ""

    var body: some View {
        ZStack {
            //make the background black
            Color.black
                .ignoresSafeArea()
            VStack {
                //makes the number inputted appear on the right side
            Spacer()
                HStack{
                    Spacer()
                    Text("\(numberInput)")
                    //makes text white
                        .foregroundColor(.white)
                    //aligns text to right
                        .multilineTextAlignment(.trailing)
                    //changes size of font
                        .font(.system(size: 80))
                    //padding for number input
                        .padding([.top,.bottom], 10)
                        .padding(.horizontal, 35)
                }
                //for each loop so it will take everything from numsAndOperations
                ForEach(numsAndOperations.indices, id: \.self) { row in
                        HStack{
                            //goes over each element in current row
                            ForEach(numsAndOperations[row], id: \.self) { char in
                                //takes all of the operations
                                if char == "÷" || char == "x" || char == "-" || char == "+" || char == "="{
                                    Button(action: {
                                        //if button is pressed it inputs the action of the operations
                                        if char == "+" || char == "-" || char == "÷" || char == "x"{
                                            //sets value of num1
                                            num1 = numberInput
                                            //corresponds operation
                                            operation = char
                                            //sets the numberInput to zero
                                            numberInput = "0"
                                        }
                                        else{
                                            if operation == "+" {
                                                num2 = numberInput
                                                //converts value to Double
                                                if let number1 = Double(num1), let number2 = Double(num2){
                                                    //adds both inputs
                                                    let result = number1 + number2
                                                    //lets the answer appear on the numberInput
                                                    numberInput = String(Double(result))
                                                }
                                                //allows for decimals to be added
                                                else if num1.contains(".") || num2.contains("."){
                                                    if let number1 = Double(num1), let number2 = Double(num2){
                                                        let result = number1 + number2
                                                        numberInput = String(Double(result))
                                                    }
                                                }
                                                
                                            } else if operation == "-"{
                                                //if the operation is a -
                                                num2 = numberInput
                                                //converts value to double
                                                if let number1 = Double(num1), let number2 = Double(numberInput) {
                                                    //subtracts inputs
                                                    let result = number1 - number2
                                                    //if its a whole number, it doesn't show the decimal
                                                    if String(result).contains(".0"){
                                                        numberInput = String(Int(result))
                                                    } else {
                                                        //shows result
                                                        numberInput = String(result)
                                                    }
                                                }
                                            } else if operation == "x"{
                                                num2 = numberInput
                                                //converts value to double
                                                if let number1 = Double(num1), let number2 = Double(numberInput) {
                                                    //multiplies inputs
                                                    let result = number1 * number2
                                                    //if its a whole number, it doesn't show the decimal
                                                    if String(result).contains(".0"){
                                                        numberInput = String(Int(result))
                                                    } else {
                                                        //shows result
                                                        numberInput = String(result)
                                                    }
                                                }
                                            }else if operation == "÷" {
                                                num2 = numberInput
                                                if let number1 = Double(num1), let number2 = Double(numberInput) {
                                                    if number2 != 0 {
                                                        let result = number1 / number2
                                                        //ifs it isn't infinite, it appears the result. (can't divide by 0)
                                                        if result.isFinite {
                                                            numberInput = String(result)
                                                        } else {
                                                            //show error if not finite
                                                            numberInput = "Error"
                                                        }
                                                    } else {
                                                        numberInput = "Error"
                                                    }
                                                }
                                            }
                                            //sets the number back to 0
                                            num1 = "0"
                                            num2 = "0"
                                            operation = ""
                                        }
                                    }, label: {
                                        Text("\(char)")
                                        //change the color and font color when operation is pressed
                                            .foregroundColor(operation == char ? Color.orange : Color.white)
                                            .frame(width: 80, height: 80)
                                            .background(operation == char ? Color.white : Color.orange)
                                            .cornerRadius(100)
                                            .font(.system(size: 24))
                                    })
                                } else if char == "AC" || char == "C" {
                                    //guides to the clear function
                                    Button(action: clear, label: {
                                        Text("\(numberInput == "0" ? char : "C")")
                                            .frame(width: 80, height: 80)
                                            .background(Color(red:211/255, green: 211/255, blue:211/255))
                                            .cornerRadius(100)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24))
                                    })
                                } else if char == "+/-"{
                                    //guides to the yoggle function
                                    Button(action: {toggle()}, label: {
                                        Text("\(char)")
                                            .frame(width: 80, height: 80)
                                            .background(Color(red:211/255, green: 211/255, blue:211/255))
                                            .cornerRadius(100)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24))
                                    })
                                } else if char == "%"{
                                    //gudes to the percent function
                                    Button(action: {percent()}, label: {
                                        Text("\(char)")
                                            .frame(width: 80, height: 80)
                                            .background(Color(red:211/255, green: 211/255, blue:211/255))
                                            .cornerRadius(100)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24))
                                    })
                                } else if char == "0"{
                                    //guides to te change display function
                                    Button(action: {changeDisplay(number: char)}, label: {
                                        Text("\(char)")
                                            .frame(width: 165, height: 80)
                                            .background(Color(red: 0.6078, green: 0.6078, blue: 0.6078))
                                            .cornerRadius(100)
                                            .multilineTextAlignment(.trailing)
                                            .foregroundColor(.white)
                                            .font(.system(size: 24))
                                    })
                                }
                                else if char == "."{
                                    //guides to te change display function
                                    Button(action: {changeDisplay(number: char)}, label: {
                                        Text("\(char)")
                                            .frame(width: 80, height: 80)
                                            .background(Color(red: 0.6078, green: 0.6078, blue: 0.6078))
                                            .cornerRadius(100)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.trailing)
                                            .font(.system(size: 24))
                                    })
                                } else{
                                    Button(action: {changeDisplay(number:char)}, label: {
                                        //guides to te change display function
                                        Text("\(char)")
                                            .frame(width: 80, height: 80)
                                            .background(Color(red: 0.6078, green: 0.6078, blue: 0.6078))
                                            .cornerRadius(100)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.trailing)
                                            .font(.system(size: 24))
                                    })
                                }
                        }
                    }
                }
            }
        }
    }
    func clear(){
        //sets the number back to 0 when clear button is clicked
        numberInput = "0"
    }
    
    func changeDisplay(number: String) {
        //if the numberInput is 0, it stores the 0=
        if numberInput == "0"{
            numberInput = number
        } else {
            // Append the input number to the existing numberInput
            numberInput += number
        }
    }


    func toggle(){
        if let value = Double(numberInput) {
            numberInput = String(-value)
        }
    }

    func percent(){
        if let value = Double(numberInput) {
            numberInput = String(value / 100)
        }
    }

    func handleOperator() {
        if operation == "+" {
            // Perform addition operation
            if let number1 = Double(num1), let number2 = Double(numberInput) {
                let result = number1 + number2
                // Update numberInput with the result
                numberInput = String(result)
            }
            // Reset num1 and operation for future calculations
            num1 = "0"
            operation = ""
        }
    }

    
//    func add(num1:String, num2:String) -> String {
//        if let number1 = Int(num1), let number2 = Int(num2){
//            let answer = number1 + number2
//            return String(answer)
//        }
//        else if num1.contains(".") || num2.contains("."){
//                if let number1 = Double(num1), let number2 = Double(num2){
//                    let answer = number1 + number2
//                    return String(answer)
//                }
//        }
//        return "Error"
//    }
}


#Preview {
    ContentView()
}
