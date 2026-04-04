# First Aid Assistant CLI

A command-line first aid reference tool built with Python and MySQL. Designed to give users quick access to emergency procedures, first aid knowledge, and kit checklists, all from the terminal.

---

## 📌 About the Project

This project started as a personal challenge to build something practical using Python and a relational database. Rather than working with a tutorial dataset, I wanted the data to actually mean something, so I chose first aid procedures as the domain.

The app lets users search for emergency procedures by symptom or condition, browse procedures by medical type (neurological, respiratory, etc.), view the ABCDEs of first aid, and check what belongs in a first aid kit. All data is stored in and retrieved from a MySQL database.

---

## 🛠️ Tech Stack

- **Python 3.13** — core application logic
- **MySQL** — relational database for all first aid data
- **mysql-connector-python** — database connection and query execution
- **python-dotenv** — secure credential management via `.env` file

---

## ⚙️ Features

- 🔍 **Symptom search** — search by condition name or symptom (e.g. "not breathing", "chest pain")
- 🧠 **Synonym normalisation** — maps casual descriptions to correct medical terms and expands a single keyword into multiple related conditions
- 📂 **Browse by type** — filter procedures by medical category (neurological, cardiovascular, respiratory, etc.)
- 🔤 **ABCDEs of First Aid** — quick reference to the foundational first aid framework
- 🎒 **First aid kit checklist** — list of essential items with their purpose
- ⚠️ **Emergency flag** — procedures that require calling emergency services are clearly flagged
- 🔄 **Menu-driven navigation** — clean loop-based CLI with back navigation

---

## 🗄️ Database Schema

The app uses five tables:

| Table | Purpose |
|---|---|
| `procedures` | Core first aid steps, symptoms, warnings, emergency flag |
| `type` | Medical type categories (neurological, respiratory, etc.) |
| `categories` | Severity levels (emergency, minor-emergency, minor) |
| `abcdes` | The ABCDEs of first aid reference data |
| `first_aid_kit` | First aid kit items and their purposes |

---

##  How to Run

### Prerequisites
- Python 3.13 installed
- MySQL server running locally
- The following packages installed:

```bash
pip install mysql-connector-python python-dotenv
```

### Setup

**1. Clone the repository**
```bash
git clone https://github.com/tuse-ngumimi/First-Aid-Tool.git
cd First-Aid-Tool
```

**2. Create a `.env` file** in the project root with your database credentials:
```
DB_HOST=localhost
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
DB_NAME=first_aid_app
```

**3. Set up the database**

Run the SQL scripts in your MySQL client to create and populate the tables. The schema files are included in the `/database` folder.

**4. Run the app**
```bash
python main.py
```

---

## 📁 Project Structure

```
first_aid_app/
│
├── main.py            # Entry point, menu logic and navigation
├── search_db.py       # All database query functions + synonym normalisation
├── display.py         # Formats and prints procedure results
├── database_conn.py   # Database connection with env variable validation
├── .env               # Credentials (not committed to GitHub)
└── database/
    └── schema.sql     # Table definitions and seed data
```

---

##  The Process

I started by designing the MySQL schema, figuring out which data belonged in its own table, and how the tables related to each other. The `procedures` table came first, then I added `type` later after realising I needed a way to distinguish medical categories (neurological, cardiovascular, etc.) from severity levels (emergency, minor).

Building the Python side involved a lot of debugging. Fixing broken virtual environments, Python interpreter mismatches, and module import errors across files. Each bug taught me something concrete about how Python resolves packages and why environment management matters.

The synonym normalisation feature came from a real usability problem: a user searching "chest pain" or "not breathing" wouldn't necessarily know the medical term for what they were looking for. The solution was a dictionary that maps plain-language phrases to a list of matching conditions, which the search function then queries dynamically.

---

## 📚 What I Learned

- How to design a normalised relational database schema from scratch
- Writing parameterised SQL queries in Python to prevent SQL injection
- Managing database connections safely with `try/finally` blocks
- Why `conn.commit()` is required for INSERT/UPDATE/DELETE but not SELECT
- How Python virtual environments work and how to troubleshoot them
- The difference between `WHERE column =` and `WHERE column IN ()` for single vs multiple values
- How to use CTEs and JOINs to write cleaner, more readable SQL
- Structuring a multi-file Python project with clear separation of concerns

---

## Future Mods

- Add a Streamlit UI layer for a web-based interface
- Expand the synonym dictionary with more common descriptions
- Add a Nigeria-specific emergency contacts section
- Integrate search analytics to track the most queried conditions

---

##  Author

**Ngumimi Bethel Tuse**  
Python Developer  
GitHub: [@tuse-ngumimi](https://github.com/tuse-ngumimi)  
Instagram: [@bethel.builds](https://instagram.com/bethel.builds)
