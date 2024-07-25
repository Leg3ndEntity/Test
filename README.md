# Library Database Management App

## Overview

This project is a simple FileMaker application designed to gain knowledge in database management. The project involves creating a database for a library system where users can borrow books, keep them for a period, and then return them.

## Project Description

### Entities and Relationships

The project models three main entities:
- **User**
- **Book**
- **Rental**

The `Rental` entity is a combination of a `User` and a `Book`. The primary keys for these entities are:
- **User:** `idCode`
- **Book:** `serialCode`

These keys help in identifying the `Rental` by using the `idCode` of the person who borrowed the book and the `serialCode` of the book.

### Attributes

The attributes of each entity are as follows:
- **User:** `idCode`, `name`, `email`, etc.
- **Book:** `serialCode`, `title`, `author`, etc.
- **Rental:** `idCode` (User), `serialCode` (Book), `rentalDate`, `returnDate`, etc.

### Database Creation

1. **Database Design:** Defined the entities and their attributes.
2. **Database Implementation:** Created the database and populated it with initial instances for testing purposes.
3. **Server Upload:** Uploaded the database to the academy server.

### Application Development

The application was developed to interact with the server using JSON files as a bridge. It provides the following functionalities:
- Display a list of users and books from the database.
- Add new users and books.
- Remove existing users and books.

### Usage

1. **Running the App:** Launch the app to see the list of users and books.
2. **Adding Instances:** Use the interface to add new users or books.
3. **Removing Instances:** Select and remove users or books as needed.
