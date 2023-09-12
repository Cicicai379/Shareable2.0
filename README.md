# Shareable app cis

## Important Things (read before you do anything)
1. Work in xcworkspace NOT in xcodeproj (pain)
2. if you encounter problems and you don't want to debug for 3 hours (and you are lazy), use chatgpt/poe/google
3. DON'T delete the comments, they marks to-dos/incompleted functions/useful instructions
4. Firebase is not setup yet, don't do it (you don't have my account)
5. If you encounter problems with pods:
    1. download cocoapods
    2. go to your terminal 
    3. cd (your project route)
    4. pod init
    5. pod install
    6. Having errors == message me
6.make sure that the colors for all UIs are automatically adaptable to both dark and light mode (search up how to do that, it'seasy)

### Less important things
1. feel free to add any comment/content in this file, especially solutions to bugs
2. command - shift - o to search the file that you want to edit in the project

 
## Resources
1. Basic Structure built following this tutorial (not quite useful, unless you want to watch a 10 hrs long one): [Link to tutorial](https://www.youtube.com/watch?v=BcsoBVakrTM&list=PL5PR3UyfTWvfhKNQkT3Wgq6QIIWRJyxM3&index=9)
    **this tutorial is not complete, purchasing the whole thing is 99usd **
2. Setting up Github: [Link](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)



## LOGS
- jun 13: followed tutorial part 1-9
  1. debug_profileViewController: extra space under collectionView --> solved by resetting the view in the storyboard
- jun 16: tutorial 9-16
  1. debug_HomeViewController: transparent tap bar background --> solved by setting translucent property in storyboard

## TODOS
### Graphic design
- currently need:
  1. Logo (app icon)
  2. Color theme
- Optional (there are system default assets for use):
  1. Icons
  2. Navigation bar icons
  
### LoginView Controller
- Email verification
- Log in with username 
  
### Register Controller
- Check new username not exist + format
- Email verification
- Check password format
    
### Other
- A bunch of other stuff are not at all workable, needed more functions built.
- The layout referred to instagram, changes are needed
