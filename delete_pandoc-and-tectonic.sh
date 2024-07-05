#!/bin/bash

# Function to display a message and wait for user input
function confirm_uninstallation() {
  read -p "$1 (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Check if the user wants to proceed with the uninstallation
confirm_uninstallation "Привет! 🙌 Это скрипт-помощник «Конспекта», который удалит приложения Tectonic и Pandoc, установленные через Homebrew. Вы хотите продолжить?"
if [ $? -ne 0 ]; then
  echo "Вы отменили удаление (︶︹︶)"
  exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew не найден. Пропуск удаления Tectonic и Pandoc."
  exit 0
fi

# Uninstall Tectonic
if brew list tectonic &>/dev/null; then
  echo "Удаление Tectonic..."
  brew remove tectonic
else
  echo "Tectonic не найден. Пропуск удаления Tectonic."
fi

# Uninstall Pandoc
if brew list pandoc &>/dev/null; then
  echo "Удаление Pandoc..."
  brew remove pandoc
else
  echo "Pandoc не найден. Пропуск удаления Pandoc."
fi

echo "Tectonic и Pandoc успешно удалены. 🙃"
