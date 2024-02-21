REM remove logs
REM @echo off

REM change to supported node version
nvm use 20.11.0

REM start MySQL service (could be replaced with just running the docker image of MySQL)
net start mysql
REM to end the service after use, run "net stop mysql"

REM Enter the frontend directory and run "npm run dev"
set "frontend=%~dp0BudgetBuddy_frontend"
cd "%frontend%"
start cmd /k "npm install && npm run dev"

REM Exit the frontend directory and enter the backend directory, run "npm start"
set "backend=%~dp0BudgetBuddy_backend"
cd "%backend%"
start cmd /k "npm install && npm start"

REM Open the webpage in the default browser
start "" "http://localhost:3000"
