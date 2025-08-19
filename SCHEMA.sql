
CREATE TABLE Department (
  idDepartment INT NOT NULL AUTO_INCREMENT,
  `Department Name` VARCHAR(100) NOT NULL,
  `Office Number` INT,
  -- The following columns look like denormalized reverse links; retained as in file
  Course_idCourses INT NULL,
  Sections_idSections INT NULL,
  `Sections_Sectionscol1` VARCHAR(45) NULL,
  PRIMARY KEY (idDepartment),
  UNIQUE KEY uq_department_name (`Department Name`)
) ENGINE=InnoDB;

-- =========================
-- Table: Courses
-- =========================
CREATE TABLE Courses (
  idCourses INT NOT NULL AUTO_INCREMENT,
  `Course Name` VARCHAR(100) NOT NULL,
  Coursescol VARCHAR(100) NULL,
  Department_idDepartment INT NULL,
  `Department_Course_idCourses` INT NULL,
  Grade_idGrade1 INT NULL,
  PRIMARY KEY (idCourses)
) ENGINE=InnoDB;

-- =========================
-- Table: Sections
-- =========================
CREATE TABLE Sections (
  idSections INT NOT NULL AUTO_INCREMENT,
  Sectionscol VARCHAR(45) NULL,
  Depratment_idDepartment INT NULL, -- spelling retained from snippet
  Sectionscol1 VARCHAR(45) NULL,
  PRIMARY KEY (idSections)
) ENGINE=InnoDB;

-- =========================
-- Table: Student
-- =========================
CREATE TABLE Student (
  idStudent INT NOT NULL AUTO_INCREMENT,
  StudentName VARCHAR(45) NOT NULL,
  `Student Phone no` VARCHAR(45) NULL,
  Course VARCHAR(45) NULL,            -- denormalized course name/code per snippet
  Course_idCourses INT NULL,          -- FK link to Courses
  -- “8 more...” in the snippet: add common student attributes as nullable placeholders
  SSN VARCHAR(20) NULL,
  StudentNumber VARCHAR(30) NULL,
  CurrentAddress VARCHAR(200) NULL,
  CurrentPhone VARCHAR(45) NULL,
  PermanentAddress VARCHAR(200) NULL,
  PermanentPhone VARCHAR(45) NULL,
  BirthDate DATE NULL,
  Sex VARCHAR(10) NULL,
  Class VARCHAR(20) NULL,
  MajorDepartment VARCHAR(100) NULL,
  MinorDepartment VARCHAR(100) NULL,
  DegreeProgram VARCHAR(20) NULL,
  PermCity VARCHAR(60) NULL,
  PermState VARCHAR(60) NULL,
  PermZIP VARCHAR(15) NULL,
  PRIMARY KEY (idStudent)
) ENGINE=InnoDB;

-- =========================
-- Table: Grade
-- =========================
CREATE TABLE Grade (
  idGrade INT NOT NULL AUTO_INCREMENT,
  Student_id INT NULL,          -- FK to Student
  SubjectName VARCHAR(100) NULL,
  Course VARCHAR(45) NULL,      -- denormalized per snippet
  `Grade` VARCHAR(45) NULL,     -- letter or text grade
  PRIMARY KEY (idGrade)
) ENGINE=InnoDB;

-- =========================
-- Foreign Keys (as derivable from names)
-- Note: Some columns look like redundant reverse links; FK constraints added only
-- where direction is clear and does not create circular dependency without purpose.
-- =========================

-- Courses → Department
ALTER TABLE Courses
  ADD CONSTRAINT fk_courses_department
    FOREIGN KEY (Department_idDepartment)
    REFERENCES Department(idDepartment)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

-- Sections → Department (note: 'Depratment' spelling kept to match column)
ALTER TABLE Sections
  ADD CONSTRAINT fk_sections_department
    FOREIGN KEY (Depratment_idDepartment)
    REFERENCES Department(idDepartment)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

-- Student → Courses
ALTER TABLE Student
  ADD CONSTRAINT fk_student_course
    FOREIGN KEY (Course_idCourses)
    REFERENCES Courses(idCourses)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

-- Grade → Student
ALTER TABLE Grade
  ADD CONSTRAINT fk_grade_student
    FOREIGN KEY (Student_id)
    REFERENCES Student(idStudent)
    ON UPDATE CASCADE
    ON DELETE CASCADE;
    
CREATE INDEX idx_student_name ON Student(StudentName);
CREATE INDEX idx_student_ssn ON Student(SSN);
CREATE INDEX idx_student_studentnumber ON Student(StudentNumber);
CREATE INDEX idx_courses_name ON Courses(`Course Name`);
CREATE INDEX idx_department_name ON Department(`Department Name`);
CREATE INDEX idx_grade_student ON Grade(Student_id);
