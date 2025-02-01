# Examination System - SQL Server Database Project

## 📌 Project Overview
This project is a *comprehensive Examination System* designed for universities and educational institutions. 
It provides *automated exam creation, student assessment, and secure data management* using *SQL Server. 
The system ensures **data integrity, auditing, and security* while providing a smooth experience for students, instructors, and administrators.

## 🚀 Features
### ✅ *Core Functionalities*
- *Exam Generation:* Instructors create exams by specifying a *course name, number of True/False, and MCQ questions.
  The system **randomly selects questions* from the course's question bank.
- *Student Exam Submission:* Students take exams by providing answers, which are stored securely in the database.
- *Auto-Grading & Correction:* The system automatically corrects answers and calculates the *final grade*.
- *Secure Access Control:* Role-based access for *admins, instructors, and students*
### 🔒 *Security & Auditing*
- *Audit Logs:* Track all changes to *exams, student answers, and question modifications*.
- *Error Logging System:* A dedicated Error_Log table records any errors for debugging.
- *Triggers & Validation:* Prevent unauthorized inserts, updates, and deletions in critical tables.
- *Optimized Performance:* *Non-clustered indexes* on key fields improve database query performance.
- *Question Types Management:* We use a *discriminator* to differentiate between different question types.

## 🛠 *Technical Implementation*
### *📌 Database Schema*
The database consists of the following key tables:
- *Students, Instructors, Courses, Exams, Questions, Answers, and Departments.*
- Relationship-based design ensures *data consistency and integrity*.
### *📌 Stored Procedures*
The system is built on SQL Server *stored procedures* for efficient data management. Key procedures include:
1. *Exam Generation* – Randomly selects questions based on the course and instructor inputs.
2. *Exam Answers Submission* – Students submit answers, which are stored securely.
3. *Exam Correction* – Instructors trigger *auto-grading*, calculating final scores.
4. *Student Reports* – Retrieve *exam history, grades, and available exams*.
5. *Instructor Reports* – View *assigned courses, generated exams, and student performance*.

## 📊 *System Workflow*
1️⃣ *Instructor Logs In* → Generates an exam with random questions.
2️⃣ *Student Takes the Exam* → Submits answers which are stored securely.
3️⃣ *Exam Auto-Corrects* → The system evaluates and stores the student’s final grade.
4️⃣ *Students & Instructors Retrieve Reports* → View grades, exam history, and student performance.

## 📜 *Usage Examples*
- *Students can:*
  - View available exams.
  - Submit answers.
  - Check grades for specific exams or view all past grades.
- *Instructors can:*
  - Generate exams with a random selection of questions.
  - Correct exams and assign grades.
  - Retrieve course and student performance reports.

  ## 📌 Conclusion
This *Examination System* is a *powerful, secure, and efficient solution* for managing university exams. 
By integrating *SQL Server stored procedures, triggers, and auditing mechanisms, we ensure **data security, integrity, and optimized performance*.
