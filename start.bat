@echo off
echo ==========================================================
echo HealthGuardAI: Full Application Runner (Windows)
echo ==========================================================

echo [1/2] Starting Python Backend on Port 8000...
cd backend

:: Create Virtual Environment if it doesn't exist
if not exist venv (
    echo Creating Python Virtual Environment...
    python -m venv venv
)

:: Activate venv and install dependencies
call venv\Scripts\activate.bat
echo Installing Backend Dependencies...
pip install -r requirements.txt

:: Start the backend in a new terminal window
start "HealthGuardAI Backend" cmd /c "uvicorn main:app --reload --port 8000"

cd ..

echo [2/2] Starting React Frontend on Port 5173...
cd frontend

:: Install frontend dependencies
echo Installing Frontend Dependencies...
call npm install

:: Start the frontend
echo Booting React Frontend...
call npm run dev
