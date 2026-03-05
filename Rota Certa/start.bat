@echo off
echo =============================================
echo 🚀 Iniciando projeto "Rota Certa"
echo =============================================

:: === DETECTAR IPV4 (adaptador de rede ativo) ===
set IP=
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /R /C:"IPv4.*"') do (
    set IP=%%A
    goto :IP_OK
)
:IP_OK
:: Remove espaços
set IP=%IP: =%
echo 🌐 IP detectado: %IP%

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
start cmd /k "call venv\Scripts\activate && uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload"

cd ..

:: === FRONTEND ===
echo 🔧 Configurando Frontend (React)...

cd frontend

:: Cria/atualiza arquivo .env com IP detectado
if exist .env del .env
(
echo VITE_API_URL=http://%IP%:8000
) > .env
echo 📄 Arquivo .env atualizado com IP: %IP%

:: Verifica se Node.js está instalado
where node >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ ERRO: Node.js não está instalado.
    echo 🌐 Abrindo site oficial para download...
    start https://nodejs.org/en/download/prebuilt-installer
    pause
    exit /b
)

:: Instala dependências do React se necessário
IF NOT EXIST "node_modules" (
    echo 📦 Instalando dependências do Frontend...
    npm install
)

echo ▶️ Iniciando Frontend em nova janela...
start cmd /k "npm run dev -- --host=0.0.0.0"

cd ..

echo =============================================
echo ✅ Projeto iniciado com sucesso!
echo Backend: http://%IP%:8000/docs
echo Frontend: http://%IP%:5173/
echo =============================================
pause