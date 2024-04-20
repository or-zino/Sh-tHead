//
//  Test.swift
//  Sh*tHead
//
//  Created by Or Zino on 25/04/2024.
//

import SwiftUI

struct Test: View {
    @State private var data: String = "Loading..."
    
    var body: some View {
        Text(data)
                    .onAppear {
                        Task {
                            do {
                                // Simulating a network request that takes 2 seconds
                                let result = try await fetchData()
                                data = result
                            } catch {
                                data = "Error fetching data"
                            }
                        }
                    }
    }
    
    func fetchData() async throws -> String {
            // Simulate a network request that takes 2 seconds
            await Task.sleep(2 * 1_000_000_000) // 2 seconds in nanoseconds
            return "Data loaded successfully"
        }
}

#Preview {
    Test()
}
