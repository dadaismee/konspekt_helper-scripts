#!/bin/bash
#
# Function to display a message and wait for user input
function confirm_installation() {
  read -p $'Привет! 🙌\n\nЭто скрипт-помощник «Конспекта», который установит утилиты Tectonic и Pandoc, нужные для конвертации документов в PDF, docx и веб-страницы. \n\nНажмите Enter, чтобы продолжить, или Esc, чтобы отменить: ' -s -n 1 key
  echo
  if [ "$key" = "" ]; then
    return 0
  else
    return 1
  fi
}

# Check if the user wants to proceed with the installation
confirm_installation
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
  echo -e "\n → Tectonic уже установлен, ура! Это значит, что его не нужно устанавливать и можно начать им пользоваться!"
else
  echo -e "\n → Установка Tectonic..."
  brew install tectonic
fi

# Install Pandoc
if command -v pandoc &>/dev/null; then
  echo -e "\n → Pandoc тоже уже установлен, а это значит, что им тоже можно начать пользоваться!"
else
  echo -e "\n → Установка Pandoc..."
  brew install pandoc
fi

export PATH="$(brew --prefix)/bin:$PATH"

echo -e "\n → Tectonic и Pandoc успешно установлены и готовы к работе! Хорошего дня! 🙃"

