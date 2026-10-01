@echo off
REM 一键启动 OmniVoice：自动检测 NVIDIA 显卡，选择 GPU 或 CPU 模式
cd /d "%~dp0"
where nvidia-smi >nul 2>nul
if %errorlevel%==0 (
    echo [OmniVoice] NVIDIA GPU detected, starting in GPU mode...
    docker compose up -d --build
) else (
    echo [OmniVoice] No NVIDIA GPU found, starting in CPU mode...
    docker compose -f docker-compose.yml -f docker-compose.cpu.yml up -d --build
)
if errorlevel 1 (
    echo [OmniVoice] Failed to start. Is Docker Desktop running?
    pause
    exit /b 1
)
echo.
echo [OmniVoice] Started. First launch downloads models (several GB), please wait.
echo [OmniVoice] Open http://localhost:7860   Logs: docker compose logs -f
pause
