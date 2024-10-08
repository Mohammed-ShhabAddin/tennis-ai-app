//Auth feature documentation

//general widget 
//**
//Curved Shape Widget: Displays a curved design at the top of the screen,
 
// */

 // * Signup Screen
 /*
  This screen provides a user interface for signing up.
   It contains text fields for entering a name, email, and password, 
   and a submit button that calls the `signup` method in the `AuthRepository`.

   The `signup` method creates a new user with the provided name, email, and password.

   The `signup` method returns a `User` object if the user is successfully created,
   or throws an exception if the user creation fails.

   The `signup` method is defined in the `AuthRepository` class, which you can use  
    to create a new user with Firebase Authentication.

   Bloc Consumer: Manages the signup logic with AuthCubit,
    showing loading indicators and handling success/error states.
   */
  
  //* Login Screen
  /*
  This screen provides a user interface for logging in. 
  It contains text fields for entering an email and password,
  and a submit button that calls the `login` method in the `AuthRepository`.  

  The `login` method signs in the user with the provided email and password.

  The `login` method returns a `User` object if the user is successfully logged in,
  or throws an exception if the login fails.

  The `login` method is defined in the `AuthRepository` class, which you can use
  to sign in with Firebase Authentication.

  Bloc Consumer: Manages the login logic with AuthCubit,

  */

// * welcome screen
/*
  This screen provides a user interface for welcoming the user
  providing navigation options to the sign-up and login screens. 
*/    