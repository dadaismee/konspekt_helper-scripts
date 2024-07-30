#!/bin/bash

# Search for .csl files in the parent directory
csl_files=($(find ../ -maxdepth 1 -type f -name "*.csl" 2>/dev/null))

# function confirm_installation() {
#   read -p $'\nПривет! Этот скрипт поможет скопировать путь до нужного стиля цитирования. Чтобы это сделать, убедитесь, что:\n\n1. Вы скачали стиль цитирования в папку Service с сайта [https://www.zotero.org/styles]\n2. В названии стиля цитирования нет пробелов (!)\n\nЕсли стилей цитирования больше одного, выберите нужный, выбрав его номер и нажав Enter.\n\nНажмите Enter, чтобы продолжить, и Esc, чтобы остановить: ' -s -n 1 key
#   echo
#   if [ "$key" = "" ]; then
#     return 0
#   else
#     return 1
#   fi
# }
#
# # Check if the user wants to proceed with the installation
# confirm_installation
# if [ $? -ne 0 ]; then
#   echo "Вы отменили действие (︶︹︶)"
#   exit 1
# fi
#
# Check if there are any .csl files
if [ ${#csl_files[@]} -eq 0 ]; then
  echo 'Файлы стилей цитирования не найдены. Хотите перейти на сайт для их загрузки? Нажмите Enter для продолжения или Esc для отмены.'

  # Read user input
  read -s -n1 key
  echo

  if [ "$key" = $'\e' ]; then
    echo 'Отмена...'
    exit
  fi

  if [ "$key" = '' ]; then
    # Open the Zotero Style Repository in the default browser
    open https://www.zotero.org/styles
    echo 'Открываю репозиторий стилей Zotero в вашем браузере.'
  else
    echo 'Неверный ввод. Отмена...'
    exit
  fi
      exit 1
  fi

# If there is only one .csl file, use that
if [ ${#csl_files[@]} -eq 1 ]; then
    csl_file="${csl_files[0]}"
else
    # Prompt the user to choose a .csl file
    echo "Найдено несколько файлов. Выберите нужный:"
    select csl_file in "${csl_files[@]}"; do
        if [ -n "$csl_file" ]; then
            break
        else
            echo "Invalid choice. Please try again."
        fi
    done
fi

# Get the absolute path of the selected .csl file
absolute_path=$(realpath "$csl_file")

# Copy the selected .csl file path to the clipboard
echo -n "$absolute_path" | pbcopy

# Check if pbcopy succeeded
if [ $? -eq 0 ]; then
    echo -e "\nГотово! Можно вставлять в окно настроек плагина Pandoc в Obsidian!"
else
    echo "Failed to copy the path to the clipboard."
fi
