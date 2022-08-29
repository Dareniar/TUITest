# TUITest

## Project Architecture

The test project is written in MVVM design pattern using combination of SwiftUI and Combine. All UI-related logic is located in _UI_ folder. All logic for finding the cheapest route is located in _Cheapest Route_ folder. All netwoorking and response models are located in _API_ folder. Application supports dark mode, system fonts and supports iPad and Mac with M-chips.

## Cheapest Route

I've chosen Dijkstra algorithm to find the cheapest route between two cities. In order to support it, I've implemented some classes which are needed for constructing Graph with destination vertices where weight is the price of route. After that the cheapest path in graph is calculated using combination of Dijkstra algorithm and priority queue. To avoid complex logic in ViewModel class, I've decided to implement separate class for finding the route - _RouteFinder_, which takes data from ViewModel and generates graph using that data. 
