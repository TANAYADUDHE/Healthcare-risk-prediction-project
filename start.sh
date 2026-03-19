#!/bin/bash

# ==========================================================
# HealthGuardAI: Full Application Runner
# This script starts both the FastAPI Backend and React Frontend.
# ==========================================================

echo "🚀 Starting HealthGuardAI..."

# 1. Start the FastAPI Backend in the background
echo "-> Booting Python Backend (Port 8000)..."
cd backend
# Activate the virtual environment
source venv/bin/activate
# Run Uvicorn in the background using &
uvicorn main:app --reload --port 8000 &
BACKEND_PID=$!
echo "✓ Backend running (PID: $BACKEND_PID)"

# Go back to the root directory
cd ..

# 2. Start the React Frontend in the foreground
echo "-> Booting React Frontend (Port 5173)..."
cd frontend
# Run the Vite dev server
npm run dev

# 3. Cleanup: When the user presses Ctrl+C to stop the frontend, kill the background backend process too.
trap "echo 'Shutting down HealthGuardAI...'; kill $BACKEND_PID; exit" INT TERM
