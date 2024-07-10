# Function to display a message and wait for user input
function Confirm-Installation {
    param (
        [string]$Message
    )

    $response = Read-Host -Prompt $Message
    if ($response -match "^[Yy]$") {
        return $true
    } else {
        return $false
    }
}

# Check if the user wants to proceed with the installation
$confirmationMessage = $'Привет! 🙌\n\nЭто скрипт-помощник «Конспекта»?, который установит утилиты Tectonic и Pandoc.\n\nВы хотите продолжить? (y/n) '
if (-not (Confirm-Installation -Message $confirmationMessage)) {
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
if (choco list --localonly | Select-String -Pattern "tectonic") {
    Write-Host "Tectonic уже установлен, ура! Это значит, что его не нужно устанавливать и можно начать им ползоваться!"
} else {
    Write-Host "Установка Tectonic..."
    choco install tectonic -y
}

# Install Pandoc using Chocolatey
if (choco list --localonly | Select-String -Pattern "pandoc") {
    Write-Host "Pandoc тоже уже установлен, а это значит, что им тоже можно начать пользоваться!"
} else {
    Write-Host "Установка Pandoc..."
    choco install pandoc -y
}

Write-Host "Tectonic и Pandoc успешно установлены и готовы к работе! Хорошего дня! 🙃"

