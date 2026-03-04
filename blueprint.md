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

*   **Account Screen:** Users can view their account information and log out.

## Current Plan

I have just completed a major refactoring of the user authentication flow. The following changes have been implemented:

*   **Welcome Screen:** A new welcome screen has been created to replace the previous role selection screen.
*   **Streamlined Registration:** The registration process has been simplified by passing the user's role as a parameter.
*   **Improved Navigation:** The login screen has been updated to clear the navigation stack and prevent users from navigating back to the login screen after logging out.
