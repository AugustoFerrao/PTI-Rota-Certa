___
@echo off
echo =============================================
echo 🚀 Iniciando projeto "Rota Certa"
echo =============================================

:: === BACKEND ===
echo 🔧 Configurando Backend (FastAPI)...

cd backend

:: Verifica e cria venv se não existir
IF NOT EXIST "venv" (
    echo 🛠️ Criando ambiente virtual...
    python -m venv venv
)

:: Ativa o venv e instala dependências
call venv\Scripts\activate

echo 📦 Instalando dependências do Backend...
pip install --upgrade pip
pip install -r requirements.txt

echo ▶️ Iniciando Backend em nova janela...
start cmd /k "call venv\Scripts\activate && uvicorn app.main:app --reload"

cd ..

:: === FRONTEND ===
echo 🔧 Configurando Frontend (React)...

cd frontend

:: Verifica se Node está instalado
where node >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ ERRO: Node.js não está instalado. Instale em: https://nodejs.org/
    pause
    exit /b
)

:: Instala dependências do React
IF NOT EXIST "node_modules" (
    echo 📦 Instalando dependências do Frontend...
    npm install
)

echo ▶️ Iniciando Frontend em nova janela...
start cmd /k "npm run dev"

cd ..

echo =============================================
echo ✅ Projeto iniciado com sucesso!
echo Backend: http://localhost:8000/docs
echo Frontend: http://localhost:5173/
echo =============================================
pause