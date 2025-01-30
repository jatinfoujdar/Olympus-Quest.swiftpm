import Foundation

@MainActor
class Game: ObservableObject{
    private var allQuestions : [Question] = []
    
    var filterQuestions: [Question] = []
    
    private func decodeQuestions(){
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json"){
            do{
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestions = try decoder.decode([Question].self, from: data)
                filterQuestions = allQuestions
            }catch{
                print("Error Decoding Json data: \(error)")
            }
        }
    }
}
