# GithubRepositories

# DESCRIPTION

- Programming language: swift

- Architecture: MVVM + Coordinators 

- Interfaces: AutoLayout directly in the code

# IMPLEMENTATION

This application allows the user to view the repositories of a GitHub user. It consists of 3 screens:
1. GitHub user selection
2. Repositories list of the selected user
3. Details of a repository
 
![Simulator Screen Recording - iPhone 14 - 2023-05-23 at 20 03 48](https://github.com/mDaemi/Github-user-repository/assets/31176385/b424fe29-6ed4-48e1-9cdd-1903e3e0c78b)


# API

Documentation : https://developer.github.com/v3/repos/#list-user-repositories 
Route : https://api.github.com/users/{User}/repos


# Architecture

The application follows the MVVM (Model-View-ViewModel) architectural pattern, enhanced with the use of Coordinators. 
The architecture promotes separation of concerns and modularization of components, facilitating easier testing and scalability. 
Generics and protocols were utilized to separate all layers and allowing for independent testing of each component.

- Use of a generic "Bindable" class for the binding of the viewModel and the view:

<img width="438" alt="Screenshot 2022-08-09 at 21 53 51" src="https://user-images.githubusercontent.com/31176385/183749205-0518f71d-c5c5-4e99-8388-93359d35b137.png">

example of usage:

<img width="593" alt="Screenshot 2022-08-09 at 21 54 28" src="https://user-images.githubusercontent.com/31176385/183749344-c839fd1a-33a9-4c3f-ac24-c96b1fb243ac.png">


