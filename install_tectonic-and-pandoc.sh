#!/bin/bash

# Function to display a message and wait for user input
function confirm_installation() {
  read -p "$1 (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Check if the user wants to proceed with the installation
confirm_installation "Привет! 🙌 Это скрипт-помощник «Конспекта», который установит приложения Tectonic и Pandoc. Вы хотите продолжить?"
if [ $? -ne 0 ]; then
  echo "Вы отменили установку (︶︹︶)"
  exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew не найден. Установка Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Tectonic
if command -v tectonic &>/dev/null; then
  echo "Tectonic уже установлен. Пропуск установки Tectonic."
else
  echo "Установка Tectonic..."
  brew install tectonic
  sudo mv tectonic /usr/local/bin
fi

# Install Pandoc
if command -v pandoc &>/dev/null; then
  echo "Pandoc уже установлен. Пропуск установки Pandoc."
else
  echo "Установка Pandoc..."
  brew install pandoc
  sudo mv pandoc /usr/local/bin
fi

echo "Tectonic и Pandoc успешно установлены и готовы к работе! 🙃"
