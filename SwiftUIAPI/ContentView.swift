//
//  ContentView.swift
//  SwiftUIAPI
//
//  Created by Felipe Ramirez Vargas on 27/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var results = [CatFact]()
    
    var body: some View {
        List(results, id: \._id){ item in
            VStack(alignment: .leading){
                Text(item.text)
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData(){
        guard let url = URL(string: "https://cat-fact.herokuapp.com/facts") else {
            print("Your API endpoint is invalid")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([CatFact].self, from: data){
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
