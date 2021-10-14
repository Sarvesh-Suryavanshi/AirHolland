# AirHolland

Assignment Task Overview

Assignment Name - AirHolland
Developer - Sarvesh Suryavanshi
Contact No - +91 9579577091
Email ID - sarvesh.suryavanshi@gmail.com

Task Overview -
1. The project created here is well structured with files hierarchy which is easy to navigate through.
2. Project files are well documented for better readability
3. The project follows MVVM Design pattern and SOLID Programming Principles
4. Closures and Generics concept are used while designing the Network Class along
with Result enum provided by Apple. ( This can be further enhanced using
Combine )
5. The project uses Core Data for persisting data.
6. Entity folder holds the Roaster Entity which is
customised to work as Codable as well as a ManagedObject. You can find custom implementation of Decoder and Encoder here.
7. We have added pull to refresh functionally as requested.
8. There are lot of common extensions declared in AppExtension file to provide convenience.
9. We have provided loading Indicator while the API is being fetched from backend.
10.Service response is segregated based on Date. Each section represents a Date and contains duties to be completed on that day. Also data is sorted in ascending order based on date for better readability.
11.Minute details like Layover time duration is also being calculated
12.Roaster cell is customised based on different dutyID’s
13.Displaying limited data on Detail Screen as the Home Screen itself is quite descriptive.

Note -
1. DutyIDs have been extracted from current api
response. Any change in api with additional duties being added to response will need changes to the codebase.
2. All response parameters are non optional as observed. Any non optional value coming from service will return decoding error.
3. All information on the roaster is being displayed to end-user as it is important and relevant
