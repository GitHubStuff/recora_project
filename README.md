# recora

A Flutter project demo

## Task

Your task for this technical assessment is the create a fully functional app using TMDB
API (<https://developers.themoviedb.org/3/getting-started/introduction>). You have free
range with the content of the app but the only requirements are:

- There must be at least 2 screens
- You must make at least 2 API calls

An example app would be to display a list of popular movies and show a details screen
when a row is tapped.

Another example would be a search for movies and show a details screen when a row is
tapped.

The focus of this exercise is on how you approach the problem and structure your code to
make it testable, maintainable, and scalable. We also are looking to see what kind of
architecture, libraries, and tools you are comfortable working with. No need to spend
more than 4 hours on this exercise. This assessment is intentionally open-ended, so feel
free to be creative as a way to showcase your strengths as an application engineer.
To submit, either send a link to a public Github repo or a zip file of the project to
john@recorahealth.com.

## Assumptions

- Minimal Test-Driven-Design(TDD): I'm a big user/fan of TDD but this has limited TDD design to focus on the implementation, and because the requirements/scope were narrow enough the initial overhead/time using TDD was not required. The are some tests, but not as many as typical larger scoped project would have.
- Localization: There is none. This is an **English Only** implementation, without typical allowence for localization. As a compromise: most text is wrapped in *Text* Widgets at the bottom/end of files so the hard-coded text can be changed without *line by line* searching.
- Constants: There is a *constants.dart* file that has values used across multiple files, otherwise single-use constant values are defined at the top of .dart file they are used in. I use constants because they add to the self-documenting approach I use.
- Hardware: This app is designed/runs on iPhone/Android phones-simulators.
- Error Handling: Minimal, but effective for the scope of the app.
- Search Validation: None, it is assume text is from the keyboard and nothing in place to prefect text injection using copy/paste.

## Product Details

There are three(3) screens:

- Splash Screen
- List/Search Screen
- Detail Screen

I make three(3) api calls:

- Call for popular movies and details
- Call used for searches
- Call to return poster art

I used the BLoC design pattern where events trigger state changes which update the UI and await for more events. There is caches used for network calls and poster art so the app never feels like it has frozen

I used a Modular pattern for navigation and dependency injection.

As the use enters search text, no network call is made until the user has paused typing 1.5 seconds. This prevents a flood of network backlog that would happen by triggering a search on every character typed. It is assumed after search if the 'Search' field is empty the app re-loads popular movies.

Error handling is limited to Network errors, and the response is the same. A simple error message and *retry* option.

There is not filtering/validation on search input. No protection from code injection or non-english-keyboard strokes. *In limited integration testing it usually returned no matches*.

The UX is simple and very univeral, and runs smooth on Android/iOS.

### Respectfully Submitted

#### Steven Smith

Please feel free to provide feedback. *Even if you don't hire me, I'd welcome the chance to learn!*
