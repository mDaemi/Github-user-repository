# GithubRepositories

# DESCRIPTION

This application allows the user to view the repositories of a GitHub user. It consists of 3 screens:
1. GitHub user selection:
2. Repositories list of the selected user:
3. Details of a repository
 
# IMPLEMENTATION

1. GitHub user selection :
  ○ Text field
  ○ Validation button
  ○ Selected user informations

(https://user-images.githubusercontent.com/31176385/183749702-c4ec0ffb-8c6b-453d-b4a3-e4ceba2dd055.png)

2. Repositories list of the selected user :
  ○ Title
  ○ Back button
  ○ List of repositories

(https://user-images.githubusercontent.com/31176385/183746152-e5517b02-25de-4a0f-85a7-578dc46d5e7c.png)

3. Details of a repository :
  ○ Title
  ○ Back to list button
  ○ Image of the repository
  ○ Repository description

(https://user-images.githubusercontent.com/31176385/183749734-c48b9f9a-9a62-47bb-83ef-ce89f79b1b5b.png)

# API

Documentation : https://developer.github.com/v3/repos/#list-user-repositories Route : https://api.github.com/users/{User}/repos

# Architecture

I used MVVM architecture for my application.
For example, if we check "RepositoryListTableViewController" implementation, we can see 2 classes :
1. RepositoryListTableViewController: a view which owns RepositoryListTableViewControllerViewModel.
2. RepositoryListTableViewControllerViewModel: it provides the link between the View and the Model.

I found this architecture quite good because thanks to it, I can easily test the business logic.
The whole architecture is designed to make each component as independent as possible. I used generics and protocols to separate all of layers. For testing, each component can be tested independently.

- Use of a generic "Bindable" class for the binding of the viewModel and the view:

<img width="438" alt="Screenshot 2022-08-09 at 21 53 51" src="https://user-images.githubusercontent.com/31176385/183749205-0518f71d-c5c5-4e99-8388-93359d35b137.png">

example of usage:

<img width="593" alt="Screenshot 2022-08-09 at 21 54 28" src="https://user-images.githubusercontent.com/31176385/183749344-c839fd1a-33a9-4c3f-ac24-c96b1fb243ac.png">


