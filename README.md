README.MD 
# 📘 Student Database Import Script

## 🔎 Overview
This Bash script loads data from `courses.csv` and `students.csv` into the **students** PostgreSQL database.  
It ensures **majors, courses, and students** are inserted correctly and sets up their relationships.

---

## ⚙️ How it works
1. **Truncates** existing data (clears old rows).  
2. Reads **`courses.csv`**:
   - Inserts new majors and courses if they don’t exist.  
   - Links them in the `majors_courses` join table.  
3. Reads **`students.csv`**:
   - Inserts each student with their major (or `NULL` if not found).  
4. Prints a confirmation message when new records are added.  

---

## ▶️ Usage
For me only at the moment :)

