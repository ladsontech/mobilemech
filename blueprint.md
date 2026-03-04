# Project Blueprint

## Overview

This document outlines the architecture, features, and implementation details of the MDER Flutter application. It serves as a single source of truth for the project's design and development.

## Style and Design

The application follows the Material Design 3 guidelines, with a modern and visually appealing interface. The color scheme is based on a seed color of `0xFF34495E`, and the typography uses the Lato and Roboto fonts from the `google_fonts` package. The UI is designed to be mobile-responsive and accessible to all users.

## Features

### Authentication

*   **Login:** Users can log in with their email and password.
*   **Registration:** New users can register as either a "Vehicle Owner" or a "Mechanic."
*   **Role-Based Routing:** After logging in, users are routed to the appropriate home screen based on their role.
*   **Welcome Screen:** A new welcome screen has been implemented to provide a clear entry point for unauthenticated users.

### User Management

*   **User Profile Model:** A `UserProfile` model has been created to provide a structured and type-safe way to manage user data.
*   **User Service:** A `UserService` has been developed to handle all user-related data operations, including creating, reading, and updating user profiles in Firestore.
*   **Account Screen:** Users can view their complete user profile and edit their information.

## Current Plan

I have just completed a major refactoring of the user profile and authentication system. The following changes have been implemented:

*   **Structured User Data:** I created a `UserProfile` model to ensure that all user data is structured and type-safe.
*   **Dedicated User Service:** I developed a `UserService` to handle all user-related data operations, which properly separates data management from other parts of your app.
*   **Enhanced Account Screen:** The Account Screen now shows the complete user profile and allows users to easily edit their information.
*   **Improved Registration:** The registration process now uses the new `UserService`, making the system more robust and scalable.
