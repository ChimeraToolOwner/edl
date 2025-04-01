@echo off
setlocal

:: Check if Python is installed
py --version > NUL 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed. Please install Python and try again.
    exit /b 1
)

echo [INFO] Python is installed.

:: Ensure pip is available
py -m pip --version > NUL 2>&1
if errorlevel 1 (
    echo [INFO] Installing pip...
    py -m ensurepip --upgrade
)

echo [INFO] Pip is available.

:: Ensure virtualenv is installed
py -m pip show virtualenv > NUL 2>&1
if errorlevel 1 (
    echo [INFO] Installing virtualenv...
    py -m pip install virtualenv
)

echo [INFO] Virtualenv is available.

:: Create or activate virtual environment
if not exist .\venv\Scripts\activate.bat (
    echo [INFO] Creating virtual environment...
    py -m virtualenv .\venv
)

echo [INFO] Activating virtual environment...
call .\venv\Scripts\activate.bat

:: Install dependencies
echo [INFO] Install dependencies
pip install -r requirements.txt


:: Ensure PyInstaller is installed
pip show pyinstaller > NUL 2>&1
if errorlevel 1 (
    echo [INFO] Installing PyInstaller...
    pip install pyinstaller
)

echo [INFO] Building executable with PyInstaller...
pyinstaller --noconfirm --onefile --console --add-data "./edl:edl/" "./edlclient/Tools/fhloaderparse"

endlocal
