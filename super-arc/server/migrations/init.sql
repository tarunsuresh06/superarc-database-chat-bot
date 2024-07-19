-- Create the 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    major VARCHAR(50)
);

-- Create the 'courses' table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    instructor VARCHAR(100),
    credits INT,
    department VARCHAR(50),
    semester VARCHAR(20)
);

-- Create the 'enrollments' table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert 10 rows into the 'students' table
INSERT INTO students (student_id, first_name, last_name, date_of_birth, email, major)
VALUES
    (1, 'John', 'Doe', '2000-05-15', 'john.doe@email.com', 'Computer Science'),
    (2, 'Jane', 'Smith', '2001-02-20', 'jane.smith@email.com', 'Biology'),
    (3, 'Michael', 'Johnson', '1999-11-10', 'michael.johnson@email.com', 'Mathematics'),
    (4, 'Emily', 'Brown', '2002-07-30', 'emily.brown@email.com', 'Psychology'),
    (5, 'David', 'Lee', '2000-09-05', 'david.lee@email.com', 'Engineering'),
    (6, 'Sarah', 'Wilson', '2001-04-12', 'sarah.wilson@email.com', 'Chemistry'),
    (7, 'Robert', 'Taylor', '1999-08-25', 'robert.taylor@email.com', 'Physics'),
    (8, 'Lisa', 'Anderson', '2002-01-18', 'lisa.anderson@email.com', 'English'),
    (9, 'William', 'Martinez', '2000-12-03', 'william.martinez@email.com', 'History'),
    (10, 'Jennifer', 'Garcia', '2001-06-22', 'jennifer.garcia@email.com', 'Art');

-- Insert 10 rows into the 'courses' table
INSERT INTO courses (course_id, course_name, instructor, credits, department, semester)
VALUES
    (101, 'Introduction to Programming', 'Dr. Alan Turing', 3, 'Computer Science', 'Fall 2024'),
    (102, 'Molecular Biology', 'Dr. Rosalind Franklin', 4, 'Biology', 'Spring 2025'),
    (103, 'Calculus I', 'Dr. Isaac Newton', 4, 'Mathematics', 'Fall 2024'),
    (104, 'Cognitive Psychology', 'Dr. Jean Piaget', 3, 'Psychology', 'Spring 2025'),
    (105, 'Fundamentals of Engineering', 'Dr. Nikola Tesla', 4, 'Engineering', 'Fall 2024'),
    (106, 'Organic Chemistry', 'Dr. Marie Curie', 4, 'Chemistry', 'Spring 2025'),
    (107, 'Quantum Mechanics', 'Dr. Richard Feynman', 3, 'Physics', 'Fall 2024'),
    (108, 'Shakespeare and His Times', 'Dr. William Wordsworth', 3, 'English', 'Spring 2025'),
    (109, 'World History: Ancient Civilizations', 'Dr. Howard Zinn', 3, 'History', 'Fall 2024'),
    (110, 'Introduction to Digital Art', 'Prof. Frida Kahlo', 3, 'Art', 'Spring 2025');

-- Insert 15 rows into the 'enrollments' table
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES
    (1, 1, 101, '2024-08-15'),
    (2, 1, 103, '2024-08-15'),
    (3, 2, 102, '2024-12-20'),
    (4, 2, 106, '2024-12-20'),
    (5, 3, 103, '2024-08-16'),
    (6, 3, 107, '2024-08-16'),
    (7, 4, 104, '2024-12-21'),
    (8, 5, 105, '2024-08-17'),
    (9, 6, 106, '2024-12-22'),
    (10, 7, 107, '2024-08-18'),
    (11, 8, 108, '2024-12-23'),
    (12, 9, 109, '2024-08-19'),
    (13, 10, 110, '2024-12-24'),
    (14, 1, 105, '2024-08-20'),
    (15, 2, 104, '2024-12-25');
