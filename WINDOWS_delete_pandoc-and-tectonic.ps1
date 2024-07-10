# Function to display a message and wait for user input
function Confirm-Installation {
    param (
        [string]$Message
    )

    $response = Read-Host -Prompt "$Message (y/n)"
    if ($response -match "^[Yy]$") {
        return $true
    } else {
        return $false
    }
}

# Check if the user wants to proceed with the installation
if (-not (Confirm-Installation -Message "Привет 🙌 Это скрипт-помощник «Конспекта», который установит приложения Tectonic и Pandoc. Вы хотите продолжить?")) {
    Write-Host "Вы отменили установку (︶︹︶)"
    exit 1
}

# Check if Chocolatey is installed
if (-not (Get-Command -Name "choco" -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey не найден. Установка Chocolatey..."
    Invoke-WebRequest -Uri "https://chocolatey.org/install.ps1" -OutFile "C:\Windows\Temp\choco-install.ps1"
    & "C:\Windows\Temp\choco-install.ps1"
}

# Install Tectonic using Chocolatey
if (-not (choco list --localonly | Select-String -Pattern "tectonic")) {
    Write-Host "Установка Tectonic..."
    choco install tectonic -y
}

# Install Pandoc using Chocolatey
if (-not (choco list --localonly | Select-String -Pattern "pandoc")) {
    Write-Host "Установка Pandoc..."
    choco install pandoc -y
}

Write-Host "Tectonic и Pandoc успешно установлены через Chocolatey."
