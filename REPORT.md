# HealthGuardAI: Early Disease Risk Predictor 🎯

Welcome to the **HealthGuardAI** repository, developed for the Swarajya Hack Fest (Problem Statement: PS-07). 

This AI-driven healthcare tool aims to predict possible health risks based on critical lifestyle indicators (Age, BMI, Diet, Activity, Sleep) and directly outputs actionable, preventive health insights to the user through a secure, visual dashboard.

---

## 🔐 Demo Credentials

To immediately view the persistent dashboard tracking capabilities, you can log in using the pre-configured credentials:
* **Username**: `test_user`
* **Password**: `password123`

---

## 🧠 Presentation Guide (Key Concepts Explained)

If judges ask about the logic behind the health indicators and risk generation, use these talking points:

### What is BMI (Body Mass Index)?
- **Definition**: BMI is a mathematical formula that relates a person's weight to their height. It is calculated identically across all genders by dividing weight in kilograms by height in meters squared ($kg/m^2$).
- **Why it matters**: It is a globally recognized, rapid screening tool used to categorize individuals into weight classes: Underweight (18.5 and under), Normal weight (18.5 - 24.9), Overweight (25 - 29.9), and Obese (30 and over).
- **In our ML Engine**: Extended periods of high BMI heavily correlate with an increased risk of metabolic diseases (like Type 2 Diabetes and cardiovascular issues). Our algorithm flags BMIs of 25 and above, combining this with low exercise/diet scores to generate accurate "High Risk" warnings and tailored calorie-deficit advice.

### The Diet Score (1 to 10)
- **Concept**: Instead of asking users to painstakingly track exact calories, we simplify the User Experience by asking for a subjective 1-10 Diet Score (1 being constant fast food, 10 being perfectly balanced whole foods).
- **Why it matters**: A score of 8-10 implies a diet high in whole foods and greens, acting as a "protective factor" against cardiovascular risk. A score below 5 implies high intake of processed sugars/fats, triggering the AI engine to advise immediate dietary restructuring.

### The Sleep and Exercise Metrics
- **Biological Impact**: Less than 6 hours of sleep significantly impacts insulin resistance and raises stress hormones (cortisol). Similarly, less than 3 hours of exercise per week drastically weakens cardiovascular endurance.
- **In our ML Engine**: These features are numerically scaled by our `StandardScaler` and passed into our `LogisticRegression` matrix. When both are abnormally low over time, the model exponentially increases the probability of classifying the user's trajectory as "High Risk."

### Security & Data Privacy (Crucial for PS-07)
- **Problem Statement Challenge**: "Protecting sensitive health data" is explicitly stated as a key challenge.
- **Our Solution**: We don't store plain-text passwords or generic access points. We use modern `bcrypt` cryptography to one-way hash user credentials deep in the database. To keep the session explicitly secure, we issue a `JWT (JSON Web Token)` bearing a short expiration timestamp that authenticates every single database fetch. This guarantees that user health data absolutely cannot be intercepted or queried by bad actors!

---

## 🛠️ Tech Stack & Purpose

The architecture is divided into a robust split-stack environment to isolate machine-learning workloads from the real-time React UI.

### Frontend
- **React (Vite):** Chosen for lightning-fast Hot Module Replacement (HMR) and an ultra-lean build size.
- **Vanilla CSS:** Built with custom CSS Variables to guarantee a premium dark theme without the overhead of bulk utility frameworks like Tailwind.
- **Recharts (Lucide-React):** Used specifically for the "Risk Prediction Dashboard" requirement, gracefully visualizing the SQLite historic timelines through smooth interactive SVG graphs.

### Backend & Machine Learning
- **FastAPI (Python):** Deployed for asynchronous, incredibly fast API request handling, utilizing built-in Pydantic schema validation to securely ingest raw patient data.
- **SQLAlchemy (SQLite):** Serves as our persistent relational database, cleanly mapping `User` instances to their historic `HealthRecord` objects.
- **Scikit-Learn (Joblib):** The core AI engine. We implemented a `StandardScaler` piped into a `LogisticRegression` algorithm, dynamically saved to a `.pkl` file to perform real-time localized inferences without high-latency cloud processing.
- **Passlib/Bcrypt (Python-Jose):** Ensures that patient data is totally obscured by encrypting user passwords in the DB and mediating API requests through secure, expiring JSON Web Tokens (JWT).

---

## ⚙️ How It Works (The Pipeline)

1. **Authentication:** A user navigates to the React app and signs in. The FastAPI backend authenticates the Bcrypt-hashed password and returns a `JWT Bearer Token`.
2. **Data Collection:** The user submits their current lifestyle info (Sleep, BMI, Diet Score) via the React `AssessmentForm`.
3. **ML Inference:** The backend route `POST /predict` receives the array. The Scikit-Learn pipeline deserializes `healthguard_model.pkl`, scales the input features, and returns an overarching Risk Level (High, Medium, Low).
4. **Insights Engine:** A python rule-based engine evaluates the individual data points (e.g. `BMI > 30`) to dynamically string together specific preventive recommendations.
5. **Persistence:** The entire payload is saved to the SQLite database. 
6. **Dashboard:** The user navigates to "My History", where the UI fetches the historic data blocks and maps them into the Recharts Visualizer to trend their lifestyle improvements!

---

## 🚀 How to Run Locally (Step-by-Step)

### Prerequisites:
- Install [Node.js](https://nodejs.org/) (Ensure `npm` is in your PATH).
- Install [Python 3.10+](https://www.python.org/downloads/) (Ensure `python3` and `pip` are in your PATH).

### Step 1: Clone the Repository
Open a terminal (or Git Bash/PowerShell on Windows) and clone the repository to your local machine:
```bash
git clone <your-repo-link>
cd HealthGuardAI
```

### Step 2: Install Dependencies & Run Seamlessly!
We have bundled unified start scripts that automatically handle spinning up both the FastAPI Python Backend and the React Frontend simultaneously. 

**For Windows Users:**
Just double-click the `start.bat` file in the main folder, or run this from your Command Prompt/PowerShell:
```cmd
start.bat
```
*(This script will also automatically install any missing frontend and backend packages!)*

**For Mac / Linux Users:**
Run this single command from the root of the project:
```bash
./start.sh
```

### Step 3: Interact!
Once the script is running, open your browser and navigate to the local link provided by Vite:
👉 `http://localhost:5173/`

Click **"Sign In/Register"**, create a new test account, and start generating your AI predictive health insights across your personal interactive dashboard!
